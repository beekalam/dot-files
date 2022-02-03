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

(defun f-read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(defun f-read-string (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun my-open-with ()
  "Simple function that allows us to open the underlying
    file of a buffer in an external program."
  (interactive)
  (when buffer-file-name
    (shell-command (concat
                    (if (eq system-type 'darwin)
                        "open"
                      (read-shell-command "Open current file with: "))
                    " "
                    (format "\"%s\"" (buffer-file-name))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
;; take from  https://github.com/andreicristianpetcu/dotfiles/blob/2f885027ec43e5fba8ff80d30ec501ac2dd4c3b0/spacemacs#L264-L292
(defun copy-to-clipboard ()
  "Copies selection to x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard!")
        (call-interactively 'clipboard-kill-ring-save)
        )
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
  )

(defun paste-from-clipboard ()
  "Pastes from x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (clipboard-yank)
        (message "graphics active")
        )
    (insert (shell-command-to-string "xsel -o -b"))
    )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my/helm-find-file-recursively()
  "Recursively find files in glob mannner, in the specified directory"
  (interactive)
  (helm-find 'ask-for-dir))
;;; form https://zck.me/emacs-move-file
;;; move current file and delete  it from the current location
(defun move-file (new-location)
  "Write this file to NEW-LOCATION, and delete the old one."
  (interactive (list (expand-file-name
                      (if buffer-file-name
                          (read-file-name "Move file to: ")
                        (read-file-name "Move file to: "
                                        default-directory
                                        (expand-file-name (file-name-nondirectory (buffer-name))
                                                          default-directory))))))
  (when (file-exists-p new-location)
    (delete-file new-location))
  (let ((old-location (expand-file-name (buffer-file-name))))
    (message "old file is %s and new file is %s"
             old-location
             new-location)
    (write-file new-location t)
    (when (and old-location
               (file-exists-p new-location)
               (not (string-equal old-location new-location)))
      (delete-file old-location))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; from https://emacs.stackexchange.com/questions/7650/how-to-open-a-external-terminal-from-emacs
(defun run-gnome-terminal-here ()
  "opens a gnome-terminal"
  (interactive "@")
  (shell-command (concat "gnome-terminal "
                         (file-name-directory (or load-file-name buffer-file-name))
                         " > /dev/null 2>&1 & disown") nil nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun make-popup-item (k v)
  (popup-make-item k :value v))

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
    (setq selected (popup-menu* popup-list))

    (when selected
      (switch-to-buffer (find-file-noselect selected)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my/open-project-code ()
  "opens current project in vscode"
  (interactive)
  (let (
        (proj (project-current)))
    (when proj
      (setq cmd-str (concat "code " (cdr (project-current))))
      (shell-command cmd-str)
      )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; timer functions
(defun my/timer()
  (interactive)
  (let (
        (interval (read-string "Interval: "))
        (timer-message (or (read-string "message:" "time's up"))))
    (run-at-time interval nil #'my/alert timer-message)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; @laravel ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun current-project-path()
  "Returns the path to the current project"
  (cdr (project-current)))


(defun laravel-artisan-read-cmd-string(&optional line)
  (read-string (or line "php artisan")))

(defun laravel-artisan-build-cmd-str(cmd)
  (format "php %sartisan %s" (current-project-path) cmd))

(defun laravel-artisan-run(cmd)
  (shell-command cmd))

(defun laravel-artisan-read-run(prompt &optional extra)
  (laravel-artisan-run
   (laravel-artisan-build-cmd-str
    (if (nil? extra)
        (laravel-artisan-read-cmd-string prompt)
      (concat extra (laravel-artisan-read-cmd-string (concat prompt  extra)))))))

(defun laravel-artisan()
  (interactive)
  (laravel-artisan-read-run "php artisan "))

(defun laravel-artisan-make-controller()
  (interactive)
  (laravel-artisan-read-run "php artisan " "make:controller "))

(defun laravel-artisan-make-model()
  (interactive)
  (laravel-artisan-read-run "php artisan " "make:model"))

(defun laravel-artisan-migrate()
  (interactive)
  (laravel-artisan-read-run "php artisan " "migrate"))

(defun laravel-artisan-migrate-refresh()
  (interactive)
  (laravel-artisan-read-run "php artisan " "migrate:refresh"))

(defun laravel-shell()
  (interactive)
  (let ((default-directory (current-project-path)))
    (shell)))

(defun s-remove-blank-lines (str)
  (s-join
   "\n"
   (seq-filter
    '(lambda (line) (not (s-blank-p line)))
    (s-lines str))))

(defun run-tinker()
  (interactive)
  (unless (file-exists-p (concat (lsp-workspace-root) "/" "artisan"))
      (error "Could not find artisan"))

  (when (not  (get-process "tinker"))
    (start-process "tinker"
                   "*tinker*"
                   "php"
                   (concat (lsp-workspace-root) "/" "artisan")
                   "tinker"))
  (process-send-string
   "tinker"
   (s-replace "<?php"
              ""
              (buffer-substring-no-properties (point-min) (point-max))))

  (sleep-for 0.5)
  (with-current-buffer "*tinker*"
    (ansi-color-apply-on-region (point-min) (point-max))
    (set-window-point (get-buffer-window "*tinker*") (point-max))
    ))

;; (laravel-artisan-run
;; (laravel-artisan-build-cmd-str
;;   (concat "make:controller "
;;           (laravel-artisan-read-cmd-string "php artisan make:controller ")))))

;; (laravel-artisan-run
;;  (laravel-artisan-build-cmd-str
;;   (concat "make:controller "
;;           (laravel-artisan-read-cmd-string "php artisan make:controller ")))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun number-format (num &optional size char)
  "Format NUM as string grouped to SIZE with CHAR."
  ;; Based on code for `math-group-float' in calc-ext.el
  (let* ((size (or size 3))
         (char (or char ","))
         (str (if (stringp num)
                  num
                (number-to-string num)))
         ;; omitting any trailing non-digit chars
         ;; NOTE: Calc supports BASE up to 36 (26 letters and 10 digits ;)
         (pt (or (string-match "[^0-9a-zA-Z]" str) (length str))))
    (while (> pt size)
      (setq str (concat (substring str 0 (- pt size))
                        char
                        (substring str (- pt size)))
            pt (- pt size)))
    str))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; @php ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun php-eval-buffer()
  (interactive)
  (shell-command (concat "php -a " (buffer-file-name))))


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

;; http://sachachua.com/notebook/emacs/small-functions.el
(defun strip-html ()
  "Remove HTML tags from the current buffer,
   (this will affect the whole buffer regardless of the restrictions in effect)."
  (interactive "*")
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "<[^<]*>" (point-max) t)
        (replace-match "\\1"))
      (goto-char (point-min))
      (replace-string "&copy;" "(c)")
      (goto-char (point-min))
      (replace-string "&amp;" "&")
      (goto-char (point-min))
      (replace-string "&lt;" "<")
      (goto-char (point-min))
      (replace-string "&gt;" ">")
      (goto-char (point-min)))))

(defun xah-insert-random-number (NUM)
  "Insert NUM random digits.
NUM default to 5.
Call `universal-argument' before for different count.
URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
Version 2017-05-24"
  (interactive "P")
  (let (($charset "1234567890" )
        ($baseCount 10))
    (dotimes (_ (if (numberp NUM) (abs NUM) 5 ))
      (insert (elt $charset (random $baseCount))))))


(defun xah-insert-random-string (NUM)
  "Insert a random alphanumerics string of length 5.
The possible chars are: A to Z, a to z, 0 to 9.
Call `universal-argument' before for different count.
URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
Version 2018-08-03"
  (interactive "P")
  (let* (($charset "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
         ($baseCount (length $charset)))
    (dotimes (_ (if (numberp NUM) (abs NUM) 5))
      (insert (elt $charset (random $baseCount))))))

(defun xah-escape-quotes (@begin @end)
  "Replace 「\"」 by 「\\\"」 in current line or text selection.
See also: `xah-unescape-quotes'

URL `http://ergoemacs.org/emacs/elisp_escape_quotes.html'
Version 2017-01-11"
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-end-position))))
  (save-excursion
    (save-restriction
      (narrow-to-region @begin @end)
      (goto-char (point-min))
      (while (search-forward "\"" nil t)
        (replace-match "\\\"" "FIXEDCASE" "LITERAL")))))

(defun xah-unescape-quotes (@begin @end)
  "Replace  「\\\"」 by 「\"」 in current line or text selection.
See also: `xah-escape-quotes'

URL `http://ergoemacs.org/emacs/elisp_escape_quotes.html'
Version 2017-01-11"
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-end-position))))
  (save-excursion
    (save-restriction
      (narrow-to-region @begin @end)
      (goto-char (point-min))
      (while (search-forward "\\\"" nil t)
        (replace-match "\"" "FIXEDCASE" "LITERAL")))))

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
;;;;;;;;;;;;;;;;;; notes ;;;;;;;;;;;;;;;;;;;;;;;;
(defun zk-new-note()
  "Creates a new note."
  (interactive)
  (setq note-title (read-string "note title: "))
  (setq note-tags (read-string "note tags (#tag):"))
  ;; (setq filepath (zk-note-path note-title ))
  (setq file (format-time-string "%Y%m%d%H%M%S"))
  ;; (setq filepath (concat (projectile-project-root) "zettle_notes/" file " " note-title ".md"))
  (setq filepath (concat  "/home/moh/Documents/notes/zettle_notes/" file " " note-title ".md"))
  ;; (setq filepath (concat  "/tmp/" note-title " " file ".md"))
  (write-region
   (concat "# " note-title "\ntags = " note-tags ) nil filepath)
  (find-file filepath))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-open-docs(@begin @end)
  (interactive "r")

  (let* ((word (buffer-substring-no-properties @begin @end))
         (url "https://devdocs.io/"))

    (when (equal major-mode 'go-mode)
      (browse-url (concat  url "go/#q=" word)   ))

    (when (equal major-mode 'python-mode)
      (browse-url (concat  url "python/#q=" word)   ))
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

;;https://emacs.stackexchange.com/questions/60661/how-to-duplicate-a-file-in-dired
(defun dired-duplicate-this-file ()
  "Duplicate file on this line."
  (interactive)
  (let* ((this  (dired-get-filename t))
         (ctr   1)
         (new   (format "%s[%d]" this ctr)))
    (while (file-exists-p new)
      (setq ctr  (1+ ctr)
            new  (format "%s[%d]" this ctr)))
    (dired-copy-file this new nil))
  (revert-buffer))

;; (defun run-go-script ()
;;   "opens a gnome-terminal"
;;   (interactive "@")
;;   (shell-command (concat "/bin/bash -c 'sleep 3' & disown ")))


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
