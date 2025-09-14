(setq dmenu-cfg " | dmenu -i -l 20 -p .")

(defun dmenu-ag ()
  (interactive)

  (setq my_shell_output (shell-command-to-string (concat "ag . " dmenu-cfg)))
  (setq splitted (split-string my_shell_output ":"))

  (when (> (length splitted) 1)
    (find-file (car splitted))
    (goto-line (string-to-number (nth 1 splitted)))))

(defun dmenu-ag-in-file ()
  (interactive)

  (setq my_command (concat "ag . " (prin1-to-string (buffer-file-name)) dmenu-cfg))
  ;; (message my_command)
  (setq my_shell_output (shell-command-to-string my_command))
  (setq splitted (split-string my_shell_output ":"))

  (when (> (length splitted) 1)
    (goto-line (string-to-number (car splitted)))))

(defun dmenu-find-file (&optional dir)
  (interactive)

  (setq command (concat "ls -a" dmenu-cfg))
  (setq output (shell-command-to-string command))

  (when (> (length output) 1)
    (find-file (substring output 0 -1))))

(defun dmenu-switch-buffer (&optional dir)
  (interactive)
  (setq command (concat (format "%s" (buffer-list)) dmenu-cfg))
  (setq splitted (split-string my_shell_output ":"))
  (print command))

(provide 'dmenu-helpers)
