;;; Config file

;; Saving emacs sessions.
;;(desktop-save-mode 1)

;; Default directory
(setq default-directory "~/")

;; N XML
(load "~/.emacs.d/nxml-mode-20041004/rng-auto.el")
(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))


;;Markdown highlighting
;;(add-to-list 'load-path "~/.emacs.d/")
(load "~/.emacs.d/markdown-mode.el")
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;;; Enable clipboard
 (setq x-select-enable-clipboard t)
;;; Use only space
(setq-default indent-tabs-mode nil)
;;; More Lisp configuration
(global-font-lock-mode t)
(show-paren-mode 1)
(add-hook 'lisp-mode-hook '(lambda ()
      (local-set-key (kbd "RET") 'newline-and-indent)))
;;;
;;;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )



;;; 4 space intent in C
(setq c-default-style "bsd"
      c-basic-offset 4)


;;Disables Normal backup not do destroy hard links
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; tool-bar-mode disabled
(tool-bar-mode -1)
;; mapping auto-complete
;;(global-set-key (kbd "M-p") 'next-line)

(require 'iso-transl)

;; Color settings
(set-background-color "black")
(set-foreground-color "green")
(set-cursor-color "white")
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; I spell and some stuff

;; Diable menu
(menu-bar-mode -99)
;; ASpell
(setq ispell-extra-args '("--sug-mode=fast"))
(setq tab-width 4)


;;(dolist (hook '(text-mode-hook))
;; (add-hook hook (lambda () (flyspell-mode 1))))
;;(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
;;  (add-hook hook (lambda () (flyspell-mode -1))))

;; easy spell check
;;(global-set-key (kbd "<f8>") 'ispell-word)
;;(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
;;(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
;;(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
;;(defun flyspell-check-next-highlighted-word ()
;;  "Custom function to spell check next highlighted word"
;;  (interactive)
;;  (flyspell-goto-next-error)
;;  (ispell-word)
;;  )
;;(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)


;; delete-horizontal-space
(defun kill-whitespace ()
  "Kill the whitespace between two non-whitespace characters"
  (interactive "*")
  (save-excursion
    (save-restriction
      (save-match-data
	(progn
	  (re-search-backward "[^ \t\r\n]" nil t)
	  (re-search-forward "[ \t\r\n]+" nil t)
	  (replace-match "" nil nil))))))
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Org Mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files '("C:/work/org"))
