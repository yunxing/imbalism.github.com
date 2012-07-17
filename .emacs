(setq visible-bell t)
(setq x-select-enable-clipboard t)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)
(global-set-key (kbd "M-g M-g") 'goto-line)
(add-to-list 'load-path "~/.emacs.d/")

(setq load-path (cons  "/usr/lib64/erlang/lib/tools-2.6.4/emacs"
                       load-path))
(setq erlang-root-dir "/usr/lib64/erlang/")
(setq exec-path (cons "/usr/lib64/erlang/bin" exec-path))
(require 'erlang-start)


(add-to-list 'load-path "/home/yunxing/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/yunxing/.emacs.d//ac-dict")
(ac-config-default)

(setq auto-save-default nil)
(setq make-backup-files nil)

(setq-default indent-tabs-mode nil)

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )
(require 'autopair)
(autopair-global-mode)

(add-hook 'c-mode-hook
	  '(lambda ( )
	     (c-set-style "k&r")))
(global-auto-revert-mode t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(transient-mark-mode nil)

(require 'multi-eshell)

(global-set-key [f5] 'multi-eshell)
(global-set-key [f6] 'multi-eshell-switch)
(global-set-key [f7] 'multi-eshell-go-back)
(setq compilation-scroll-output t)

;pyflakes!
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "/usr/local/bin/pyflakes" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(defun SS-fly-pop ()
  "CSH: Show error using my popup function."
  (interactive)
  (let* ((line (count-lines 1 (1+ (point))))
         (err-cdr (car (cdr (assoc line flymake-err-info))))
         next-msg final-msg)
    (while err-cdr
      (setq next-msg (aref (pop err-cdr) 4))
      (setq final-msg (cons next-msg final-msg)))
    (PO-popup-picker final-msg 'show)))



(add-hook 'find-file-hook 'flymake-find-file-hook)

(global-set-key (kbd "ESC <left>") 'windmove-left)          ; move to left windnow
(global-set-key (kbd "ESC <right>") 'windmove-right)        ; move to right window
(global-set-key (kbd "ESC <up>") 'windmove-up)              ; move to upper window
(global-set-key (kbd "ESC <down>") 'windmove-down)          ; move to downer window
(require 'goto-last-change)
(global-set-key "\C-q" 'goto-last-change)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(require 'undo-tree)
(global-undo-tree-mode)
