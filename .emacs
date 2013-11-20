(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
    (url-retrieve-synchronously
      "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync)

(add-to-list 'load-path "~/.emacs.d/el-get/php-mode") 
(require 'php-mode)

(add-to-list 'load-path "~/.emacs.d/el-get/php-mode") 
(require 'evil)
(define-key evil-normal-state-map (kbd "M-c") 'execute-extended-command)
(evil-mode 1)
(server-start)
