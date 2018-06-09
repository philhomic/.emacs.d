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
  reveal-in-osx-finder   It is bound to RET, a.
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


(provide 'init-better-defaults)
