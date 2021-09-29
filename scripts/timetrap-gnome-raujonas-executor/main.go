package main

import (
	"fmt"
	"io"
	"os"
	"os/exec"
	"strings"
	"regexp"
)

var timeRegex = regexp.MustCompile("(?:(?:[0-9]+:)+[0-9]+)")
var percentageRegex = regexp.MustCompile("(?:[0-9]+)%")

func main() {
	dayOutput, err := execCmd("timetrap", "display", "all", "--format", "day")
	if err != nil {
		printErr(err)
		os.Exit(1)
	}

	nowOutput, err := execCmd("timetrap", "now")
	if err != nil {
		printErr(err)
		os.Exit(1)
	}

	nowColor := "gray"
	nowString := nowOutput.stderr
	if nowOutput.stdout != "" {
		nowColor = "lime"
		nowString = nowOutput.stdout
	}
	nowString = strings.TrimSpace(nowString)

	dayBytes := []byte(dayOutput.stderr)
	if dayOutput.stdout != "" {
		dayBytes = []byte(dayOutput.stdout)
	}

	timeString := string(timeRegex.Find(dayBytes))
	percentageString := string(percentageRegex.Find(dayBytes))

	var sb strings.Builder
	sb.WriteString("<executor.markup.true>")
	sb.WriteString(" <span foreground='")
	sb.WriteString(nowColor)
	sb.WriteString("'>")
	sb.WriteString(nowString)
	sb.WriteString("</span>")

	sb.WriteString(" | <span>")
	sb.WriteString(timeString)
	sb.WriteString("</span>")
	sb.WriteString(" | <span>")
	sb.WriteString(percentageString)
	sb.WriteString("</span>")

	fmt.Print(sb.String())
}

func printErr(err error) {
	var sb strings.Builder
	sb.WriteString("<executor.markup.true>")
	sb.WriteString(" <span foreground='red'>err: ")
	sb.WriteString(err.Error())
	sb.WriteString("</span>")
}

type cmdResult struct {
	stderr string
	stdout string
}

func execCmd(name string, args ...string) (cmdResult, error) {
	cmd := exec.Command(name, args...)

	stderrPipe, err := cmd.StderrPipe()
	if err != nil {
		return cmdResult{}, err
	}
	stdoutPipe, err := cmd.StdoutPipe()
	if err != nil {
		return cmdResult{}, err
	}

	if err := cmd.Start(); err != nil {
		return cmdResult{}, err
	}

	stderr, err := io.ReadAll(stderrPipe)
	if err != nil {
		return cmdResult{}, err
	}

	stdout, err := io.ReadAll(stdoutPipe)
	if err != nil {
		return cmdResult{}, err
	}

	if err := cmd.Wait(); err != nil {
		return cmdResult{}, err
	}

	return cmdResult{
		stdout: string(stdout),
		stderr: string(stderr),
	}, nil
}
