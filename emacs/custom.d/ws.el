;; Define the whitespace style.
(setq-default whitespace-style
	      '(face
		empty
		newline
		indentation::space
		indentation::tab
		trailing
		space-after-tab
		space-mark
		tab-mark
		newline-mark))

(setq-default whitespace-display-mappings
	      '((space-mark 32 [183] [765] [56])              ; 183:·, 765:˽ 56:.
		(space-mark 160 [9085] [96])                  ; 9085: ⍽, 96:`
		(tab-mark 9 [8677 9] [187 9] [126 9])          ; 8677:⇥, 187:» , 94:~
		(newline-mark 10 [172 10] [182 10] [36 10]))) ; 172:¬, 182:¶, $
