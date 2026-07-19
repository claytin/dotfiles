;; Avoid encoding issues across OSs
(prefer-coding-system 'utf-8-unix)
(setq coding-system-for-read 'utf-8-unix)
(setq coding-system-for-write 'utf-8-unix)

;; Constants
(defconst custom-settings (expand-file-name "custom.d" user-emacs-directory)
  "Path to files that separate custom settings")

(defconst mip-prefix (expand-file-name "mip" user-emacs-directory)
  "Path to the directory of (M)anually (I)nstalled (P)ackages")

;; Package handling ------------------------------------------------------------
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(unless package-archive-contents (package-refresh-contents))

(package-initialize)

;; Bootstrap packages
(unless (package-installed-p 'ligature)
  (package-install 'ligature))

(unless (package-installed-p 'solarized-theme)
  (package-install 'solarized-theme))

;; A minor mode for structural edinting for lisps. Each language should enable
;; paredit on demand, using a hook to its major mode.
(unless (package-installed-p 'paredit)
  (package-install 'paredit))

;; (E)macs Poly(glot) lsp client
(unless (package-installed-p 'eglot)
  (package-install 'eglot))

;; Package handling ends here --------------------------------------------------


;; GUI options -----------------------------------------------------------------
;; Hide tool bar
(tool-bar-mode -1)

;; Hide scroll bar
(scroll-bar-mode -1)

;; Hide menu bar
(menu-bar-mode -1)

;; Don't show emacs default buffer
(setq inhibit-startup-screen t)

;; Geometry
(add-to-list 'default-frame-alist (cons 'width 100))
(add-to-list 'default-frame-alist (cons 'height 40))

;; Ruler
;;;; Set fill-column (reference for line breaking and wrapping)
(setq-default fill-column 80)

;; Show column numbers in mode-line
(setq column-number-mode t)

;; Display line numbers on buffers in programming mode
(add-hook 'prog-mode-hook
		  'display-line-numbers-mode)

(add-hook 'prog-mode-hook
		  (lambda () (ruler-mode 1)))

;; Highlight current line
(global-hl-line-mode t)

;; Colors
(load-theme 'solarized-light t)

;; Font
(cond ((eq system-type 'windows-nt)
       (add-to-list 'default-frame-alist
                    '(font . "JetBrainsMono NF-10")))
      ((eq system-type 'gnu/linux)
       (add-to-list 'default-frame-alist
                    '(font . "JetBrains Mono-10")))
      ((eq system-type 'darwin)
       (message "We on a Mac now!?"))
      (t (message "We on BSD BABY!")))

;; Ligatures
(use-package ligature
  :config
  ;; lets start with a global config and refine it later
  (ligature-set-ligatures 't '("==" "===" "=/=" ">=" "<=" "&&" "&=" "++" "+++"
                               "***" ";;" "?=" "<<" ">>" "<>" ">>>" "<<<" "||"
                               "|=" "||=" "#!" "^=" "<$>" "<$" "$>" "<+>" "<+"
                               "+>" "<*>" "<*" "*>" "</" "/>" "</>" "<!--"
                               "<#--" "-->" "->" "<--" "<-" "<=<" "=<<" "<<="
                               "<=>" "<==>" "==>" "=>" "=>>" ">=>" ">>=" ">>-"
                               ">-" "-<" "-<<" ">->" "<-<" "<-|" "<=|" "|=>"
                               "|->" "<->" "[|" "|]" "{|" "|}" "|>" "<|" "||>"
                               "<||" "<|>" "..." ".." "::" ":::" ":=" "::="
                               "//" "///" "/*" "*/" "/=" ";;;"))
  ;; Ligature checks in all buffers
  (global-ligature-mode t))

;; GUI Section ends here -------------------------------------------------------

;; Editing options -------------------------------------------------------------
;; Stop Emacs from creating a bunch of garbage
(setq auto-save-default nil)
(setq make-backup-files nil)

;; Reasonable default tab width
(setq-default tab-width 4)

;; Disable tabs for indentation (spaces only)
;; Each language must configure its own preferences separately
(setq-default indent-tabs-mode nil)

;; Follow links pointing to files under version control
(setq vc-follow-symlinks t)

;; Auto complete and indent, when supported
(setq tab-always-indent 'complete)

;; Directional window navigation
;; Shift+{←,↑,→,↓}
(windmove-default-keybindings)

;; Save current buffer on suspesion
(defun my/autowrite ()
  "Save the current buffer on Emacs suspension. Function name borrowed from
   vim's homonymous option."
  (save-buffer))

(add-hook 'suspend-hook #'my/autowrite)

;; Enable paredit for ELISP
(add-hook 'emacs-lisp-mode-hook
          (lambda () (paredit-mode)))
;; Editing options end here ----------------------------------------------------

;; Key bindings ----------------------------------------------------------------
;; Cycle through windows
(global-set-key (kbd "M-o") 'other-window)
;; Key bindings end here -------------------------------------------------------

;; Custom settings
(load (concat custom-settings "/ido.el"))
(load (concat custom-settings "/ws.el"))
(load (concat custom-settings "/c.el"))
(load (concat custom-settings "/latex.el"))
(load (concat custom-settings "/lua.el"))
(load (concat custom-settings "/ocaml.el"))
(load (concat custom-settings "/clisp.el"))
(load (concat custom-settings "/clojure.el"))
(load (concat custom-settings "/racket.el"))
(load (concat custom-settings "/scheme.el"))
(load (concat custom-settings "/fs.el"))

;; Measure startup time
(defun my/display-startup-time ()
  "Display the startup time after Emacs initialization."
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'my/display-startup-time)
