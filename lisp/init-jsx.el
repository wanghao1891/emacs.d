(require-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)

(provide 'init-jsx)
