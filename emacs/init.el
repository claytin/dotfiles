;; Stop Emacs from creating a bunch of garbage
(setq auto-save-default nil)
(setq make-backup-files nil)

;; Disable toolbar when running a GUI
(when (window-system)
  (tool-bar-mode -1))

;; Hide menu bar
(menu-bar-mode -1)

;; Add a ruler that shows fill-column at the 80th character
(setq-default fill-column 80)

(add-hook 'prog-mode-hook
	  (lambda () (ruler-mode 1)))

;; Show column numbers in mode-line
(setq column-number-mode t)

;; Display line numbers on buffers in programming mode
(add-hook 'prog-mode-hook
	  'display-line-numbers-mode)

;; Add package sources
(with-eval-after-load 'package
  (add-to-list 'package-archives
		 '("nongnu" . "https://elpa.nongnu.org/nongnu/")
		 '("melpa" . "https://melpa.org/packages/")))

;; Colors
(setq-default custom-theme-directory "~/.emacs.d/custom-themes/")
(load-theme 'solarized-light t)

;; Default font
(add-to-list 'default-frame-alist
             '(font . "JetBrains Mono Regular-10"))
