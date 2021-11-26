package main

import (
	"errors"
	"fmt"
	"html"
	"io"
	"os"
	"os/exec"
	"strconv"
	"strings"
	"time"

	"github.com/jilleJr/go-timetrap/pkg/timetrap"
)

func main() {
	config, err := timetrap.NewConfigLocal()
	if err != nil {
		printErr(err)
		os.Exit(1)
	}
	if config.DatabaseFile == "" {
		printErr(fmt.Errorf("err: no database file specified in config: %s", timetrap.DefaultConfigPath))
		os.Exit(1)
	}

	db, err := timetrap.NewDB(config.DatabaseFile)
	if err != nil {
		printErr(err)
		os.Exit(1)
	}

	currentSheet, err := db.GetCurrentSheet()
	if err != nil {
		printErr(err)
		os.Exit(1)
	}

	active, err := db.GetActiveEntry()
	hasActive := true
	if errors.Is(err, timetrap.ErrNotFound) {
		hasActive = false
	} else if err != nil {
		printErr(err)
		os.Exit(1)
	}

	now := time.Now()
	today := time.Date(now.Year(), now.Month(), now.Day(), 0, 0, 0, 0, now.Location())
	entries, err := db.GetEntriesTimeRange(today, today.Add(24*time.Hour))

	var sumTimes time.Duration
	for _, entry := range entries {
		sumTimes += entry.Duration()
	}

	dayLength := time.Hour * time.Duration(config.DayLengthHours)
	dayPercentage := int64(100 * sumTimes / dayLength)

	var sb strings.Builder
	sb.WriteString("<executor.markup.true>")
	sb.WriteString(" <span foreground='")
	if hasActive {
		sb.WriteString("lime")
	} else {
		sb.WriteString("gray")
	}
	sb.WriteString("'>")
	if hasActive {
		sb.WriteRune('*')
		sb.WriteString(html.EscapeString(currentSheet))
		sb.WriteString(": ")
		sb.WriteString(FormatDuration(active.Duration()))
		if active.Note != nil {
			sb.WriteString(" (")
			sb.WriteString(html.EscapeString(*active.Note))
			sb.WriteRune(')')
		}
	} else {
		sb.WriteRune('*')
		sb.WriteString(html.EscapeString(currentSheet))
		sb.WriteString(": not running")
	}
	sb.WriteString("</span>")

	sb.WriteString(" | <span>")
	sb.WriteString(FormatDuration(sumTimes))
	sb.WriteString("</span>")
	sb.WriteString(" | <span>")
	sb.WriteString(strconv.FormatInt(dayPercentage, 10))
	sb.WriteRune('%')
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

func FormatDuration(d time.Duration) string {
	totalSeconds := int64(d / time.Second)
	var b []byte

	b = strconv.AppendInt(b, totalSeconds/3600, 10)

	b = append(b, ':')

	minutes := totalSeconds / 60 % 60
	if minutes < 10 {
		b = append(b, '0')
	}
	b = strconv.AppendInt(b, minutes, 10)

	b = append(b, ':')

	seconds := totalSeconds % 60
	if seconds < 10 {
		b = append(b, '0')
	}
	b = strconv.AppendInt(b, seconds, 10)

	return string(b)
}
