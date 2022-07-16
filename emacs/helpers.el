;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
        (transpose-lines arg))
      (forward-line -1)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))


(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun int? (input)
  (typep input 'integer))

(defun string? (input)
  (typep input 'string))


(defun my-message (input)
  (let (type-specifier)
    (setq type-specifier "%s")

    (when (int? input)
      (setq type-specifier "%d"))

    (when (listp input)
      (mapconcat
       #'(lambda (x) (concat x " "))
       input
       " "))

    (message (format  type-specifier  input))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my/current-buffer-directory ()
  (interactive)
  "current buffer basename"
  (let (current-buffer-file-name)
    (setq current-buffer-file-name (buffer-file-name (current-buffer)))
    (if (not (equal current-buffer-file-name nil))
        (file-name-directory current-buffer-file-name)

      ;; if we are in dired mode
      (when (equal major-mode 'dired-mode)
        (dired-current-directory))

      )))

(defun my/current-buffer-open()
  "opens current buffer in system file explorer"
  (interactive)
  (let (cbd)
    (setq cbd (my/current-buffer-directory))
    (when (not (equal cbd nil))
      (shell-command (format "xdg-open %s" cbd))
      )
    )
  )

(defun my/alert (msg)
  (shell-command (concat "notify-send " "\"" msg "\"")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my/helm-find-file-recursively()
  "Recursively find files in glob mannner, in the specified directory"
  (interactive)
  (helm-find 'ask-for-dir))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-popup-item (k v)
  (popup-make-item k :value (concat v "")))



;; (popup-menu* '("Foo" "Bar" "Baz")
;;              :point (window-start)
;;              :isearch t
;;              ;; :isearch (lambda()
;;              ;;            (message "in isearch"))
;;              )


;; (got-char (window-start))

;; (progn
;;   (setq popup (popup-create (point) 10 10))
;;   (popup-set-list popup '("Foo" "Bar" "Baz"))
;;   (popup-draw popup)
;;   ;; do something here
;;    ;; (popup-delete popup)
;;   )

(defun show-directory-popup ()
  "show current directory files in a popup"
  (interactive)
  (let* (
         (current-dir (file-name-directory (buffer-file-name)))
         (current-dir-files (directory-files current-dir))
         (popup-list nil)
         (selected nil))

    (setq popup-list (mapcar
                      (lambda (item)
                        (make-popup-item item (concat current-dir item)))
                      current-dir-files))
    (setq selected
          (popup-menu* popup-list
                       :width 70
                       :point (window-start)
                       :isearch t
                       :scroll-bar t))

    (when selected
      (progn
        ;; (message selected)
        (switch-to-buffer (find-file-noselect selected))))))

;;; maybe show project buffers
;; todo add escape to kill the buffer
;; todo add ctrl+j and ctrl+k for movement
(defun show-buffers-popup()
  "Show buffers in popup"
  (interactive)
  (setq buffers (mapcar
                 (lambda (item)
                   (make-popup-item (buffer-name item) (buffer-name item)))
                 (buffer-list)))
  (setq selected
        (popup-menu* buffers
                     :width 70
                     :point (window-start)
                     :isearch t
                     :scroll-bar t))
  (when selected
    (progn
      (switch-to-buffer selected))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (let* ((alist '(("GNU" . "GNU is not Unix")
;;                 ("Emacs" . "Eight Megabytes And Constantly Swapping")))
;;        (annotf (lambda (str)
;;                  (format " (%s)" (cdr (assoc str alist))))))
;;   (completing-read "Candidates: "
;;                    (lambda (str pred action)
;;                      (if (eq action 'metadata)
;;                          `(metadata
;;                            (annotation-function . ,annotf)
;;                            (cycle-sort-function . identity)
;;                            (display-sort-function . identity))
;;                        (complete-with-action action alist str pred)))))

;; (find-file "/home/moh/Documents/notes/zettle_notes")

;; (read-from-minibuffer
;;  (concat
;;   (propertize "Bold" 'face '(bold default))
;;   (propertize " and normal: " 'face '(default))))


;; (try-completion
;;  "foo"
;;  '(("foobar1" 1) ("barfoo" 2) ("foobaz" 3) ("foobar2" 4)))

;; (completing-read
;;  "Complete a foo: "
;;  '(("foobar1" 1) ("barfoo" 2) ("foobaz" 3) ("foobar2" 4))
;;  nil t "fo")

(defun my/open-project-code ()
  "opens current project in vscode"
  (interactive)
  (let (
        (proj (project-current)))
    (when proj
      (setq cmd-str (concat "code " (cdr (project-current))))
      (shell-command cmd-str)
      )))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; @laravel ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (laravel-artisan-run
;; (laravel-artisan-build-cmd-str
;;   (concat "make:controller "
;;           (laravel-artisan-read-cmd-string "php artisan make:controller ")))))

;; (laravel-artisan-run
;;  (laravel-artisan-build-cmd-str
;;   (concat "make:controller "
;;           (laravel-artisan-read-cmd-string "php artisan make:controller ")))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; @php ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun php-eval-buffer()
;;   (interactive)
;;   (shell-command (concat "php -a " (buffer-file-name))))

(defun php-eval-buffer()
  (interactive)
  (let (buffer)
    (setq buffer (buffer-file-name))
    (when (= (length (window-list)) 1)
      (split-window-right))
    (other-window 1)
    (get-buffer-create "*PHPEVAL*")
    (switch-to-buffer "*PHPEVAL*")
    (erase-buffer)
    (insert (shell-command-to-string (concat "php -a " buffer)))
    (other-window 1)
    ))


(defun python-eval-buffer()
  (interactive)
  (shell-command (concat "python3 -B " (buffer-file-name))))


(defun my-buffer-eval()
  (interactive)
  (let (extension)
    (setq extension (my/current-buffer-file-extension))
    (cond
     ((s-equals-p extension "py") (python-eval-buffer))
     ((s-equals-p extension "php") (php-eval-buffer))
     ((s-equals-p extension "el") (eval-buffer)) ; if this is elisp
     ((s-equals-p  extension "go") (go-buffer-eval))
     )))

(defun go-buffer-eval()
  (interactive)
  (progn
    ;; (gofmt)
    ;; (go-remove-unused-imports)
    (save-buffer)
    (spacemacs/go-run-main)))

(defun save-and-eval-buffer()
  (interactive)
  (progn
    (save-buffer)
    (my-buffer-eval)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun postfix-complete()
  (interactive)
  (let* ((postfix-start (point))
         (postfix "")
         (delimiter nil)
         (content-end nil)
         (content ""))
                                        ; get postfix word
    (search-backward ".")
    (setq postfix (buffer-substring-no-properties (+ (point) 1) postfix-start))
    (delete-region (point) postfix-start)

    (setq delimiter (string (preceding-char)))
    (backward-char)
    (setq content-end (point))
    (backward-char)
    (cond

     ( (or (string= delimiter "\"") (string= delimiter "'") )
       (progn
         (search-backward  delimiter)
         (setq content (buffer-substring-no-properties (point) content-end))
         (insert postfix "(")
         (goto-char (+ content-end (length postfix) 2))
         (insert ")")))

     ((string= delimiter ")")
      (progn
        (let* ( (p (point))
                (bl nil)
                (bs nil)
                (target nil))
          ;; (beginning-of-thing 'sentence)
          ;; (setq bs (point))
          ;; (message "after bs")
          ;; (goto-char p)
          ;; (beginning-of-line)
          ;; (setq bl (point))
          ;; (goto-char p)
          ;; (if (> bs  bl)
          ;;     (setq target 'bl)
          ;;   (setq target 'bs))
          ;; (message "aftr if")
               ;;;
          ;; (beginning-of-thing 'sentence)
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          (python-nav-beginning-of-statement)
          (setq content (buffer-substring-no-properties (point) content-end))
          (insert postfix "(")
          (goto-char (+ content-end (length postfix) 2))
          (insert ")")
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; helper functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun nil?(&optional input)
  (equal input nil))

(defun not-nil? (&optional input)
  (not (nil? input)))

(defun my/filename (filename)
  "Get filename from a path"
  (nth 0 (last (s-split "\\/" filename))))

(defun my/file-extension (filename)
  "extract extension of a file"
  (let* (fname)
    (setq fname (my/filename filename))
    (setq splitted (s-split "\\." fname))
    (if (not-nil? fname)
        (nth 0 (last splitted)))))


(defun my/current-buffer-file-path ()
  "current buffer filepath string"
  (let (current-buffer-file-name)
    (setq current-buffer-file-name (buffer-file-name (current-buffer)))
    (identity current-buffer-file-name)))

(defun my/current-buffer-file-name()
  " if buffer is /tmp/text.py -> text.py"
  (my/filename (my/current-buffer-file-path)))

(defun my/current-buffer-file-extension()
  "if buffer is /tmp/text.el -> el"
  (my/file-extension (my/current-buffer-file-name)))

(defun end-of-line-point ()
  (save-excursion
    (end-of-line)
    (point)))

(defun beginning-of-line-point ()
  (save-excursion
    (beginning-of-line)
    (point)))

(defun my-join-lines (beg end)
  "Joins lines with separator"
  (interactive "r")
  (let* ((lines (buffer-substring-no-properties beg end))
         (lines-list (s-split "\n" lines))
         (separator (read-string "separator: ")))
    (delete-region beg end)
    (insert (s-join separator lines-list))))

(defun my-split-line (beg end)
  "Splits lines separated by commas"
  (interactive "r")
  (let* ((selection (buffer-substring-no-properties beg end))
         (splitted (s-split "," selection ))
         (joined (s-join "\n" splitted )))
    (delete-region beg end)
    (insert joined)))


(defun manage-minor-mode--active-list ()
  "Get a list of which minor modes are enabled in the current buffer."
  (let ($list)
    (mapc (lambda ($mode)
            (condition-case nil
                (if (and (symbolp $mode) (symbol-value $mode))
                    (setq $list (cons $mode $list)))
              (error nil)))
          minor-mode-list)
    (sort $list 'string<)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-surround-helper (beg-p end-p start end prefix)
  (let ( (s (concat prefix start)))
    (goto-char beg-p)
    (insert s)
    (goto-char (+ end-p (length s)))
    (insert end)
    (goto-char  beg-p)
    )
  )

(defun my-surround-with (beg end)
  "Surround a selected region"
  (interactive "r")
  (let (surround)
    ;; (delete-region beg end)
    (setq surround (s-trim (read-string "Surround with eg. print():" )))
    (cond ((s-ends-with? "()" surround)
           (my-surround-helper beg end "(" ")" (s-replace "()" "" surround))
           )
          )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun open-next-line()
  "Move to the next line and then opens a line."
  (interactive)
  (end-of-line)
  (newline-and-indent))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-open-docs(@begin @end)
  (interactive "r")

  (let* ((word (buffer-substring-no-properties @begin @end))
         (url "https://devdocs.io/"))

    (when (equal major-mode 'go-mode)
      (browse-url (concat  url "go/#q=" word)   ))

    (when (equal major-mode 'python-mode)
      (browse-url (concat  url "python/#q=" word)   ))
    (when (equal major-mode 'web-mode)
      (browse-url (concat url "html/#q=" word)  ))

    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-print-debug-python()
  (interactive)
  (let* ((vars (read-string "input vars to dump: "))
         (vars-joined ( s-join ","
                        (mapcar
                         '(lambda(var) (concat var ":{}"))
                         (s-split "," vars))))
         (format-str (concat "\"" vars-joined "\"" ".format(" vars ")")))

    (end-of-line)
    (newline-and-indent)
    (insert (concat "print(" format-str ")"))))

(defun my-print-debug-go()
  (interactive)
  (let* ((vars (read-string "input vars to dump: "))
         (vars-joined ( s-join ","
                        (mapcar
                         '(lambda(var) (concat var ":%v "))
                         (s-split "," vars))))
         (format-str (concat "\"" vars-joined "\\n\"" )))

    (end-of-line)
    (newline-and-indent)
    (insert (concat "fmt.Printf(" format-str "," vars ")"))))

(defun my-print-debug()
  (interactive)
  (cond
   ((equal major-mode 'python-mode) (my-print-debug-python))
   ((equal major-mode 'go-mode) (my-print-debug-go))))

(defun switch-to-terminal()
  "Switch to terminal or creates one"
  (interactive)
  (if (buffer-live-p (get-buffer "*terminal*"))
      (if (eq (current-buffer) (get-buffer "*terminal*"))
          (previous-buffer)
        (switch-to-buffer (get-buffer "*terminal*")))
    (term "/bin/bash")
    ))


;; (defun run-go-script ()
;;   "opens a gnome-terminal"
;;   (interactive "@")
;;   (shell-command (concat "/bin/bash -c 'sleep 3' & disown ")))

(provide 'helpers)
