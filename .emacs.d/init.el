(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(setq visible-bell t)
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen .maximized))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package doom-modeline
  :init (doom-modeline-mode -1)
  :custom ((doom-modeline-height 15)))
(use-package doom-themes
  :init (load-theme 'doom-dracula t))
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done))
  :config
  (ivy-mode 1))

(use-package hydra)
(use-package ace-window)
(global-set-key (kbd "C-M-o")
		(defhydra hydra-window ()
		  "window"
		  ("h" windmove-left)
		  ("j" windmove-down)
		  ("k" windmove-up)
		  ("l" windmove-right)
		  ("v" (lambda ()
			 (interactive)
			 (split-window-right)
			 (windmove-right))
		   "vert")
		  ("x" (lambda ()
			 (interactive)
			 (split-window-below)
			 (windmove-down))
		   "horz")
		  ("t" transpose-frame "'")
		  ("o" delete-other-windows "one" :color blue)
		  ("a" ace-window "ace")
		  ("s" ace-swap-window "swap")
		  ("d" ace-delete-window "del")
		  ("i" ace-maximize-window "ace-one" :color blue)
		  ("b" ido-switch-buffer "buf")
		  ("m" headlong-bookmark-jump "bmk")
		  ("q" nil "cancel")))
(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)
(global-display-line-numbers-mode t)
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dired-hide-dotfiles all-the-icons-dired dired-single ace-window hydra evil-collection counsel swiper ivy evil doom-modeline use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
