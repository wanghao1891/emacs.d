(maybe-require-package 'json-mode)
(maybe-require-package 'js2-mode)
(maybe-require-package 'ac-js2)
(maybe-require-package 'coffee-mode)
(maybe-require-package 'typescript-mode)
(require-package 'js-comint)

(defcustom preferred-javascript-mode
  (first (remove-if-not #'fboundp '(js2-mode js-mode)))
  "Javascript mode to use for .js files."
  :type 'symbol
  :group 'programming
  :options '(js2-mode js-mode))

(defconst preferred-javascript-indent-level 2)

;; Need to first remove from list if present, since elpa adds entries too, which
;; may be in an arbitrary order
(eval-when-compile (require 'cl))
(setq auto-mode-alist (cons `("\\.\\(js\\|es6\\)\\(\\.erb\\)?\\'" . ,preferred-javascript-mode)
                            (loop for entry in auto-mode-alist
                                  unless (eq preferred-javascript-mode (cdr entry))
                                  collect entry)))


;; js2-mode

;; Change some defaults: customize them to override
(setq-default js2-basic-offset 4
              js2-bounce-indent-p nil)
(after-load 'js2-mode
  ;; Disable js2 mode's syntax error highlighting by default...
;;  (setq-default js2-mode-show-parse-errors nil
;;                js2-mode-show-strict-warnings nil)
  ;; ... but enable it if flycheck can't handle javascript
;;  (autoload 'flycheck-get-checker-for-buffer "flycheck")
;;  (defun sanityinc/disable-js2-checks-if-flycheck-active ()
;;    (unless (flycheck-get-checker-for-buffer)
;;      (set (make-local-variable 'js2-mode-show-parse-errors) t)
;;      (set (make-local-variable 'js2-mode-show-strict-warnings) t)))
;;  (add-hook 'js2-mode-hook 'sanityinc/disable-js2-checks-if-flycheck-active)

  (add-hook 'js2-mode-hook (lambda () (setq mode-name "JS2")))

  (after-load 'js2-mode
    (js2-imenu-extras-setup)))

;; js-mode
(setq-default js-indent-level preferred-javascript-indent-level)


(add-to-list 'interpreter-mode-alist (cons "node" preferred-javascript-mode))


;; Javascript nests {} and () a lot, so I find this helpful

(require-package 'rainbow-delimiters)
(dolist (hook '(js2-mode-hook js-mode-hook json-mode-hook))
  (add-hook hook 'rainbow-delimiters-mode))



;;; Coffeescript

(after-load 'coffee-mode
  (setq coffee-js-mode preferred-javascript-mode
        coffee-tab-width preferred-javascript-indent-level))

(when (fboundp 'coffee-mode)
  (add-to-list 'auto-mode-alist '("\\.coffee\\.erb\\'" . coffee-mode)))

;; ---------------------------------------------------------------------------
;; Run and interact with an inferior JS via js-comint.el
;; ---------------------------------------------------------------------------

(setq inferior-js-program-command "node")

(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        ;(ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list 'comint-preoutput-filter-functions
                     (lambda (output)
                       (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
                                                 (replace-regexp-in-string ".*1G.*3G" ">" output))))))

(defvar inferior-js-minor-mode-map (make-sparse-keymap))
(define-key inferior-js-minor-mode-map "\C-x\C-e" 'js-send-last-sexp)
(define-key inferior-js-minor-mode-map "\C-\M-x" 'js-send-last-sexp-and-go)
(define-key inferior-js-minor-mode-map "\C-cb" 'js-send-buffer)
(define-key inferior-js-minor-mode-map "\C-c\C-b" 'js-send-buffer-and-go)
(define-key inferior-js-minor-mode-map "\C-cl" 'js-load-file-and-go)

(define-minor-mode inferior-js-keys-mode
  "Bindings for communicating with an inferior js interpreter."
  nil " InfJS" inferior-js-minor-mode-map)

(dolist (hook '(js2-mode-hook js-mode-hook))
  (add-hook hook 'inferior-js-keys-mode))

;; ---------------------------------------------------------------------------
;; Alternatively, use skewer-mode
;; ---------------------------------------------------------------------------

(when (maybe-require-package 'skewer-mode)
  (after-load 'skewer-mode
    (add-hook 'skewer-mode-hook
              (lambda () (inferior-js-keys-mode -1)))))

;; ---------------------------------------------------------------------------
;; Add hs-minor-mode add by wh [2015-07-24 Fri 17:09]
;; ---------------------------------------------------------------------------
(add-hook 'js2-mode-hook 'hs-minor-mode)
;(add-hook 'js2-mode-hook (lambda () (hs-minor-mode 1)))

;; ---------------------------------------------------------------------------
;; Add js2-jsx-mode add by wh [2016-04-05 Tue 16:36]
;; ---------------------------------------------------------------------------
;;(add-to-list 'auto-mode-alist '("\\.jsx?$" . js2-jsx-mode))

(provide 'init-javascript)
