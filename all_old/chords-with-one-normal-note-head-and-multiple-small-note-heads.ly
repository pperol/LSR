%% http://lsr.di.unimi.it/LSR/Item?id=538


t =
#(define-music-function (parser location x) (ly:music?)
  (music-map (lambda (x)
              (if (eq? (ly:music-property x 'name) 'EventChord)
               (let ((copy (ly:music-deep-copy x)))
                (let ((elements (cdr (ly:music-property copy 'elements))))
                 (while (pair? elements)
                  (ly:music-set-property! (first elements) 'tweaks
                   (acons 'font-size -3 (ly:music-property (car elements)
                                         'tweaks)))
                  (set! elements (cdr elements))))
                copy) x))
   x))

\relative c' \t {
  <f a c>4 <a f c'> <c f, a> <c b f> |
  <c c'>4 <b b'> <a a'> g
}
