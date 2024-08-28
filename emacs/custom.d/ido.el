(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;(if (< emacs-major-version 25)
;;	(setq ido-separator "\n")
;;  (setf (nth 2 ido-decorations) "\n"))

(setq completion-ignored-extensions
	  (append completion-ignored-extensions
			  '(".zip" ".rar" ".xz" ".gz" ".bzip"
				".pdf" ".epub" ".gs" ".odt" ".doc" ".docx" ".rtf"
				".odb" ".db" ".ods" ".xls" ".xlsx"
				".odp" ".ppt" ".pptx"
				".odf" ".odg" ".kra"
				".djvu" ".tiff" ".bmp" ".gif" ".jpg" ".jpeg" ".png" ".webp")))

(setq ido-ignore-extensions t)

;; Do not ask for confirmation when trying to edit an unexistent buffer, just
;; do it!
(setq ido-create-new-buffer 'always)
(setq-default confirm-nonexistent-file-or-buffer nil)
