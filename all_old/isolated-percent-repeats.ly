%% http://lsr.dsi.unimi.it/LSR/Item?id=499
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/short-repeats
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats

makePercent =
#(define-music-function (parser location note) (ly:music?)
   "Make a percent repeat the same length as NOTE."
   (make-music 'PercentEvent
               'length (ly:music-length note)))

\relative c'' {
  \makePercent s1
}
