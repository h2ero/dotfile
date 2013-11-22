(setq indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)

; (setq c-offsets-alist '((substatement-open . 0)))


(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
						 ("melpa" . "http://melpa.milkbox.net/packages/")
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

(add-to-list 'load-path "~/.emacs.d/el/powerline") ; only without ELPA/el-get
(require 'powerline)
(powerline-default-theme)

(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-global-mode 1)

(add-to-list 'load-path "~/.emacs.d/elpa/evil-nerd-commenter-1.2.4")
(require 'evil-nerd-commenter)

(add-to-list 'load-path "~/.emacs.d/elpa/smart-operator-4.0")
(require 'smart-operator)
(add-hook 'php-mode-hook
          (lambda ()
            (smart-operator-mode-on)))

(add-to-list 'load-path "~/.emacs.d/elpa/fiplr-20130810.1841")
(require 'fiplr)
(setq fiplr-root-markers '(".git" ".svn" ".hg"))
(global-set-key (kbd "C-x f") 'fiplr-find-file)

(setq fiplr-ignored-globs '((directories (".git" ".svn" ".hg"))
                            (files ("*.jpg" "*.png" "*.zip" "*~"))))

(global-set-key (kbd "M-x") 'smex)
