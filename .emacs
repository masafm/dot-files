(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elisp/ruby")
(add-to-list 'load-path "~/.emacs.d/elisp/popup-el")
(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete")
(add-to-list 'load-path "~/.emacs.d/elisp/elpa/packages/cl-lib")

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

;ruby
(setq ruby-insert-encoding-magic-comment nil);マジックコメントいらない
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
				     interpreter-mode-alist))
;; set to load inf-ruby and set inf-ruby key definition in ruby-mode.
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
	     ))

; auto-complete
(load "auto-complete.el")
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/dict")
(require 'auto-complete-config)
(ac-config-default)

; saveplace
(load "saveplace")
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/saved-places")

; goto-line
(global-set-key "\M-g" 'goto-line)
; kill
(global-set-key "\M-k" 'kill-buffer)

; iPad keybind
(global-set-key "¡" "\M-1")
(global-set-key "™" "\M-2")
(global-set-key "£" "\M-3")
(global-set-key "¢" "\M-4")
(global-set-key "∞" "\M-5")
(global-set-key "§" "\M-6")
(global-set-key "¶" "\M-7")
(global-set-key "•" "\M-8")
(global-set-key "ª" "\M-9")
(global-set-key "º" "\M-0")
(global-set-key "–" "\M--")
(global-set-key "≠" "\M-=")
(global-set-key "œ" "\M-q")
(global-set-key "∑" "\M-w")
(global-set-key "´" "\M-e")
(global-set-key "®" "\M-r")
(global-set-key "†" "\M-t")
(global-set-key "¥" "\M-y")
(global-set-key "ˆ" "\M-i")
(global-set-key "ø" "\M-o")
(global-set-key "π" "\M-p")
(global-set-key "“" "\M-[")
(global-set-key "‘" "\M-]")
(global-set-key "å" "\M-a")
(global-set-key "ß" "\M-s")
(global-set-key "∂" "\M-d")
(global-set-key "ƒ" "\M-f")
(global-set-key "©" "\M-g")
(global-set-key "˙" "\M-h")
(global-set-key "∆" "\M-j")
(global-set-key "˚" "\M-k")
(global-set-key "¬" "\M-l")
(global-set-key "…" "\M-;")
(global-set-key "æ" "\M-'")
(global-set-key "Ω" "\M-z")
(global-set-key "≈" "\M-x")
(global-set-key "ç" "\M-c")
(global-set-key "√" "\M-v")
(global-set-key "∫" "\M-b")
(global-set-key "˜" "\M-n")
(global-set-key "µ" "\M-m")
(global-set-key "≤" "\M-,")
(global-set-key "≥" "\M-.")
(global-set-key "÷" "\M-/")
(global-set-key "¯" "\M-<")
(global-set-key "˘" "\M->")
