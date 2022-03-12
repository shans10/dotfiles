;; Lsp show diagnostics
(map! :leader
      :desc "Show lsp flycheck diagnostics"
      "l d" #'lsp-ui-flycheck-list)

;; Show hover documentation
(map! :n "gh" #'lsp-ui-doc-glance)

;; Use jj to toggle back to normal mode from insert mode
(setq-default evil-escape-key-sequence "jj")
(setq-default evil-escape-delay 0.5)
