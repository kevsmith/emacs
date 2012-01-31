(provide 'custom_keys_config)

(defun set-erlang-indent (indent-size)
  (setq tab-width indent-size)
  (setq erlang-indent-level indent-size)
  (setq *erlang-indent-size* indent-size)
  (message "Erlang indent set to %d spaces" *erlang-indent-size*))

(defun toggle-erlang-indent ()
  (interactive)
  (cond
   ((= *erlang-indent-size* 2)
    (set-erlang-indent 4))
   ((= *erlang-indent-size* 4)
    (set-erlang-indent 2))))

;; Switches buffers between two Emacs windows
;; Obtained from http://www.emacswiki.org/cgi-bin/wiki?SwitchingBuffers#toc5
(defun transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))

;; Kills all them buffers except *scratch*
;; Obtained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun nuke-all-buffers ()
  "kill all buffers, leaving *scratch* only"
  (interactive)
  (mapcar (lambda (x) (kill-buffer x))
	  (buffer-list))
  (delete-other-windows))

;; Displays file path for buffer
(defun show-file-name ()
  "Show the full path in the minibuffer"
  (interactive)
  (message (buffer-file-name)))

(global-set-key (kbd "C-x t") 'transpose-buffers)
(global-set-key (kbd "M-e") 'toggle-erlang-indent)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-b") 'show-file-name)
(global-set-key (kbd "s-+") 'text-scale-increase)
(global-set-key (kbd "s--") 'text-scale-decrease)
;; (global-set-key (kbd "DEL") 'delete-region)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [del] 'delete-region)
(global-set-key [f3] 'nuke-all-buffers)
(global-set-key [f5] 'rgrep)

(setq ring-bell-function 'ignore)
(if (fboundp 'tool-bar-mode)
	(tool-bar-mode 0))

(defalias 'yes-or-no-p 'y-or-n-p)

(setq tramp-syntax 'url)
