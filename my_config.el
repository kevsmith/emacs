(provide 'my_config)

;; Fix crazy env var behavior on OSX
(if (not (getenv "TERM_PROGRAM"))
     (setenv "PATH"
	     (shell-command-to-string "source $HOME/.bash_profile && printf $PATH")))


(defun build-config-path (path)
  (concat (concat (getenv "HOME") "/emacs") path))

(setq inhibit-splash-screen t)

(setq-default show-trailing-whitespace t)

(add-to-list 'default-frame-alist '(alpha . (100 100)))
(add-to-list 'load-path (build-config-path "/delsel")) ;; Configuration for delsel
(add-to-list 'load-path (build-config-path "/erlang")) ;; Configuration for Erlang mode
(add-to-list 'load-path (build-config-path "/c-config")) ;; Configuration for C/C++ mode
(add-to-list 'load-path (build-config-path "/flymake")) ;; Flymake syntax checker
(add-to-list 'load-path (build-config-path "/git")) ;; Git mode
(add-to-list 'load-path (build-config-path "/whitespace")) ;; Whitespace package
(add-to-list 'load-path (build-config-path "/autosave")) ;; Autosave config
(add-to-list 'load-path (build-config-path "/custom_keys")) ;; Custom keys config
(add-to-list 'load-path (build-config-path "/javascript")) ;; js2-mode
(add-to-list 'load-path (build-config-path "/clojure-config")) ;; Clojure
(add-to-list 'load-path (build-config-path "/twiddle")) ;; http-twiddle
(add-to-list 'load-path (build-config-path "/linum")) ;; linum
(add-to-list 'load-path (build-config-path "/color-theme")) ;; color-theme
(add-to-list 'load-path (build-config-path "/emacs-color-theme-solarized")) ;; solarized theme

(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))
(require 'delsel_config)
(require 'color-theme-solarized)
(require 'linum)
(require 'erlang_mode_config) ;; Loading Erlang mode
(require 'c_config) ;; Loading C/C++ mode config
(require 'flymake_config) ;; Loading flymake
;;(require 'whitespace_config) ;; Loading whitespace
(require 'git) ;; Loading Git mode
(require 'javascript_config) ;; Loading custom js mode
(require 'clojure_mode_config) ;; Loading custom clojure mode
(require 'autosave_config) ;; Configures autosaving
(require 'http-twiddle) ;; Loading http-twiddle mode
(require 'custom_keys_config) ;; custom key bindings

(require 'ido)
(ido-mode 'both) ;; for buffers and files
(setq
  ido-save-directory-list-file "~/.emacs.d/cache/ido.last"

  ido-ignore-buffers ;; ignore these guys
  '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"

     "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
  ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~src")
  ido-case-fold  t                 ; be case-insensitive

  ido-enable-last-directory-history t ; remember last used dirs
  ido-max-work-directory-list 30   ; should be enough
  ido-max-work-file-list      50   ; remember many
  ido-use-filename-at-point nil    ; don't use filename at point (annoying)
  ido-use-url-at-point nil         ; don't use url at point (annoying)

  ido-enable-flex-matching nil     ; don't try to be too smart
  ido-max-prospects 8              ; don't spam my minibuffer
  ido-confirm-unique-completion t) ; wait for RET, even with unique completion

;; when using ido, the confirmation is rather annoying...
(setq confirm-nonexistent-file-or-buffer nil)

;; select dark solarized theme if running Cocoa Emacs
;; otherwise select dark-laptop
(if (fboundp 'tool-bar-mode)
    (progn
      (color-theme-solarized-dark)
      (global-linum-mode)
      (display-time))
    (color-theme-dark-laptop))

;; turn off annoying autosave & backup files
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)
(setq auto-save-default nil)

;; turn on column mode
(setq column-number-mode t)

;; start the server
(server-start)
