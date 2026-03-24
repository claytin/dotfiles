;; CLISP

;; TODO
;; SLIME and SLY have compilation errors. Until those are fixed this file will
;; remain "frozen"

;; External subprocess responsible for the evaluation of expressions in
;; lisp-mode
(setq inferior-lisp-program "sbcl")

;; Enable paredit-mode for CLISP
(add-hook 'lisp-mode-hook
          (lambda () (paredit-mode)))
