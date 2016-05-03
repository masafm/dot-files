(add-to-list 'load-path "~/.emacs.d/elisp/")
(add-to-list 'load-path "~/.emacs.d/elisp/ruby/")
(add-to-list 'load-path "~/.emacs.d/elisp/popup-el/")
(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete/")
(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete-c-headers/")

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(require 'auto-complete-c-headers)
(add-hook 'c++-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))
(add-hook 'c-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))

(load "/usr/local/share/gtags/gtags.el")
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-suggested-key-mapping t)
(add-hook 'c-mode-hook
    '(lambda ()
       (gtags-mode 1)
 ))
(add-hook 'c++-mode-hook
    '(lambda ()
       (gtags-mode 1)
 ))

(load "saveplace")
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/saved-places")

; goto-line
(global-set-key "\M-g" 'goto-line)
; kill
(global-set-key "\M-k" 'kill-buffer)
; man
(global-set-key "\M-m" 'woman)
;; 初回起動が遅いのでキャッシュを作成(更新は C-u を付けて woman を呼ぶ)
(setq woman-cache-filename (expand-file-name "~/.emacs.d/woman_cache.el"))

; gtags keys
(global-set-key "\M-." 'gtags-find-tag)     ;関数の定義元へ
(global-set-key "\M-t" 'gtags-find-tag)     ;関数の定義元へ
(global-set-key "\M-r" 'gtags-find-rtag)    ;関数の参照先へ
(global-set-key "\M-s" 'gtags-find-symbol)  ;変数の定義元/参照先へ
(global-set-key "\M-p" 'gtags-find-pattern)
(global-set-key "\M-f" 'gtags-find-file)    ;ファイルにジャンプ
(global-set-key "\M-," 'gtags-pop-stack)   ;前のバッファに戻る
(global-set-key "\M-*" 'gtags-pop-stack)   ;前のバッファに戻る

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
            (inf-ruby-keys)))
(require 'ruby-electric)
;(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)));有効にするとエラーになる
(setq ruby-indent-level 1)
(setq ruby-indent-tabs-mode nil)
