;; enable ido-mode, flexible-matching, virtual-buffer
(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-virtual-buffers t)

;; use ido-ubiquitous
;;(require-package 'ido-completing-read+)
;;(ido-ubiquitous-mode t)

;; use smex to handle M-x
;; https://github.com/nonsequitur/smex
;; copy https://github.com/nonsequitur/smex/blob/master/smex.el to ~/.emacs.d/lisp/smex.el
(require 'smex)
(smex-initialize)
(global-set-key "\M-x" 'smex)
(global-set-key "\M-X" 'smex-major-mode-commands)

(provide 'init-ido)
