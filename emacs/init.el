(defconst custom-settings "~/.config/emacs/custom.d"
  "Path to files that separate custom settings")

;; Add package sources
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Bootstrap packages
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'solarized-theme)
  (package-install 'solarized-theme))

(unless (package-installed-p 'solarized-theme)
  (package-install 'clojure-mode))

(unless (package-installed-p 'lua-mode)
  (package-install 'lua-mode))

(setq use-package-always-ensure t
	  use-package-verbose t)

;; Stop Emacs from creating a bunch of garbage
(setq auto-save-default nil)
(setq make-backup-files nil)

;; Disable some GUI components
(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; Hide menu bar
(menu-bar-mode -1)

;; Add a ruler that shows fill-column at the 80th character
(setq-default fill-column 80)

;; Don't show emacs default buffer
(setq inhibit-startup-screen t)

(add-hook 'prog-mode-hook
		  (lambda () (ruler-mode 1)))
(add-hook 'latex-mode-hook
		  (lambda () (ruler-mode 1)))

;; Show column numbers in mode-line
(setq column-number-mode t)

;; Display line numbers on buffers in programming mode
(add-hook 'prog-mode-hook
		  'display-line-numbers-mode)

;; Highlight current line
(global-hl-line-mode t)

;; Colors
(load-theme 'solarized-light t)

;; Default font
(add-to-list 'default-frame-alist
			 '(font . "JetBrains Mono-10.5"))

;; Reasonable default tab width
(setq-default tab-width 4)

;; Key bindings
(global-set-key (kbd "C-c w") 'whitespace-mode)
(global-set-key (kbd "C-c cw") 'delete-trailing-whitespace)

;; Custom settings "modules"
(load (concat custom-settings "/ido.el"))
(load (concat custom-settings "/ws.el"))
(load (concat custom-settings "/c.el"))
