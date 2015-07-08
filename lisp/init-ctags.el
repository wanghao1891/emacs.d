;;;;;;;;;;;;
;; Ctags
;;;;;;;;;;;;

(setq path-to-ctags "/root/ctags/") ;; <- your ctags path here

(defun create-tags (dir-name tag-name)
  "Create tags file."
  (interactive "DDirectory: \nsTag name:")
  (shell-command
   (format "ctags -f %s%s -e -R %s" path-to-ctags tag-name (directory-file-name dir-name))))

(provide 'init-ctags)
