(provide 'c_config)

;; Fix up C indenting
(setq c-default-style "bsd"
      c-basic-offset 4)

(setq c-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 4))))
(setq objc-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 4))))
(setq c++-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 4))))

;; Associate CUDA source with c++-mode
(add-to-list 'auto-mode-alist '("\\.cu?$" . c++-mode))
