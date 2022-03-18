%% http://lsr.dsi.unimi.it/LSR/Item?id=91
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/bars#bar-numbers

resetBarnum = \context Score \applyContext #(set-bar-number-visibility 4)

\score {
    <<
         \transpose c c'' {
	    \override Score.BarNumber.break-visibility =#end-of-line-invisible
	    \override Score.RehearsalMark.padding = #2.5
	    \mark "A" \resetBarnum
	    \repeat unfold 10 c1
	    \mark \default \resetBarnum
	    \repeat unfold 8 c
            \bar "|."
        }
    >>
  \layout { ragged-right = ##t }
}

