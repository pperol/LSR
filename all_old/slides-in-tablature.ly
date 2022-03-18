%% http://lsr.di.unimi.it/LSR/Item?id=826
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-fretted-strings
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings#fretted-strings-slides-in-tablature

%LSR modified by P.P.Schneider on Feb.2014

slides = {
  c'8\3(\glissando d'8\3)
  c'8\3\glissando d'8\3
  \hideNotes
  \grace { g16\glissando }
  \unHideNotes
  c'4\3
  \afterGrace d'4\3\glissando {
  \stemDown \hideNotes
  g16 }
  \unHideNotes
}

\score {
  <<
    \new Staff { \clef "treble_8" \slides }
    \new TabStaff { \slides }
  >>
  \layout {
    \context {
      \Score
      \override Glissando.minimum-length = #4
      \override Glissando.springs-and-rods =
                          #ly:spanner::set-spacing-rods
      \override Glissando.thickness = #2
      \omit StringNumber
      % or:
      %\override StringNumber.stencil = ##f
    }
  }
}
