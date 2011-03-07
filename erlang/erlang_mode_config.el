(provide 'erlang_mode_config)

(setq *erlang-indent-size* 4)

(add-to-list 'load-path (build-config-path "/erlang-mode"))
(add-to-list 'load-path (build-config-path "/distel/elisp"))
(require 'erlang-start)
(add-hook 'erlang-mode-hook
	  (lambda()
	    (setq indent-tabs-mode nil)
	    (setq tab-width *erlang-indent-size*)
	    (setq erlang-indent-level *erlang-indent-size*)
	    (setq erlang-tab-always-indent t)
	    (add-to-list 'exec-path "/opt/bin")
	    (setq erlang-root-dir "/opt")))

(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.app?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.config?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\Emakefile" . erlang-mode))
(require 'distel)
(distel-setup)
