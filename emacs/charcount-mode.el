;; example minor mode from
;https://stackoverflow.com/questions/24724913/best-way-to-add-per-line-information-visually-in-emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; M-x char-count-mode

(defvar char-count-p nil
"When `char-count-p` is non-`nil`, the overlays are present.")
(make-variable-buffer-local 'char-count-p)

(defvar char-count-this-command nil
"This local variable is set within the `post-command-hook`; and,
is also used by the `window-scroll-functions` hook.")
(make-variable-buffer-local 'char-count-this-command)

(defvar char-count-overlay-list nil
"List used to store overlays until they are removed.")
(make-variable-buffer-local 'char-count-overlay-list)

(defun char-count-post-command-hook ()
"Doc-string."
  (setq char-count-this-command this-command)
  (character-count-function))

(defun character-count-window-scroll-functions (win _start)
"Doc-string."
  (character-count-function))

(defun equal-including-properties--remove-overlays (beg end name val)
  "Remove the overlays using `equal`, instead of `eq`."
  (when (and beg end name val)
    (overlay-recenter end)
    (dolist (o (overlays-in beg end))
      (when (equal-including-properties (overlay-get o name) val)
        (delete-overlay o)))))

(defun character-count-function ()
"Doc-string for the character-count-function."
  (when
      (and
        char-count-mode
        char-count-this-command
        (window-live-p (get-buffer-window (current-buffer)))
        (not (minibufferp))
        (pos-visible-in-window-p (point)
          (get-buffer-window (current-buffer) (selected-frame)) t) )
    (remove-char-count-overlays)
    (save-excursion
      (let* (
          counter
          (selected-window (selected-window))
          (window-start (window-start selected-window))
          (window-end (window-end selected-window t)) )
        (goto-char window-end)
        (catch 'done
          (while t
            (when counter
              (re-search-backward "\n" window-start t))
            (when (not counter)
              (setq counter t))
          (let* (
              (pbol (point-at-bol))
              (peol (point-at-eol))
              (raw-char-count (abs (- peol pbol)))
              (starting-column
                (propertize (char-to-string ?\uE001)
                  'display
                  `((space :align-to 1) (space :width 0))))
              (colored-char-count
                (propertize (number-to-string raw-char-count)
                  'face '(:background "gray50" :foreground "black")))
              (one-spacer
                (propertize (char-to-string ?\uE001)
                  'display
                  `((space :width 1))))
              (two-spacers
                (propertize (char-to-string ?\uE001)
                  'display
                  `((space :width 2))))
              (final-char-count
                (cond
                  ((and
                      (< raw-char-count 100)
                      (> raw-char-count 9))
                    (concat one-spacer colored-char-count))
                  ((< raw-char-count 10)
                    (concat two-spacers colored-char-count))
                  (t colored-char-count)))
              (ov-string (concat starting-column final-char-count two-spacers)) )
            (push ov-string char-count-overlay-list)
            (overlay-put (make-overlay pbol pbol) 'before-string ov-string) 
            (when (<= pbol window-start)
              (throw 'done nil)) )))
        (setq char-count-p t)))
     (setq char-count-this-command nil) ))

(defun remove-char-count-overlays ()
  (when char-count-p
    (require 'cl)
    (setq char-count-overlay-list
      (remove-duplicates char-count-overlay-list
        :test (lambda (x y) (or (null y) (equal-including-properties x y)))
        :from-end t))
    (dolist (description char-count-overlay-list)
      (equal-including-properties--remove-overlays (point-min) (point-max) 'before-string description))
    (setq char-count-p nil) ))

(defun turn-off-char-count-mode ()
  (char-count-mode -1))

(define-minor-mode char-count-mode
"A minor-mode that places the character count at the beginning of the line."
  :init-value nil
  :lighter " Char-Count"
  :keymap nil
  :global nil
  :group nil
  (cond
    (char-count-mode
      (setq scroll-conservatively 101)
      (add-hook 'post-command-hook 'char-count-post-command-hook t t)
      (add-hook 'window-scroll-functions
        'character-count-window-scroll-functions t t)
      (add-hook 'change-major-mode-hook 'turn-off-char-count-mode nil t)
      (message "Turned ON `char-count-mode`."))
    (t
      (remove-char-count-overlays)
      (remove-hook 'post-command-hook 'char-count-post-command-hook t)
      (remove-hook 'window-scroll-functions
        'character-count-window-scroll-functions t)
      (remove-hook 'change-major-mode-hook 'turn-off-char-count-mode t)
      (kill-local-variable 'scroll-conservatively)
      (message "Turned OFF `char-count-mode`.") )))

(provide 'char-count)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
