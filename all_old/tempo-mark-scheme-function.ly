%% http://lsr.di.unimi.it/LSR/Item?id=234
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms

tempoMark =
  #(define-music-function (parser location prependText notevalue appendText) (string? string? string?)
    #{
      \mark \markup
    { 	\line { $prependText " (" \fontsize #-2 \general-align #Y #DOWN \note #notevalue #1 $appendText ) } }
    #})

theMusic = {
  \once \override Score.RehearsalMark.self-alignment-X = #-1
  \time 4/4 \tempoMark "Fast" "4" "= 220-222" s1    
}

\score {
  \theMusic
}
