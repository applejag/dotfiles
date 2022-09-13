#!/bin/sh

set -x

go install golang.org/x/tools/gopls@latest # Language server
go install github.com/nsf/gocode@latest # Autocompletion daemon
go install github.com/mdempsky/gocode@latest   # for code completion
go install github.com/fatih/gomodifytags@latest # Modify struct field tags
go install github.com/cweill/gotests/gotests@latest # Test generation
go install github.com/x-motemen/gore/cmd/gore@latest # REPL
go install golang.org/x/tools/cmd/guru@latest # Definitions/references navigation + refactoring
go install golang.org/x/tools/cmd/goimports@latest # Formatting imports

# golangci-lint is not installed from source as they find it unreliable
# More info: https://golangci-lint.run/usage/install/#install-from-source
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.46.2

