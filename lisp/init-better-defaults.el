;; config default directory
(setq default-directory "d:\\emacs\\")
;; turn off warning bell
(setq ring-bell-function 'ignore)
;; turn on electric-indent-mode
(electric-indent-mode t)
;; show linum-mode only in prog-mode
;;(global-linum-mode t)
(add-hook 'prog-mode-hook 'linum-mode)
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
;; indent-region or buffer
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indented selected region."))
      (progn
	(indent-buffer)
	(message "Indented buffer.")))))
;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))
;; less typing when Emacs ask you yes or no
(fset 'yes-or-no-p 'y-or-n-p)
;; always delete and copy recursively
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
;; dired - reuse current buffer by pressing 'a'
(put 'dired-find-alternate-file 'disabled nil)
(require 'dired-x)
;; if there is a dired buffer displayed in the next window, use its
;; current subdir, instead of the current subdir of this dired buffer
(setq dired-dwim-target t)
;; remove or hide dos eol symbol
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))
(defun hide-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))
;; fix tab key
;; my fix for tab indent
(defun philhomic/indent-region(numSpaces)
  (progn
                                      ; default to start and end of current line
    (setq regionStart (line-beginning-position))
    (setq regionEnd (line-end-position))

                                      ; if there's a selection, use that instead of the current line
    (when (use-region-p)
      (setq regionStart (region-beginning))
      (setq regionEnd (region-end))
      )

    (save-excursion                          ; restore the position afterwards
      (goto-char regionStart)                ; go to the start of region
      (setq start (line-beginning-position)) ; save the start of the line
      (goto-char regionEnd)                  ; go to the end of region
      (setq end (line-end-position))         ; save the end of the line

      (indent-rigidly start end numSpaces) ; indent between start and end
      (setq deactivate-mark nil)           ; restore the selected region
      )
    )
  )

;; 设置花括号之后自动空行并缩进
(defun radian-enter-and-indent-sexp (&rest _ignored)
  "Insert an extra newline after point, and reindent."
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

(dolist (mode '(c-mode c++-mode css-mode objc-mode java-mode
                       js2-mode json-mode
                       python-mode sh-mode web-mode js-mode))
  (sp-local-pair mode "{" nil :post-handlers
                 '((radian-enter-and-indent-sexp "RET")
                   (radian-enter-and-indent-sexp "<return>"))))

(dolist (mode '(js2-mode json-mode python-mode web-mode js-mode))
  (sp-local-pair mode "[" nil :post-handlers
                 '((radian-enter-and-indent-sexp "RET")
                   (radian-enter-and-indent-sexp "<return>"))))

(dolist (mode '(python-mode))
  (sp-local-pair mode "(" nil :post-handlers
                 '((radian-enter-and-indent-sexp "RET")
                   (radian-enter-and-indent-sexp "<return>")))
  (sp-local-pair mode "\"\"\"" "\"\"\"" :post-handlers
                 '((radian-enter-and-indent-sexp "RET")
                   (radian-enter-and-indent-sexp "<return>"))))


(provide 'init-better-defaults)
