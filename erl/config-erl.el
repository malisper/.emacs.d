;;; Distel = Emacs erlang-mode++
;;; http://bc.tech.coop/blog/070528.html

;; This is needed for Erlang mode setup
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq load-path (cons "/usr/local/lib/erlang/lib/tools-2.6.6.5/emacs" load-path))
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))

;; (setq erlang-root-dir "/usr/lib/erlang")
;; (setq load-path (cons "/usr/lib/erlang/lib/tools-2.6.5/emacs" load-path))
;; (setq exec-path (cons "/usr/lib/erlang/bin" exec-path))

(require 'erlang-start)

;; This is needed for Distel setup
(let ((distel-dir "/home/nipra/.emacs.d/erl/distel/elisp"))
  (unless (member distel-dir load-path)
    ;; Add distel-dir to the end of load-path
    (setq load-path (append load-path (list distel-dir)))))

(require 'distel)
(distel-setup)

;; Some Erlang customizations
(add-hook 'erlang-mode-hook
          (lambda ()
            ;; when starting an Erlang shell in Emacs, default in the node name
            (setq inferior-erlang-machine-options
                  '("-sname" "emacs"
                    "-pa" "/home/nipra/.emacs.d/erl/distel/src"
                    "-pa" "/home/nipra/Erlang/source"))
            ;; add Erlang functions to an imenu menu
            ;; (imenu-add-to-menubar "imenu")
            ))

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete)	
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind) 
    ("\M-*"      erl-find-source-unwind))
  "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
          (lambda ()
            ;; add some Distel bindings to the Erlang shell
            (dolist (spec distel-shell-keys)
              (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

(provide 'config-erl)
