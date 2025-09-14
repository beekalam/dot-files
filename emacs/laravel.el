;;; laravel.el --- Laravel helpers -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Mohammadreza Mansouri

;; Author: Mohammadreza Mansouri <beekalam@gmail.com>
;; Keywords: Laravel

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:
(require 'f)
(require 'cl-lib)
(require 'company)
;; todo write php artisan serve as process
;; todo @include autocomplete in blade files

;; (defun company-simple-backend (command &optional arg &rest ignored)
;;   (interactive (list 'interactive))
;;   (cl-case command
;;     (interactive (company-begin-backend 'company-simple-backend))
;;     (prefix (when (looking-back "foo\\>")
;;               (match-string 0)))
;;     (candidates (when (equal arg "foo")
;;                   (list "foobar" "foobaz" "foobarbaz")))
;;     (meta (format "This value is named %s" arg))))

(define-minor-mode laravel-mode
  "Laravel mode")


(defun laravel-goto-blade ()
  "Open blade file"
  (interactive)
  (let* ((view (s-replace-all '(("." . "/")) (laravel-str-at-point) ))
         (view (concat "resources/views/" view ".blade.php"))
         (view (concat (projectile-project-root) view)))
    (if  (file-exists-p view)
        (find-file view)
      (message "file does not exist"))))

(defun laravel-views()
  "return list of all available view files"
  (interactive)
  (let (viewsdir)
    (setq viewsdir (concat (projectile-project-root) "resources/views"))
    ;; (print
    (mapcar
     (lambda (f) (f-filename f))
     (f-files viewsdir
              (lambda (file)

                (equal (f-ext file) "php")) t)
     )
    ;; )
    ))

(defun laravel-str-at-point ()
  "read string in quotes"
  (interactive)
  (save-excursion
    (let ($skipchars $p1 $p2)
      (setq $skipchars "^'\"`")
      (skip-chars-backward $skipchars)
      (setq $p1 (point))
      (skip-chars-forward $skipchars)
      (setq $p2 (point))
      (buffer-substring-no-properties $p1 $p2)
      )))

(defun laravel-artisan-exists ()
  (file-exists-p (concat (lsp-workspace-root) "/" "artisan")))

(defun laravel-serve()
  (interactive)
  (unless (laravel-artisan-exists)
    (error "Could not find artisan"))

  (if (get-process "laravel-server")
      (progn (message "Probably already started")
             (browse-url "http://localhost:8000"))
    (progn (start-process "laravel-server"
                          "*laravel-server*"
                          "php"
                          (concat (lsp-workspace-root) "/" "artisan")
                          "serve")
           (browse-url "http://localhost:8000"))))

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

;; (add-hook 'php-mode-hook 'laravel-views)
;; (add-hook 'company-mode-hook 'laravel-views)
;; (add-hook 'web-mode-hook 'company-simple-backend)
;;;###autoload
;; (add-hook 'web-mode-hook 'laravel-mode)

;; (defconst laravel-completions
;;   '("foreach" "endforeach" "for" "while" "unless" "can" "endcan" ))

;; (defun laravel-company (command &optional arg &rest ignored)
;;   (interactive (list 'interactive))

;;   (cl-case command
;;     (interactive (company-begin-backend 'laravel-company))
;;     ;; (prefix (and (eq major-mode 'web-mode)
;;     ;;              (company-grab-symbol)))

;;     (prefix (and (eq major-mode 'php-mode)
;;                  (company-grab-symbol)))
;;     (candidates
;;      (cl-remove-if-not
;;       (lambda (c) (string-prefix-p arg c))
;;       laravel-completions))))

;; (add-to-list 'company-backends 'laravel-company)

(provide 'laravel)

;;; laravel.el ends here
