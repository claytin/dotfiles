;; (I)nteractive DO

;; Enable ido as defautl
(require 'ido)
(ido-mode t)

;; Basic options
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Extensions to igone when matching -------------------------------------------
(setq completion-ignored-extensions
	  (append completion-ignored-extensions
			  '(".zip" ".rar" ".xz" ".gz" ".bzip"
				".pdf" ".epub" ".gs" ".odt" ".doc" ".docx" ".rtf"
				".odb" ".db" ".ods" ".xls" ".xlsx"
				".odp" ".ppt" ".pptx"
				".odf" ".odg" ".kra"
				".djvu" ".tiff" ".bmp" ".gif" ".jpg" ".jpeg" ".png" ".webp")))

(setq ido-ignore-extensions t)
;; Extension handling ends here ------------------------------------------------

;; Do not ask for confirmation when trying to edit an unexistent buffer.
;; Just do it!
(setq ido-create-new-buffer 'always)
(setq-default confirm-nonexistent-file-or-buffer nil)
