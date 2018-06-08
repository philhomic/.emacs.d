;; config default directory
(setq default-directory "d:\\emacs\\")
;; turn off warning bell
(setq ring-bell-function 'ignore)
;; turn on electric-indent-mode
(electric-indent-mode t)
;; show linum-mode
(global-linum-mode t)
;; 当有外部修改时，这个文件自动加载修改后的文件
(global-auto-revert-mode t)
;; disable backup files
(setq make-backup-files nil)
(setq auto-save-default nil)
;; enable recentf-mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
;; add delete selection mode
(delete-selection-mode t)
;; open abbrev-mode and define my own abbrev
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
;; signature
					    ("8wp" "philhomic")
					    ("8ms" "Microsoft")
))
;; show match parentheses
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(provide 'init-better-defaults)
