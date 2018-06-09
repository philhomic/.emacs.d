;; set code highlight in org mode
(require 'org)
(setq org-src-fontify-natively t)
;; config org-bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))) ;; do [M-x eval-region]

(provide 'init-org)
