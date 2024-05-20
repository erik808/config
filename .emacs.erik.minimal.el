;;==================== Notes ================================================
;; byte recompiling elpa:
;; (byte-recompile-directory (expand-file-name "~/.emacs.d/") 0 t)
;;===========================================================================

;;=============== Paths ===============================================
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'custom-theme-load-path "~/config")

;;=============== Some modes ===============================================
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(savehist-mode 1)
(show-paren-mode 1)
(which-func-mode 1)
(global-linum-mode -1)
(column-number-mode 1)
(global-auto-revert-mode t)

(define-key global-map (kbd "RET") 'newline-and-indent)

(setq-default c-default-style "linux"
              tab-width 4
              c-basic-offset 4
              indent-tabs-mode nil)

;;======================== Package manager =====================================
(require 'package)
;; TLS fix for emacs < 26.3
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
;; (package-initialize)

;;==== Tramp en path ======================================
;; DIT IS SUPERRHANDIG
(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
;;=========================================================

;;=============== Smooth scrolling =====================================
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 2) ;; keyboard scroll one line at a time

;;========== multiple cursors =============================
(require 'multiple-cursors)
(global-set-key (kbd "C-M-d") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M-s") 'mc/mark-previous-like-this)

;;========== switch between header and implementation =====
(global-set-key (kbd "C-c f") 'ff-find-other-file)

;;===================== helm ================================
(require 'helm-config)
(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-X") 'execute-extended-command)
(global-set-key (kbd "C-x f") 'helm-for-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(setq helm-display-header-line nil)
(set-face-attribute 'helm-source-header nil :height .8)
(helm-autoresize-mode 1)
(setq helm-autoresize-max-height 24)
(setq helm-autoresize-min-height 24)

;;============== move text ======================================
(require 'move-text)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

;;================ height of status bar   =======================
(set-face-attribute 'mode-line nil :height 90)

;;==================== Dired customizations = ======================
(setq dired-listing-switches "-alh")
(add-hook 'dired-mode-hook 'toggle-truncate-lines)

;;================== Column fill width ======================================
(setq fill-column 100)

;;====== Unfill paragraph ===========================================
;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

;; Handy key definition
(define-key global-map "\M-Q" 'unfill-paragraph)

;;================ fortran-tags =======================================
(require 'fortran-tags)

;;================ octave/matlab syntax highlighting =================
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))


;;=============================================================================
(defun mkm/ediff-marked-pair ()
  "Run ediff-files on a pair of files marked in dired buffer"
  (interactive)
  (let* ((marked-files (dired-get-marked-files nil nil))
         (other-win (get-window-with-predicate
                     (lambda (window)
                       (with-current-buffer (window-buffer window)
                         (and (not (eq window (selected-window)))
                              (eq major-mode 'dired-mode))))))
         (other-marked-files (and other-win
                                  (with-current-buffer (window-buffer other-win)
                                    (dired-get-marked-files nil)))))
    (cond ((= (length marked-files) 2)
           (ediff-files (nth 0 marked-files)
                        (nth 1 marked-files)))
          ((and (= (length marked-files) 1)
                (= (length other-marked-files) 1))
           (ediff-files (nth 0 marked-files)
                        (nth 0 other-marked-files)))
          (t (error "mark exactly 2 files, at least 1 locally")))))
