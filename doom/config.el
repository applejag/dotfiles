;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Kalle Fagerberg"
      user-mail-address "kalle.fagerberg@iver.se")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq inferior-fsharp-program "dotnet fsi --readline-")

(setq lsp-yaml-schemas '(https://iver-wharf.github.io/_static/wharf-ci-schema.json ".wharf-ci.yml"))
;;(setq lsp-yaml-schemas '(/home/kalle/dev/wharf/iver-wharf.github.io/docs/_static/wharf-ci-schema.json ".wharf-ci.yml"))

(setq lsp-clients-emmy-lua-java-path "/usr/bin/java")
(setq lsp-clients-emmy-lua-jar-path (expand-file-name "EmmyLua-LS-all.jar" user-emacs-directory))

;; omnisharp fix
(setq omnisharp-server-executable-path "~/.doom.d/start-omnisharp.sh")

;; Workaround for gofmt-on-save bug
;; https://github.com/hlissner/doom-emacs/issues/4201#issuecomment-735222478
(after! go-mode
  (setq gofmt-command "goimports")
  (add-hook 'go-mode-hook
            (lambda ()
              (add-hook 'after-save-hook 'gofmt nil 'make-it-local))))

(custom-set-variables
 '(markdown-toc-header-toc-title "## Table of contents")
 '(markdown-toc-indentation-space 2))

(setq-default display-fill-column-indicator-column 80)
(global-display-fill-column-indicator-mode 1)

(set-frame-parameter nil 'undecorated t)

;; If I only want it for markdown-mode
;; (add-hook 'markdown-mode-hook 'display-fill-column-indicator-mode)

;; Whitespace display
;(setq whitespace-style (default-value 'whitespace-style))
(setq whitespace-style '(face tabs tab-mark spaces trailing lines-tail space-before-tab space-after-tab))
;(setq whitespace-display-mappings (default-value 'whitespace-display-mappings))
(setq-default
  whitespace-display-mappings 
 '((tab-mark ?\t [?› ?\t])
   (newline-mark 10 [?¬ 10])
   (space-mark 32 [183] [46])))

(setq whitespace-global-modes t)
(global-whitespace-mode)
