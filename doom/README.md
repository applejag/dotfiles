# Doom Emacs

## go-mode

### Dependencies

```sh
# The -u flag makes it a "get or update"
go get -u golang.org/x/tools/gopls # Language server
go get -u github.com/nsf/gocode # Autocompletion daemon
go get -u github.com/fatih/gomodifytags # Modify struct field tags
go get -u github.com/cweill/gotests/gotests # Test generation
go get -u github.com/motemen/gore/cmd/gore # REPL
go get -u golang.org/x/tools/cmd/guru # Definitions/references navigation + refactoring
go get -u golang.org/x/tools/cmd/goimports # Formatting imports

# golangci-lint is not installed from source as they find it unreliable
# More info: https://golangci-lint.run/usage/install/#install-from-source
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.35.0
```

### Enable format on save

Will use `goimports` if available. Fallbacks to `gofmt`. Formatter used is
evaluated on startup of emacs.

Persistently enables formatting on save:

```emacs
M-x gofmt-before-save
```

