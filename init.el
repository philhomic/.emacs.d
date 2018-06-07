;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
    )

(require 'cl)

;; add whatever packages you want here
(defvar philhomic/packages '(
			       company
			       monokai-theme
			       hungry-delete
			       swiper
			       counsel
			       smartparens
			       js2-mode
			       nodejs-repl
			       exec-path-from-shell
			       ) "Default packages")

(setq package-selected-packages philhomic/packages)

(defun philhomic/packages-installed-p ()
    (loop for pkg in philhomic/packages
          when (not (package-installed-p pkg)) do (return nil)
          finally (return t)))

(unless (philhomic/packages-installed-p)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg philhomic/packages)
      (when (not (package-installed-p pkg))
        (package-install pkg))))

; turn off tool-bar
(tool-bar-mode -1)
;; turn off scroll-bar
(scroll-bar-mode -1)
;; turn on electric-indent-mode
(electric-indent-mode t)
;; show linum-mode
(global-linum-mode t)
;; turn off splash screen
(setq inhibit-splash-screen t)
;; save your config
;; define a function to quickly open your config file.
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-my-init-file)

;; open global company mode
(global-company-mode t)

;; set cursor style
(setq-default cursor-type 'bar)

;; disable backup files
(setq make-backup-files nil)

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

;; open with full screen
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; show match parentheses
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; highlight current line
(global-hl-line-mode t)

;; automatically load theme monokai
(load-theme 'monokai t)

;; enable hungry-mode
(require 'hungry-delete)
(global-hungry-delete-mode)

;; config swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)

;; configure smartparens mode
(require 'smartparens-config)
(smartparens-global-mode t)

;; congifure js2-mode for js files
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;; enable nodejs-repl
(require 'nodejs-repl)
;; 要使用的话，M-x nodejs-repl

;; 让命令行在Emacs中可见
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

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
