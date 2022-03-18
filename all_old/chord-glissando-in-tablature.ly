%% http://lsr.di.unimi.it/LSR/Item?id=803
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-fretted-strings.html
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings#fretted-strings-slides-in-tablature

%LSR modified by P.P.Schneider on Feb.2014
%=> http://lilypond.1069038.n5.nabble.com/LSR-chord-glissando-in-tablature-obsolete-tc159863.html

myMusic = \relative c' {
  <c e g>1 \glissando <f a c>
}

\score {
  <<
    \new Staff {
      \clef "treble_8"
      \myMusic
    }
    \new TabStaff \with { \override Glissando.style = #'none } {
      \myMusic
    }
  >>
}
