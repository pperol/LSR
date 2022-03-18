%% http://lsr.di.unimi.it/LSR/Item?id=634
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings

upper= \relative c' {
  c4. g4 g  c
}

lower= \relative c {
  c4 e g, e'
}

\score {
  \new StaffGroup <<
    \new Staff = "guitar" <<
      \context Voice = "upper guitar" { \clef "G_8" \voiceOne \upper }
      \context Voice = "lower guitar" { \clef "G_8" \voiceTwo \lower }
    >>
    \new TabStaff = "tab" <<
      \context TabVoice = "upper tab" { \clef "moderntab" \voiceOne \upper }
      \context TabVoice = "lower tab" { \clef "moderntab" \voiceTwo \lower }
    >>
  >>
}
