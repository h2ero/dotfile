(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ))
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/monokai-theme-0.0.10")
(load-theme 'monokai t)

(add-to-list 'load-path "~/.emacs.d/elpa/php-mode-1.5.0") ; only without ELPA/el-get
(require 'php-mode)

(add-to-list 'load-path "~/.emacs.d/el/evil") ; only without ELPA/el-get
(require 'evil)
(define-key evil-normal-state-map (kbd "M-c") 'execute-extended-command)
(evil-mode 1)
(server-start)
