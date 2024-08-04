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

(add-hook 'prog-mode-hook
	  (lambda () (ruler-mode 1)))
(add-hook 'latex-mode-hook
	  (lambda () (ruler-mode 1)))

;; Show column numbers in mode-line
(setq column-number-mode t)

;; Display line numbers on buffers in programming mode
(add-hook 'prog-mode-hook
	  'display-line-numbers-mode)

;; Add package sources
(require 'package)

(add-to-list 'package-archives
	     '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; Colors
(unless (package-installed-p 'solarized-theme)
  (package-install solarized-theme))

(load-theme 'solarized-light t)

;; Default font
(add-to-list 'default-frame-alist
             '(font . "JetBrains Mono Regular-10"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-enable-flex-matching t)
 '(ido-mode 'both nil (ido))
 '(package-selected-packages '(erlang erlang-mode clojure-mode solarized-theme)))

(setq ido-create-new-buffer 'always)
(setq-default confirm-nonexistent-file-or-buffer nil)

(global-set-key (kbd "M-o") 'other-window)

;; Clojure
(unless (package-installed-p 'clojure-mode)
  (package-install 'clojure-mode))

;; Erlang
(unless (package-installed-p 'erlang)
  (package-install 'erlang))

(require 'erlang-start)

;; C/C++ mode options
(setq c-default-style "stroustrup"
	  c-basic-offset 4
	  tab-width 4
      indent-tabs-mode t)
