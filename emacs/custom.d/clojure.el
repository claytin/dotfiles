;; Clojure

(unless (package-installed-p 'clojure-mode)
  (package-install 'clojure-mode))

;; Enable paredit-mode for Clojure
(add-hook 'clojure-mode-hook
          (lambda () (paredit-mode)))
