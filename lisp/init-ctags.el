;;;;;;;;;;;;
;; Ctags
;;;;;;;;;;;;

(setq path-to-ctags "/root/ctags/") ;; <- your ctags path here

(defun create-tags (dir-name tag-name)
  "Create tags file."
  (interactive "DDirectory: \nsTag name:")
  (shell-command
   (format "ctags -f %s%s -e -R %s" path-to-ctags tag-name (directory-file-name dir-name))))

;;; View tags other window
(defun view-tag-other-window (tagname &optional next-p regexp-p)
  "Same as `find-tag-other-window' but doesn't move the point"
  (interactive (find-tag-interactive "View tag other window: "))
  (let ((window (get-buffer-window)))
    (find-tag-other-window tagname next-p regexp-p)
    (recenter 0)
    (select-window window)))

(provide 'init-ctags)
