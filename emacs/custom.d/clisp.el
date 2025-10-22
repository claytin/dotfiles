;; CLISP

;; SLIME
(unless (package-installed-p 'slime)
  (package-install 'slime))

;; External subprocess responsible for the evaluation of expressions in
;; lisp-mode
(setq inferior-lisp-program "sbcl")

;; Enable paredit-mode for CLISP
(add-hook 'lisp-mode-hook
          (lambda () (paredit-mode)))
