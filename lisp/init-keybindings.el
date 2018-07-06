(global-set-key (kbd "<f2>") 'open-my-init-file)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
;;(global-set-key (kbd "C-c p f") 'counsel-git)
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)
(global-set-key (kbd "s-/") 'hippie-expand)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
(with-eval-after-load 'js2-mode
  (define-key js2-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression))
(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)
(global-set-key (kbd "M-s o") 'occur-dwim)
(global-set-key (kbd "M-s i") 'counsel-imenu)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "M-s e") 'iedit-mode)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))
;;(global-set-key (kbd "C-c p s") 'helm-do-ag-project-root
(add-hook 'js2-mode-hook 'flycheck-mode)
(global-set-key (kbd "H-w") #'aya-create)
(global-set-key (kbd "H-y") #'aya-expand)
(global-set-key (kbd "C-w") 'backward-kill-word)
(evil-leader/set-key
  "ff" 'find-file
  "fr" 'recentf-open-files
  "fs" 'save-buffer
  "bb" 'switch-to-buffer
  "bk" 'kill-buffer
  "pf" 'counsel-git
  "ps" 'helm-do-ag-project-root
  "0"  'select-window-0 
  "1"  'select-window-1
  "2"  'select-window-2
  "3"  'select-window-3
  "w/" 'split-window-right
  "w-" 'split-window-below
  "SPC" 'counsel-M-x
  "wM" 'delete-other-windows
  "qq" 'save-buffers-kill-terminal
  "s'" 'org-edit-special
  "ss" 'org-babel-mark-block
  "srs" 'scheme-send-region
  )
(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  (add-hook 'occur-mode-hook
            (lambda ()
              (evil-add-hjkl-bindings occur-mode-map 'emacs
                (kbd "/")      'evil-search-forward
                (kbd "n")      'evil-search-next
                (kbd "N")      'evil-search-previous
                (kbd "C-d")    'evil-scroll-down
                (kbd "C-u")    'evil-scroll-up
                )))
  (add-hook 'dired-mode-hook
            (lambda ()
              (evil-add-hjkl-bindings dired-mode-map 'emacs
                (kbd "/")      'evil-search-forward
                (kbd "n")      'evil-search-next
                (kbd "N")      'evil-search-previous
                (kbd "C-d")    'evil-scroll-down
                (kbd "C-u")    'evil-scroll-up
                )))
  (add-hook 'recentf-dialog-mode-hook
            (lambda ()
              (evil-add-hjkl-bindings recentf-dialog-mode-map 'emacs
                (kbd "/")      'evil-search-forward
                (kbd "n")      'evil-search-next
                (kbd "N")      'evil-search-previous
                (kbd "C-d")    'evil-scroll-down
                (kbd "C-u")    'evil-scroll-up
                )))


(provide 'init-keybindings)
