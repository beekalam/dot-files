(defun seq-to-string(seq)
  (mapconcat #'(lambda(item) (concat item "")) seq " "  ))

(defun type-str(var)
  (format "%s" (type-of var)))

(defun beekalam-replace-quotes ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "“\\|”" nil t)
      (replace-match  "\""))
    (goto-char (point-min))

    (while (re-search-forward "‘\\|’" nil t)
      (replace-match  "'"))

    ))

(defun xah-replace-straight-quotes (@begin @end)
  "Replace straight double quotes to curly ones, and others.
Works on current text block or selection.

Examples of changes:
 「\"…\"」 → 「“…”」
 「...」 → 「…」
 「I’m」 → 「I'm」
 「--」 → 「—」
 「~=」 → 「≈」

When called in lisp code, @begin and @end are region begin/end positions.

WARNING: this command does not guarantee 100% correct conversion of quotes, because it impossible. You should double check highlighted places after.

URL `http://xahlee.info/emacs/emacs/elisp_straight_curly_quotes.html'
Version 2018-03-02"
  ;; some examples for debug
  ;; do "‘em all -- done..."
  ;; I’am not
  ;; said "can’t have it, can’t, just can’t"
  ;; ‘I’ve can’t’
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (let ($p1 $p2)
       (save-excursion
         (if (re-search-backward "\n[ \t]*\n" nil "move")
             (progn (re-search-forward "\n[ \t]*\n")
                    (setq $p1 (point)))
           (setq $p1 (point)))
         (if (re-search-forward "\n[ \t]*\n" nil "move")
             (progn (re-search-backward "\n[ \t]*\n")
                    (setq $p2 (point)))
           (setq $p2 (point))))
       (list $p1 $p2))))

  (let ( (case-fold-search nil))
    (save-excursion
      (save-restriction
        (narrow-to-region @begin @end )
        ;; Note: order is important since this is huristic.
        (xah-replace-pairs-region
         (point-min) (point-max)
         [
          ;; dash and ellipsis etc
          ["--" " — "]
          ["—" " — "]
          ["..." "…"]
          [" & " " ＆ "]
          [" :)" " ☺"]
          [" :(" " ☹"]
          [" ;)" " 😉"]
          ["~=" "≈"]
          [" --> " " ⟶ "]
          [" , " ", "]
          ;; fix GNU style ASCII quotes
          ["``" "“"]
          ["''" "”"]
          ;; double straight quote → double curly quotes
          ["\n\"" "\n“"]
          [">\"" ">“"]
          ["(\"" "(“"]
          [" \"" " “"]
          ["\" " "” "]

          ["\", " "”, "]
          ["\",\n" "”,\n"]

          ["\". " "”. "]
          ["\".\n" "”.\n"]
          ["\"?" "”?"]
          ["\";" "”;"]
          ["\":" "”:"]
          ["\")" "”)"]
          ["\"]" "”]"]

          ;; ["\"[" "\”["]

          [".\"" ".”"]
          [",\"" ",”"]
          ["!\"" "!”"]
          ["?\"" "?”"]
          ["\"<" "”<"]
          ["\"\n" "”\n"]
          ] "REPORT" "HILIGHT")

        (xah-replace-pairs-region
         (point-min) (point-max)
         [
          ["  —  " " — "] ; rid of extra space in em-dash
          ] "REPORT" "HILIGHT")

        (xah-replace-pairs-region
         (point-min) (point-max)
         [
          [" —-> " " ⟶ "]
          [" <= " " ≤ "]
          [" >= " " ≥ "]
          ] "REPORT" "HILIGHT")

        ;; fix straight double quotes by regex
        (xah-replace-regexp-pairs-region
         (point-min) (point-max)
         [
          ["\\`\"" "“"]
          ] "FIXEDCASE" "LITERAL-P" "HILIGHT")

        ;; fix single quotes to curly
        (xah-replace-pairs-region
         (point-min) (point-max)
         [
          [">\'" ">‘"]
          [" \'" " ‘"]
          ["\' " "’ "]
          ["\'," "’,"]
          [".\'" ".’"]
          ["!\'" "!’"]
          ["?\'" "?’"]
          ["(\'" "(‘"]
          ["\')" "’)"]
          ["\']" "’]"]
          ] "REPORT" "HILIGHT")

        (xah-replace-regexp-pairs-region
         (point-min) (point-max)
         [
          ["\\bcan’t\\b" "can't"]
          ["\\bdon’t\\b" "don't"]
          ["\\bdoesn’t\\b" "doesn't"]
          ["\\bwon’t\\b" "won't"]
          ["\\bisn’t\\b" "isn't"]
          ["\\baren’t\\b" "aren't"]
          ["\\bain’t\\b" "ain't"]
          ["\\bdidn’t\\b" "didn't"]
          ["\\baren’t\\b" "aren't"]
          ["\\bwasn’t\\b" "wasn't"]
          ["\\bweren’t\\b" "weren't"]
          ["\\bcouldn’t\\b" "couldn't"]
          ["\\bshouldn’t\\b" "shouldn't"]

          ["\\b’ve\\b" "'ve"]
          ["\\b’re\\b" "'re"]
          ["\\b‘em\\b" "'em"]
          ["\\b’ll\\b" "'ll"]
          ["\\b’m\\b" "'m"]
          ["\\b’d\\b" "'d"]
          ["\\b’s\\b" "'s"]
          ["s’ " "s' "]
          ["s’\n" "s'\n"]

          ["\"$" "”"]
          ] "FIXEDCASE" "LITERAL-P" "HILIGHT")

        ;; fix back escaped quotes in code
        (xah-replace-pairs-region
         (point-min) (point-max)
         [
          ["\\”" "\\\""]
          ["\\”" "\\\""]
          ] "REPORT" "HILIGHT")

        ;; fix back. quotes in HTML code
        (xah-replace-regexp-pairs-region
         (point-min) (point-max)
         [
          ["” \\([-a-z]+\\)="       "\" \\1="] ; any 「” some-thing=」
          ["=”" "=\""]
          ["/” " "/\" "]
          ["\\([0-9]+\\)” "     "\\1\" "]
          ] "FIXEDCASE" nil "HILIGHT"
         )

        ))))

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

