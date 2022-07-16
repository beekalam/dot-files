(defvar notes-path "/mnt/11D3A2BE6C7F0676/notes/zettle_notes")
(require 'f)
(require 'cl-seq)
(require 'cl-macs)
(require 'dash)
(require 'logging)

;; (add-hook 'markdown-mode 'zk-colorize-links)
;; (add-hook 'after-save-hook 'zk-colorize-links)

;; (add-hook 'markdown-mode
;;           (lambda ()
;;             (zk-colorize-links)))

;; (add-hook 'markdown-mode
;;           (lambda ()
;;             (zk-render-image-links)))



(defun zk-render-image-links()
  (interactive)
  (setq image-regex "!\\[\\[\\(.*png\\)\\]\\]")

  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward image-regex nil t)
      (setq begin (match-beginning 1))
      (setq end (match-end 1))
      (setq path (f-join (f-dirname (buffer-file-name)) (buffer-substring-no-properties begin end)))
      (setq image (create-image path))
      (setq beg (+ 1 (line-end-position)))
      (setq end (+ 2 (line-end-position)))
      (let ((ov (make-overlay  beg end)))
        (overlay-put ov 'display image)
        (overlay-put ov 'face 'default)))))

;; (remove-hook 'markdown-mode
;;              (lambda ()
;;                (zk-colorize-links)))

(defun zk-colorize-links()
  (interactive)
  (setq links-regex "\\(\\[\\[\\)\\(.*\\)\\(\\]\\]\\)")
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward links-regex nil t)
      (setq begin (match-beginning 0))
      (setq end (+ 2 (match-end 2)))
      (overlay-put
       (make-overlay begin end)
       'font-lock-face
       '(:foreground "red")))))

;; (defun zk-colorize-links()
;;   (interactive)
;;   (setq links-regex "\\(\\[\\[\\)\\(.*\\)\\(\\]\\]\\)")
;;   (save-excursion
;;     (goto-char (point-min))
;;     (while (re-search-forward links-regex nil t)
;;       (put-text-property (match-beginning 0)
;;                          (+ 2 (match-end 2))
;;                          'font-lock-face
;;                          '(:foreground "red")))))

(defun zk-colorize-links_22()
  (interactive)
  (setq links-regex "\\(\\[\\[\\)\\(.*\\)\\(\\]\\]\\)")
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward links-regex nil t)
      (put-text-property (match-beginning 0)
                         (+ 2 (match-end 2))
                         'font-lock-face
                         '(:foreground "red")))))


(defun zk-open-link-at-point ()
  (interactive)
  (save-excursion
    (re-search-backward "\\[\\[" nil t)
    (setq start (point))
    (re-search-forward "\\]\\]" nil t)
    (setq end (point))
    (setq filename (buffer-substring-no-properties start end))
    (setq filename (s-replace "[" "" filename))
    (setq filename (s-replace "]" "" filename))
    (when (s-contains? "|" filename)
      (setq filename (first (s-split "|" filename)))
      (setq filename (s-trim-right filename)))
    (setq filename (concat filename ".md"))
    (setq filepath (concat  notes-path "/" filename))
    (when (f-exists-p filepath)
      (find-file filepath))))

(global-set-key (kbd "<mouse-1>") 'zk-open-link-at-point)
(global-set-key (kbd "<mouse-3>") 'previous-buffer )

(defun zk-make-link (link &optional description)
  (let (res)
    (setq res (concat "[[" link))

    (if description
        (setq res (concat res "|" (s-capitalized-words description))))

    (setq res (concat res "]]"))

    (identity res)))

(defun zk-annotate-meta-links()
  (interactive)
  (let* ((regex "\\(\\[\\[\\)\\([0-9]+\\)\\(.*\\)\\(\\]\\]\\)"))
    (save-excursion
      (save-restriction
        (widen)
        (goto-char (point-min))
        (while (re-search-forward regex (point-max) t)
          ;; skip annotated links
          (when (not (s-contains? "|"
                                  (buffer-substring-no-properties (match-beginning 0) (match-end 0))))
            (progn
              ;; (replace-match "[[\\2\\3|\\3]]")
              (replace-match (zk-make-link (concat (match-string 2) (match-string 3))
                                           (match-string 3)))
              )
            ))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun s-split-join(split join str)
  "splits string by split and rejoin them with join"
  (unless  (s-blank-p (s-trim str))
    (s-trim (concat join
                    (s-join join
                            (s-split split str))))))

(defun s-contain-words? (str words)
  "return true if str contains all words"
  (cl-reduce
   #'(lambda (acc word) (and (s-contains? word str t) acc))
   words
   :initial-value t))

(defun search-notes2 (term)
  (setq words (s-split " " term))
  (setq files (directory-files notes-path t "\\.md"))
  (setq res nil)

  (progn
    (mapcar
     #'(lambda (file)
         (when (s-contain-words? (f-read-text file) words)
           (push file res)))
     files)
    (identity res)
    )
  )

(defun search-notes (term)
  (let* ((words (s-split " " term))
         (files (directory-files notes-path t "\\.md")))

    (cl-defun f-has-words(file)
      (s-contain-words? (f-read-text file) words))

    (-filter #'f-has-words files)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (note-tags (mapconcat (lambda (x) (concat "#" x))
;;                       (s-split " " note-tags) " "))

(defun zk-save-region-as-note ()
  (interactive)

  (when (use-region-p)
    (let (region-text)
      (setq region-text (buffer-substring-no-properties
                         (region-beginning)
                         (region-end)))

      (when (s-starts-with-p "# " region-text)
        (let (region-lines title content)
          (setq region-lines (s-split "\n" region-text))
          (setq title (s-trim
                       (s-replace "#" "" (first region-lines))))
          (setq content (s-join "\n" (cdr region-lines)))
          (zk-save-note title "#programming-problem" content))))))

(defun zk-save-note (title &optional tags  content)
  (let* ((ts (format-time-string "%Y%m%d%H%M"))
         (file-name (format "%s %s.md" ts title))
         (filepath (format  "%s/%s" notes-path file-name))
         (note-created-at  (format-time-string "%Y-%m-%d %H:%M"))
         (_content (if (null content)
                       (identity "")
                     (identity content)))
         (res (concat "# " title
                      "\ntags = " tags
                      "\ncreated: " note-created-at "\n"
                      (format "%s\n" _content)
                      "\n\n## References\n"
                      "## Related\n")))
    (write-region res nil filepath)
    (find-file filepath)))

(defun zk-new-note()
  "Creates a new note."
  (interactive)
  (let* ((note-title (read-string "note title: "))
         (note-tags (read-string "note tags (#tag):"))
         (note-tags (s-split-join " " " #" note-tags )))
    (zk-save-note note-title note-tags)))

;; (let* ((note-title (read-string "note title: "))
;;        (note-tags (read-string "note tags (#tag):"))
;;        (note-tags (s-split-join " " " #" note-tags ))
;;        (ts (format-time-string "%Y%m%d%H%M"))
;;        (file-name (format "%s %s.md" ts note-title))
;;        (filepath (format  "%s/%s" notes-path file-name))
;;        (note-created-at  (format-time-string "%Y-%m-%d %H:%M"))
;;        (res (concat "# " note-title
;;                         "\ntags = " note-tags
;;                         "\ncreated: " note-created-at "\n"
;;                         "\n\n## References\n"
;;                         "## Related\n")))

;;   (write-region res nil filepath)
;;   (find-file filepath)))

(defun zk-search-notes2 (search-term)
  (log-to-file (concat "term: " search-term))
  (setq parts (s-split " " search-term))
  (setq tag (first parts))
  (setq term (s-join " " (cdr parts)))
  (log-to-file (concat "terM: " term))
  (setq template "IFS=$'\n' && for f in `grep -R -H \"tags.*=.*#%s\" %s/*.md | cut -d':' -f1 | sed -e 's/ /\\ /'`; do grep -i -H '%s' \"$f\"; done")
  (setq cmd-str (format template tag notes-path term))
  ;; (log-to-syslog (s-replace "\n" " " cmd-str))
  (insert cmd-str)
  (setq res (s-split "\n" (shell-command-to-string cmd-str)))
  (mapc (lambda (x) (list  x x)) res)
  )

(defun zk-search()
  (interactive)
  (let* ((input (read-from-minibuffer "words: "))
         (notes (mapc (lambda(x) (list x x)) (search-notes input)))
         (res (completing-read "term: " notes nil t)))
    (find-file res)))


(add-hook 'markdown-mode (lambda()
                           (log-to-syslog "inside lambda")
                           (zk-colorize-links)
                           (zk-render-image-links)))

(add-hook 'gfm-mode-hook (lambda()
                           (log-to-syslog "inside lambda")
                           (zk-colorize-links)
                           (zk-render-image-links)))

(add-hook 'markdown-mode-hook 'zk-render-image-links)
(provide 'zk-notes)
