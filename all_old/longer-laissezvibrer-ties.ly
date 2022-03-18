%% http://lsr.dsi.unimi.it/LSR/Item?id=715
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/laissezvibrertie

%LSR From Robin Bannister http://lists.gnu.org/archive/html/lilypond-user/2009-06/msg00302.html

extendLV =
#(define-music-function (parser location further) (number?)
#{
  \once \override LaissezVibrerTie.X-extent = #'(0 . 0)
  \once \override LaissezVibrerTie.details.note-head-gap = #(/ further -2)
  \once \override LaissezVibrerTie.extra-offset = #(cons (/ further 2) 0)
#})

\relative c' {
  \extendLV #2.5
  e8 \laissezVibrer r16 r8
}
