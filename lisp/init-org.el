;; set code highlight in org mode
(require 'org)
(setq org-src-fontify-natively t)
(setq org-startup-indented t)
;; config org-bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))) ;; do [M-x eval-region]
;; config org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh         . t)
   (js         . t)
   (emacs-lisp . t)
   (python     . t)
   (ruby       . t)
   (scheme     . t)
   (css        . t)))

(provide 'init-org)
