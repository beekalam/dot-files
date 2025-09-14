
(defun log-to-file (text)
  (f-append-text (concat text "\n") nil "/tmp/emacs.log"))

(defun log-to-syslog(str)
  (progn (shell-command (format "logger %s" str))))

(provide 'logging)
