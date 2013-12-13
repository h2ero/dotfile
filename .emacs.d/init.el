(setq indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

(progn
  (set-frame-font "Ubuntu Mono-12")
  ; emacs --daemon font
  (add-to-list 'default-frame-alist '(font . "Ubuntu Mono-12"))
  (set-fontset-font "fontset-default" 'han
                    '("WenQuanYi Zen Hei Mono" . "unicode-bmp")))

(global-set-key (kbd "C-SPC") nil)
; (global-unset-key (kbd "C-SPC"))
; (global-set-key (kbd "M-SPC") 'set-mark-command)

(setq inhibit-startup-message t)
(setq c-basic-offset 4)

(defalias 'yes-or-no-p 'y-or-n-p)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

; (setq c-offsets-alist '((substatement-open . 0)))

; fly check subWord
(global-subword-mode 1)


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

(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20131127.2134")
(require 'yasnippet)
(yas-global-mode 1)
; (setq yas/indent-line nil)
(setf yas/indent-line 'fixed)
; (global-set-key (kbd "TAB") nil)
; (global-set-key (kbd "<TAB>") 'yas-expand)

(add-to-list 'load-path "~/.emacs.d/elpa/evil-nerd-commenter-1.2.4")
(require 'evil-nerd-commenter)

(add-to-list 'load-path "~/.emacs.d/elpa/smart-operator-4.0")
(require 'smart-operator)
(add-hook 'php-mode-hook
          (lambda ()
            (smart-operator-mode-on)
            ; fly spell check only for comments
            (flyspell-prog-mode)
            ))


(add-to-list 'load-path "~/.emacs.d/el/fiplr")
(add-to-list 'load-path "~/.emacs.d/el/grizzl")
(require 'fiplr)
(setq fiplr-root-markers '(".git" ".svn" ".hg"))
(global-set-key (kbd "C-x f") 'fiplr-find-file)

(setq fiplr-ignored-globs '((directories (".git" ".svn" ".hg"))
                            (files ("*.jpg" "*.png" "*.zip" "*~"))))

(define-key evil-normal-state-map (kbd ",p") 'fiplr-find-file)

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
(setq ac-delay 0.5)


(add-to-list 'load-path "~/.emacs.d/elpa/sr-speedbar-20130309.1959")
(require 'sr-speedbar)
(setq speedbar-use-images nil)
(setq sr-speedbar-right-side nil)
(setq speedbar-show-unknown-files t)
(setq imenu-auto-scan t)
(define-key evil-normal-state-map (kbd ",f") 'sr-speedbar-toggle)
(define-key speedbar-mode-map ",f" 'sr-speedbar-toggle)



; recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 100)
;ido
(require 'ido)
(ido-mode t)
(defun recentf-ido-find-file ()
      "Find a recent file using Ido."
      (interactive)
      (let* ((file-assoc-list
          (mapcar (lambda (x)
                (cons (file-name-nondirectory x)
                  x))
              recentf-list))
         (filename-list
          (remove-duplicates (mapcar #'car file-assoc-list)
                     :test #'string=))
         (filename (ido-completing-read "Choose recent file: "
                        filename-list
                        nil
                        t)))
        (when filename
          (find-file (cdr (assoc filename
                     file-assoc-list))))))

(define-key evil-normal-state-map (kbd ",m") 'recentf-ido-find-file )

;org-mode
(add-to-list 'load-path "~/.emacs.d/elpa/org-20131125")
(require 'org)
(setq org-agenda-files (list "~/h2ero/org/todo/job.org" "~/h2ero/org/todo/normal.org"))
(setq org-src-fontify-natively t)
(setq org-log-done 'time)

(setq org-todo-keywords
      '((sequence "TODO" "INPROGRESS" "DONE")))

(setq org-publish-project-alist
	  '(("org"
		 :base-directory "~/h2ero/org/"
		 :publishing-directory "~/h2ero/org/html"
		 :publishing-function org-html-publish-to-html
		 :recursive t
		 :section-numbers nil
		 :table-of-contents nil)))

(defun dos2unix ()
  "Not exactly but it's easier to remember"
  (interactive)
  (set-buffer-file-coding-system 'unix 't) )


; evil key map
; ecb
; (ecb-activate t)
(define-key evil-normal-state-map (kbd ",ee") 'ecb-goto-window-edit-last)
(define-key evil-normal-state-map (kbd ",es") 'ecb-goto-window-sources)
(define-key evil-normal-state-map (kbd ",ed") 'ecb-goto-window-directories)
(define-key evil-normal-state-map (kbd ",em") 'ecb-goto-window-methods)
(define-key evil-normal-state-map (kbd ",eh") 'ecb-goto-window-history)
(define-key evil-normal-state-map (kbd ",er") 'ecb-redraw-layout)
(define-key evil-normal-state-map (kbd "gn") 'evil-window-next)
(define-key evil-normal-state-map (kbd "gN") 'evil-window-prev)

; remember
(define-key global-map "\C-cr" 'org-remember)
(setq org-default-notes-file "~/h2ero/org/.notes.org")
