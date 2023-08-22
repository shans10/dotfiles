;; LSP
; LSP show diagnostics
(map! :leader
      (:prefix ("c" . "code")
      :desc "Show lsp diagnostics"
      "X" #'consult-lsp-diagnostics))
(map! :n "gr" #'lsp-find-references   ; LSP show hover documentation
      :n "gh" #'lsp-ui-doc-glance)    ; LSP show hover documentation

;; Select all text in file
(map! :leader
      :desc "Select all"
      "b a" #'mark-whole-buffer)

;; Kill current buffer without prompt
(map! :leader
      :desc "Kill this buffer"
      "b D" #'kill-this-buffer)

;; Neotree
(map! :leader
      :desc "Neotree" "t n" #'neotree-toggle)

;; Terminal
; Open external terminal in CWD
(map! :leader
      :desc "Open terminal here"
      "t ." #'term-here)
; Built in terminals
(map! :leader
      :desc "Eshell popup" "t e" #'+eshell/toggle
      :desc "Vterm popup" "t t" #'+vterm/toggle)

;; Zoom active window
(map! :leader
      (:desc "Zoom window"
       "w z" #'zoom-window-zoom))

;; Dired
; Evil mode
(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  (kbd "* %") 'dired-mark-files-regexp
  (kbd "* .") 'dired-mark-extension
  (kbd "* /") 'dired-mark-directories
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)

;; Centaur tabs
(map! :leader
      :desc "Centaur tabs global" "t c" #'centaur-tabs-mode
      :desc "Centaur tabs local" "t C" #'centaur-tabs-local-mode)
; Evil mode
(evil-define-key 'normal centaur-tabs-mode-map
  (kbd "g <right>") 'centaur-tabs-forward        ; default Doom binding is 'g t'
  (kbd "g <left>")  'centaur-tabs-backward       ; default Doom binding is 'g T'
  (kbd "g <down>")  'centaur-tabs-forward-group
  (kbd "g <up>")    'centaur-tabs-backward-group)

;; ibuffer evil mode
(evil-define-key 'normal ibuffer-mode-map
  (kbd "f c") 'ibuffer-filter-by-content
  (kbd "f d") 'ibuffer-filter-by-directory
  (kbd "f f") 'ibuffer-filter-by-filename
  (kbd "f m") 'ibuffer-filter-by-mode
  (kbd "f n") 'ibuffer-filter-by-name
  (kbd "f x") 'ibuffer-filter-disable
  (kbd "g h") 'ibuffer-do-kill-lines
  (kbd "g H") 'ibuffer-update)

;; Use jj to toggle back to normal mode from insert mode
(setq-default evil-escape-key-sequence "jj")
(setq-default evil-escape-delay 0.5)
