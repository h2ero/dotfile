(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(add-to-list 'load-path "~/.emacs.d/elpa/evil-20131023.2315") ; only without ELPA/el-get
(add-to-list 'load-path "~/.emacs.d/elpa/php-mode-20131029.1345") ; only without ELPA/el-get
(add-to-list 'load-path "~/.emacs.d/elpa/monokai-theme-20131027.1027") ; only without ELPA/el-get
; (add-to-list 'load-path "~/.emacs.d/elpa/f") ; only without ELPA/el-get
(require 'evil)
(require 'php-mode)
(require 'monokai-theme)
; (require 'flycheck)

(evil-mode 1)
(define-key evil-normal-state-map "gT" 'elscreen-previous) ;previous tab
(define-key evil-normal-state-map "gt" 'elscreen-next) ;next tab

