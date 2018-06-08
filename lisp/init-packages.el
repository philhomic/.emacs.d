(when (>= emacs-major-version 24)
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
			       popwin
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

;; open global company mode
(global-company-mode t)

;; automatically load theme monokai
(load-theme 'monokai t)

;; enable hungry-mode
(require 'hungry-delete)
(global-hungry-delete-mode)

;; config swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;; configure smartparens mode
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

;; enable popwin
(require 'popwin)
(popwin-mode t)


(provide 'init-packages)



