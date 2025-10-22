;; Scheme

;; External subprocess responsible for the evaluation of expressions in
;; scheme-mode
(setq inferior-scheme-program "chezscheme")

;; Enable paredit-mode for Scheme
(add-hook 'scheme-mode-hook
          (lambda () (paredit-mode)))
