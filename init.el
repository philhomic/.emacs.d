;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'init-packages)
(require 'init-ui)


;; config default directory
(setq default-directory "d:\\emacs\\")

;; turn off warning bell
(setq ring-bell-function 'ignore)


;; turn on electric-indent-mode
(electric-indent-mode t)
;; show linum-mode
(global-linum-mode t)

;; save your config
;; define a function to quickly open your config file.
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-my-init-file)





;; disable backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; set code highlight in org mode
(require 'org)
(setq org-src-fontify-natively t)

;; enable recentf-mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; add delete selection mode
(delete-selection-mode t)



;; show match parentheses
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)






(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)



;; 当有外部修改时，这个文件自动加载修改后的文件
(global-auto-revert-mode t)

;; open abbrev-mode and define my own abbrev
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
;; signature
					    ("8wp" "philhomic")
					    ("8ms" "Microsoft")
))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 3)
 '(custom-safe-themes
   (quote
    ("c3d4af771cbe0501d5a865656802788a9a0ff9cf10a7df704ec8b8ef69017c68" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