(defun strip-html-from-srt-file()
  "Removes font tags  and time lines and empty lines from srt file"
  (interactive "*")
  (save-excursion
    (save-excursion
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "^[0-9]*:[0-9]*.*-->.*" (point-max) t)
        (replace-match " "))

      (goto-char (point-min))
      (while (re-search-forward "^[0-9]*$" (point-max) t)
        (replace-match " "))

      (goto-char (point-min))
      (while (re-search-forward "<[^<]*>" (point-max) t)
        (replace-match "\\1"))
      (goto-char (point-min))
      (my-delete-blank-lines))))

(defun my-delete-blank-lines ()
  (interactive)
  (flush-lines "^[[:space:]]*$" (point-min) (point-max)))


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




;; from https://emacs.stackexchange.com/questions/7650/how-to-open-a-external-terminal-from-emacs
(defun run-gnome-terminal-here ()
  "opens a gnome-terminal"
  (interactive "@")
  (shell-command (concat "gnome-terminal "
                         (file-name-directory (or load-file-name buffer-file-name))
                         " > /dev/null 2>&1 & disown") nil nil))

(defun s-remove-blank-lines (str)
  (s-join
   "\n"
   (seq-filter
    '(lambda (line) (not (s-blank-p line)))
    (s-lines str))))

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
                    (format "\"%s\"" (buffer-file-name)))))

  (dired-open-file))

(defun dired-open-file()
  (interactive)
  (when (equal major-mode 'dired-mode)
    (when (s-ends-with-p ".pdf" (dired-file-name-at-point))
      (progn
        (setq cmdstr (concat "FoxitReader "
                             "\""
                             (expand-file-name
                              (dired-file-name-at-point))
                             "\""))
        (shell-command cmdstr)))))


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; timer functions
(defun my/timer()
  (interactive)
  (let (
        (interval (read-string "Interval: "))
        (timer-message (or (read-string "message:" "time's up"))))
    (run-at-time interval nil #'my/alert timer-message)))

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

(defun lookup-in-linguee()
  (interactive)
  (setq linguee-url (format "https://www.linguee.com/english-german/search?source=german&query=%s" (current-word)))
  (browse-url--browser linguee-url))

(defun strip-srt-file ()
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "^[0-9]+$" (point-max) t)
        (replace-match "\\1"))
      ))
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "^.* -->.*$" (point-max) t)
        (replace-match "\\1"))
      ))
  (xah-clean-empty-lines))

(defun strip-word (word)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward (format " %s " word) (point-max) t)
        (replace-match " "))
      (goto-char (point-min))
      (while (re-search-forward (format "%s " word) (point-max) t)
        (replace-match " "))

      ;; (goto-char (point-min))
      ;; (while (re-search-forward (format "%s, " word) (point-max) t)
      ;;   (replace-match " "))

      ;; (goto-char (point-min))
      ;; (while (re-search-forward (format "%s\\\\? " word) (point-max) t)
      ;;   (replace-match " "))

      ;; (goto-char (point-min))
      ;; (while (re-search-forward (format "%s\\\\." word) (point-max) t)
      ;;   (replace-match " "))
      )))

(defun strip-stop-words ()
  (interactive)
  (setq stop-words (list
                    "die" "der" "das"
                    "was" "was?" "Was?" "wie" "wie?" "Wie?" "wo" "wo?" "Wo?"
                    "wer" "wer?" "Wer?" "wann" "wann?" "Wann?" "sein" "dein" "du" "er" "Sie"
                    "warum?" "Warum?"
                    "Nein," "Nein" "nein" "den" "richtigen" "richtige" "richtiges"
                    "Es"
                    "ihr" "ihn" "ihnen" "sir" "Herr" "herr" "ok" "schon" "tut" "leid" "und?" "und"
                    "Als" "als" "weil" "willst" "hin" "mich" "an" "nicht"
                    "jede" "jeder" "jedes" "war" "alle" "welt" "Tor" "tor"
                    "jetzt" "ihm" "verdammt" "verdammt" "bitte" "Bitte" "dass" "er" "Ich" "muss" "ih"
                    "aus" "aber" "Aber" "Mehr" "mehr" "Zeit" "nicts" "Es" "es" "wo" "bist"
                    "sind" "seid" "Nein" "ja" "Das" "das" "ist" "all" "alles" "Gib" "mir" "etwas"
                    "Im" "im" "mit" "arschloch" "bei" "gab" "nur" "so" "viel" "verdammt" "hast" "also"
                    "nehme" "bis" "dann" "alles" "Alles" "Hast" "hast" "da" "machst" "machen"
                    "uns" "rein" "nach" "Nach" "Ich" "gut" "gut." "So" "so" "Du" "etwas" "etwas."
                    "weil" "Weil" ",weil" "weil," "ein" "eine" "eines" "einem" "einer"
                    "jeder" "Lasst" "uns" "raus" "raus," "verdammt!" "euch" "danke." "danke"
                    "Danke." "Danke" "Hey," "hey," "hey" "ok." "ok" "zu" "zur"
                     "warum" "Warum" "wir" "du?" "alle." "alle"
                    ))
  (mapcar #'strip-word stop-words))

(provide 'util-funcs)
