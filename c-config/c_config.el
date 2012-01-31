(provide 'c_config)

;; Fix up C indenting
(setq c-default-style "bsd"
      c-basic-offset 2)

(setq c-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2))))
(setq objc-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2))))
(setq c++-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2))))

;; Associate CUDA source with c++-mode
(add-to-list 'auto-mode-alist '("\\.cu?$" . c++-mode))
