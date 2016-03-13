;;; package --- Summary
;;; Commentary:
;;; Code:

(require-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
;; nothing change, so comment
;;(defadvice web-mode-highlight-part (around tweak-jsx activate)
;;  (if (equal web-mode-content-type "jsx")
;;      (let ((web-mode-enable-part-face nil))
;;        ad-do-it)
;;    ad-do-it))

;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)

;; turn on flychecking globally
;;(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'web-mode-hook 'flycheck-mode)


;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; customize flycheck temp file prefix
;;(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                          '(json-jsonlist)))

(provide 'init-jsx)

;;; init-jsx.el ends here
