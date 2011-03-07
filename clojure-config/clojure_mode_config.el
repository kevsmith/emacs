(provide 'clojure_mode_config)

(add-to-list 'load-path (build-config-path "/clojure"))
(add-to-list 'load-path (build-config-path "/slime"))

(require 'clojure-mode)
(require 'slime)
(slime-setup)
(setq inferior-lisp-program "/Users/ksmith/bin/clojure/clj-env-dir")

(autoload 'paredit-mode "paredit"
      "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))