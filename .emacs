(setq inhibit-splash-screen t)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(when (eq system-type 'darwin)
  (defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))
			     
  (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
	(process-send-string proc text)
	(process-send-eof proc))))
  
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx)
  
  (xterm-mouse-mode 1)

  ;; display line numbers
  (if (version<= "26.0.50" emacs-version)
      (progn
	(global-display-line-numbers-mode)
	(set-face-attribute 'line-number nil
                            :foreground "DarkOliveGreen"
                            :background "#131521")
	(set-face-attribute 'line-number-current-line nil
                            :foreground "gold")))
)

(add-hook 'c-mode-common-hook (lambda () (ggtags-mode 1)))
(add-hook 'python-mode-hook (lambda () (ggtags-mode 1)))
(add-hook 'go-mode-hook (lambda () (ggtags-mode 1)))
(add-hook 'js-mode-hook (lambda () (ggtags-mode 1)))
(add-hook 'grep-mode-hook (lambda ()
			    (global-set-key (kbd "M-n") 'next-error)
			    (global-set-key (kbd "M-p") 'previous-error)
			    ))

(global-set-key (kbd "<mouse-2>") 'clipboard-yank)
(global-set-key (kbd "<mouse-3>") 'clipboard-kill-ring-save)
(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)
(add-hook 'ggtags-mode-hook (lambda ()
			      (local-set-key (kbd "<double-mouse-1>") 'ggtags-find-tag-mouse)
			      (local-set-key (kbd "<double-mouse-3>") 'xref-pop-marker-stack)
			      ))
(put 'dired-find-alternate-file 'disabled nil)
(add-hook 'dired-mode-hook (lambda () (local-set-key (kbd "<mouse-2>") #'dired-find-alternate-file)))
(setq mouse-drag-copy-region t)

(setq grep-command
      "egrep -nH --null -e ")

;; シンボリックリンクの読み込みを許可
(setq vc-follow-symlinks t)

;; screenライクにバッファを切り替える
;(global-set-key (kbd "<C-z n>") 'next-buffer)
;(global-set-key (kbd "<C-z p>") 'previous-buffer)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(typescript-mode terraform-mode yaml-mode jpop tramp org-sidebar rg ripgrep fzf dired-toggle protobuf-mode ibuffer-project elscreen neotree moody spaceline go-mode json-mode ggtags)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
