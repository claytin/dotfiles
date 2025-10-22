;; C/C++ mode options
(setq c-default-style "stroustrup"
      c-basic-offset tab-width)

(add-hook 'c-mode-hook
          (lambda () (setq indent-tabs-mode t)))

(add-hook 'c++-mode-hook
          (lambda () (setq indent-tabs-mode t)))
