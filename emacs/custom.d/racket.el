;; Racket

(unless (package-installed-p 'racket-mode)
  (package-install 'racket-mode))

;; Enable paredit-mode for Racket
(add-hook 'racket-mode-hook
          (lambda () (paredit-mode)))
