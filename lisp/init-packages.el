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
			       reveal-in-osx-finder
			       web-mode
			       js2-refactor
			       expand-region
			       iedit
			       emmet-mode
			       org-bullets
			       helm-ag
			       flycheck
			       yasnippet
			       yasnippet-snippets
			       auto-yasnippet
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
       '(("\\.js\\'" . js2-mode)
	 ("\\.html\\'" . web-mode))
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

;; fix smartparens quote issue
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
;; config for web-mode
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)
(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
        (setq js-indent-level (if (= js-indent-level 2) 4 2))
        (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
             (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
             (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))
;; config for js2-refactor
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")
;; improve occur mode
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))
;; improve imenu
(defun js2-imenu-make-index ()
      (interactive)
      (save-excursion
        ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
        (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
                                   ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
	  (lambda ()
	    (setq imenu-create-index-function 'js2-imenu-make-index)))
;; configure emmet-mode
(require 'emmet-mode)
(setq emmet-move-cursor-between-quotes t) ;; set cursor positioned between the first empty quote after expanding
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

(provide 'init-packages)



