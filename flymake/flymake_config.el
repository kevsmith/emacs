(provide 'flymake_config)

(require 'flymake)

(defun flymake-erlang-init ()
  (let ((local-file (buffer-file-name)))
    (list (build-config-path "/flymake/bin/eflymake") (list local-file))))

;; (defun flymake-erlang-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;; 		     'flymake-create-temp-with-folder-structure))
;; 	 (local-file (file-relative-name
;; 		      temp-file
;; 		      (file-name-directory buffer-file-name))))
;;     (list (build-config-path "/flymake/bin/eflymake") (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
	     '("\\.erl\\'" flymake-erlang-init))

(add-hook 'find-file-hook 'flymake-find-file-hook)
