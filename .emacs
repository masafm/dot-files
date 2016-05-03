; gtags
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
(global-set-key "\M-." 'gtags-find-tag)     ;関数の定義元へ
(global-set-key "\M-t" 'gtags-find-tag)     ;関数の定義元へ
(global-set-key "\M-r" 'gtags-find-rtag)    ;関数の参照先へ
(global-set-key "\M-s" 'gtags-find-symbol)  ;変数の定義元/参照先へ
(global-set-key "\M-p" 'gtags-find-pattern)
(global-set-key "\M-f" 'gtags-find-file)    ;ファイルにジャンプ
(global-set-key "\M-," 'gtags-pop-stack)   ;前のバッファに戻る
(global-set-key "\M-*" 'gtags-pop-stack)   ;前のバッファに戻る

; saveplace
(load "saveplace")
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/saved-places")

; goto-line
(global-set-key "\M-g" 'goto-line)
; kill
(global-set-key "\M-k" 'kill-buffer)

