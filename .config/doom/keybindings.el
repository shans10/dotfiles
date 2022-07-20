;; LSP show diagnostics
(map! :leader
      :desc "Show lsp flycheck diagnostics"
      "l d" #'consult-lsp-diagnostics)

;; LSP show hover documentation
(map! :n "gr" #'lsp-find-references)

;; LSP show hover documentation
(map! :n "gh" #'lsp-ui-doc-glance)

;; Select all text in file
(map! :leader
      :desc "Select all"
      "f a" #'mark-whole-buffer)

;; Use jj to toggle back to normal mode from insert mode
(setq-default evil-escape-key-sequence "jj")
(setq-default evil-escape-delay 0.5)
