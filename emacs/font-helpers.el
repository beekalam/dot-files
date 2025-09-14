
(defun set-font-sf-mono()
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:family "SF Mono"
                          :foundry "APPL"
                          :slant normal
                          :weight normal
                          :height 151
                          :width normal)))))
  )

(defun set-font-operator-mono()
  (interactive)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   (custom-set-faces
    '(default ((t (:height 170 :weight light :family "Operator Mono"))))
    '(font-lock-comment-face ((t (:inherit default :slant italic :family "Operator Mono"))))
    '(font-lock-constant-face ((t (:slant italic :weight light :family "Operator Mono"))))
    '(font-lock-function-name-face ((t (:slant normal :weight light :family "Operator Mono"))))
    '(font-lock-keyword-face ((t (:slant normal :weight light :family "Operator Mono"))))
    '(font-lock-preprocessor-face ((t (:weight light :family "Operator Mono"))))
    '(font-lock-string-face ((t (:slant italic :weight light :family "Operator Mono"))))
    '(hl-todo ((t (:slant italic :weight normal :family "Operator Mono"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    '(font-lock-variable-name-face (( t(:weight light :family "Operator Mono"))))
    '(font-lock-reference-face (( t(:weight light :family "Operator Mono"))))
    '(font-lock-builtin-face (( t(:weight light :family "Operator Mono"))))
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    '(info-colors-lisp-code-block ((t (:inherit font-lock-variable-name-face))))
    '(markdown-code-face ((t (:inherit font-lock-constant-face))))
    )))



(defun set-font-jetbrains-mono()
  (interactive)
  (custom-set-faces
   '(default ((t (:height 150 :family "JetBrains Mono" :weight Medium))))
   '(aw-leading-char-face ((t (:foreground "firebrick" :height 4.0))))
   '(font-lock-comment-face ((t (:inherit default :slant italic))))
   '(font-lock-constant-face ((t (:slant italic :weight bold))))
   '(font-lock-function-name-face ((t (:slant italic :weight bold))))
   '(font-lock-keyword-face ((t (:slant italic :weight bold))))
   '(font-lock-preprocessor-face ((t (:weight bold))))
   '(font-lock-string-face ((t (:slant italic))))
   '(hl-todo ((t (:slant italic :weight bold))))
   '(info-colors-lisp-code-block ((t (:inherit font-lock-variable-name-face))))
   '(markdown-code-face ((t (:inherit font-lock-constant-face))))
   ))

(defun set-font-dejavu-sans()
  (interactive)
  (custom-set-faces
   '(default ((t (:height 150 :family "DejaVu Sans Mono" :weight Medium))))
   '(aw-leading-char-face ((t (:foreground "firebrick" :height 4.0))))
   '(font-lock-comment-face ((t (:inherit default :slant italic))))
   '(font-lock-constant-face ((t (:slant italic :weight bold))))
   '(font-lock-function-name-face ((t (:slant italic :weight bold))))
   '(font-lock-keyword-face ((t (:slant italic :weight bold))))
   '(font-lock-preprocessor-face ((t (:weight bold))))
   '(font-lock-string-face ((t (:slant italic))))
   '(hl-todo ((t (:slant italic :weight bold))))
   '(info-colors-lisp-code-block ((t (:inherit font-lock-variable-name-face))))
   '(markdown-code-face ((t (:inherit font-lock-constant-face))))
   ))

(defun set-font-monolisa()
  (interactive)
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   (custom-set-faces
    '(default ((t (:height 170 :weight Regular :family "MonoLisa"))))
    '(font-lock-comment-face ((t (:inherit default :slant italic :family "MonoLisa"))))
    '(font-lock-constant-face ((t (:slant italic :weight light :family "MonoLisa"))))
    '(font-lock-function-name-face ((t (:slant normal :weight light :family "MonoLisa"))))
    '(font-lock-keyword-face ((t (:slant normal :weight light :family "MonoLisa"))))
    '(font-lock-preprocessor-face ((t (:weight light :family "MonoLisa"))))
    '(font-lock-string-face ((t (:slant italic :weight light :family "MonoLisa"))))
    '(hl-todo ((t (:slant italic :weight normal :family "MonoLisa"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    '(font-lock-variable-name-face (( t(:weight light :family "MonoLisa"))))
    '(font-lock-reference-face (( t(:weight light :family "MonoLisa"))))
    '(font-lock-builtin-face (( t(:weight light :family "MonoLisa"))))
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    '(info-colors-lisp-code-block ((t (:inherit font-lock-variable-name-face))))
    '(markdown-code-face ((t (:inherit font-lock-constant-face))))
    )))
(provide 'font-helpers)
