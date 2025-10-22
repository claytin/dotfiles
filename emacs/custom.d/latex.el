;; LaTeX

;; Display line numbers for latex
(add-hook 'latex-mode-hook
		  'display-line-numbers-mode)

;; Display ruler
(add-hook 'latex-mode-hook
		  (lambda () (ruler-mode 1)))
