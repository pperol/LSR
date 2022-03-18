%% http://lsr.di.unimi.it/LSR/Item?id=252
%% see also http://www.lilypond.org/doc/v2.18/Documentation/extending/new-markup-command-definition


{
  f'1-\markup {
    foo
    \raise #0.2 \hbracket \bold bar

    \override #'(baseline-skip . 4)
    \bracket \column {
      baz
      bazr
      bla
    }
    \hspace #2.0
    \override #'(font-encoding . fetaMusic) {
      \lookup #"noteheads-0"
    }
    \semiflat
    { }
    \combine "X" "+"
    \combine "o" "/"
  }
  g'1-\markup {
    %% \char-number #"abc1234abc"
    \box \column {
      \line { "string 1" }
      \line { "string 2" }
     %% \concat { "f" "i" }
    }
    " "
    \draw-circle #1 #0.3 ##f
    " "
    \draw-circle #1 #0.3 ##t
    " "
    \italic Norsk
    \super "2"
    " "
    \raise #3.0 \whiteout white-out
    \circle \dynamic p
    \with-color #green Green
    \dynamic sfzp
    \huge { "A" \smaller "A" \smaller \smaller "A"
	    \smaller \smaller \smaller "A" }
    \sub "alike"
  }	
  c''4
}
