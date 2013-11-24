(setq indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

(setq inhibit-startup-message t)
(setq c-basic-offset 4)


; (setq c-offsets-alist '((substatement-open . 0)))


(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
						 ("melpa" . "http://melpa.milkbox.net/packages/")
                         ))
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/monokai-theme-0.0.10")
(load-theme 'monokai t)

(add-to-list 'load-path "~/.emacs.d/el/php-mode") 
(require 'php-mode)

(add-to-list 'load-path "~/.emacs.d/el/evil") 
(require 'evil)
(define-key evil-normal-state-map (kbd "M-c") 'execute-extended-command)
(evil-mode 1)
(server-start)

(add-to-list 'load-path "~/.emacs.d/el/powerline") 
(require 'powerline)
(powerline-default-theme)

(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-global-mode 1)
(setq yas/indent-line nil)

(add-to-list 'load-path "~/.emacs.d/elpa/evil-nerd-commenter-1.2.4")
(require 'evil-nerd-commenter)

(add-to-list 'load-path "~/.emacs.d/elpa/smart-operator-4.0")
(require 'smart-operator)
(add-hook 'php-mode-hook
          (lambda ()
            (smart-operator-mode-on)
            ))


(add-to-list 'load-path "~/.emacs.d/elpa/fiplr-20130810.1841")
(require 'fiplr)
(setq fiplr-root-markers '(".git" ".svn" ".hg"))
(global-set-key (kbd "C-x f") 'fiplr-find-file)

(setq fiplr-ignored-globs '((directories (".git" ".svn" ".hg"))
                            (files ("*.jpg" "*.png" "*.zip" "*~"))))

(global-set-key (kbd "M-x") 'smex)

;check php
(require 'flymake)

(add-hook 'find-file-hook 'flymake-find-file-hook)

(defun flymake-php-init ()
  "Use php to check the syntax of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy
                 'flymake-create-temp-inplace))
         (local (file-relative-name temp
                                    (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns
             '("\\(Parse\\|Fatal\\) error: +\\(.*?\\)
               in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

; (add-to-list 'flymake-allowed-file-name-masks
;              '("\\.php$" flymake-php-init))

(add-to-list 'load-path "~/.emacs.d/el")
(add-to-list 'load-path "~/.emacs.d/elpa/tree-mode-20121207.1538")
(require 'dirtree)

(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20131121.1705")
(add-to-list 'load-path "~/.emacs.d/elpa/popup-20130708.2245")
(require 'auto-complete)
(require 'auto-complete-config)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)
(global-auto-complete-mode t)
