;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "Cascadia Code" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;; MY SETTINGS ;;;
;; Disable quit prompt
(setq confirm-kill-emacs nil)

;;; Extra Font Configuration ;;;
(after! doom-themes
        (setq doom-themes-enable-bold t
              doom-themes-enable-italic t))
(custom-set-faces!
  ;; '(font-lock-comment-face :slant italic)
  ;; '(font-lock-keyword-face :slant italic)
  '(line-number-current-line :weight bold))

;;; Emacs Window Size Settings ;;;
;; Open emacs maximized
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

;;; Vim Related Settings ;;;
;; Vim like undo
(setq evil-want-fine-undo 'fine)
;; (setq evil-want-fine-undo t)

;; Vim whichwrap
(setq evil-cross-lines t)

;; Vim scrolloff alternative
;; (setq scroll-step 1)
;; (setq scroll-margin 9)

;; Add space from both sides inside braces
(defun my/c-mode-insert-space (arg)
  (interactive "*P")
  (let ((prev (char-before))
        (next (char-after)))
    (self-insert-command (prefix-numeric-value arg))
    (if (and prev next
             (string-match-p "[[({]" (string prev))
             (string-match-p "[])}]" (string next)))
      (save-excursion (self-insert-command 1)))))

(defun my/c-mode-delete-space (arg &optional killp)
  (interactive "*p\nP")
  (let ((prev (char-before))
        (next (char-after))
        (pprev (char-before (- (point) 1))))
    (if (and prev next pprev
             (char-equal prev ?\s) (char-equal next ?\s)
             (string-match "[[({]" (string pprev)))
      (delete-char 1))
    (backward-delete-char-untabify arg killp)))

(add-hook 'c-mode-common-hook
          (lambda ()
            (local-set-key " " 'my/c-mode-insert-space)
            (local-set-key "\177" 'my/c-mode-delete-space)))

;;; Evil Snipe ;;;
(setq evil-snipe-scope 'visible)
(setq evil-snipe-repeat-scope 'whole-visible)
(setq evil-snipe-spillover-scope 'whole-buffer)

;;; Flycheck ;;;
;; Check syntax on idle
(after! flycheck
        (setq flycheck-check-syntax-automatically '(idle-change)))

;; Disable default fringe styling
(setq +vc-gutter-default-style nil)

;; Move flycheck to left margin
(setq-default flycheck-indication-mode 'left-fringe)

;;; Lsp ;;;
;; Disable doc hover information unless key pressed
(setq lsp-ui-doc-enable nil)

;; Disable code action hints in sideline
(setq lsp-ui-sideline-show-code-actions nil)

;;; Neotree ;;;
;; Icons fix
(after! doom-themes
        (remove-hook 'doom-load-theme-hook #'doom-themes-neotree-config))

;;; Doom Modeline ;;;
;; Show major mode icon in doom modeline(filetype icon)
(setq doom-modeline-major-mode-icon t)

;; Disable code actions in doom modeline
(setq lsp-modeline-code-actions-enable nil)

;; Emacsclient which-key overlap fix
(setq which-key-allow-imprecise-window-fit nil)

;;; Centaur Tabs ;;;
;; Tab style
(setq centaur-tabs-style "rounded")

;; Selection marker style
(setq centaur-tabs-set-bar 'under)
(setq x-underline-at-descent-line t)

;; Button styles
(setq centaur-tabs-close-button "")

;;; Whitespace Mode ;;;
;; Enable globally
(global-whitespace-mode +1)

;; Set style
;; (setq whitespace-style '(face spaces tabs space-mark tab-mark))
(setq whitespace-style '(face trailing))

;;; Indent Guides ;;;
;; Display different color for current context
(setq highlight-indent-guides-responsive 'top)

;;; Custom Functions ;;;
;; Open specified terminal in current working directory
(defun term-here ()
  (interactive)
  (start-process "" nil "alacritty"))

;;; Load Custom Keybindings ;;;
(load! "keybindings")
