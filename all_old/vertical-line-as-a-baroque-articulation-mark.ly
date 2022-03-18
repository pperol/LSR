%% http://lsr.di.unimi.it/LSR/Item?id=620
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/ancient-notation#ancient-notation-vertical-line-as-a-baroque-articulation-mark

upline =
#(let ((m (make-articulation "stopped")))
   (set! (ly:music-property m 'tweaks)
         (acons 'font-size 3
                (acons 'stencil (lambda (grob)
                                  (grob-interpret-markup
                                   grob
                                   (make-draw-line-markup '(0 . 1))))
                       (ly:music-property m 'tweaks))))
   m)


\relative c' {
  a'4^\upline a( c d')_\upline
}
