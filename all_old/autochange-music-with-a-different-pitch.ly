%% http://lsr.dsi.unimi.it/LSR/Item?id=724
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/keyboards


% by David Kastrup (Feb. 2014)

autochangeWithPitch =
#(define-music-function (parser location ref music) ((ly:pitch?) ly:music?)
  (let ((mus (make-autochange-music parser
              (if ref #{ \transpose $ref c' $music #} music))))
   (set! (ly:music-property mus 'element) music)
   mus))

\context PianoStaff <<
 \context Staff = "up" {
   \autochangeWithPitch a \new Voice << \relative c' {
       g4 c e d c r4 a g } >>
 }
 \context Staff = "down" {
   \clef bass
   s1*2
 }
>>
