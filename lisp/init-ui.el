; turn off tool-bar
(tool-bar-mode -1)
;; turn off scroll-bar
(scroll-bar-mode -1)
;; turn off splash screen
(setq inhibit-splash-screen t)
;; set cursor style
(setq-default cursor-type 'bar)
;; open with full screen
;; (setq initial-frame-alist (quote ((fullscreen . maximized))))
;; highlight current line
(global-hl-line-mode t)

(provide 'init-ui)
