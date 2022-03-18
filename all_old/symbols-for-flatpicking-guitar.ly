%% http://lsr.di.unimi.it/LSR/Item?id=879
%% see also http://lsr.di.unimi.it/LSR/Item?id=409
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings#fretted-strings-flamenco-notation

% by Federico Bruni

arrUp = _\markup \translate #'(-.2 . 0) \rotate #90 "➛"
arrDown = _\markup \translate #'(-.2 . 0) \rotate #-90 "➛"

music = \relative c {
  d8\arrDown[ g\arrDown b\arrUp] d,\arrDown[ g\arrDown b\arrUp] d,\arrDown g\arrUp |
  f8\arrDown[ b\3\arrDown  d\arrUp] f,\arrDown[ b\3\arrDown  d\arrUp] f,\arrDown b\3\arrUp |
  c8\arrUp[ g\arrUp e\arrDown] c'8\arrUp[ g\arrUp e\arrDown] c'8\arrUp g\arrDown |
  b8\arrUp[ g\arrUp d\arrDown] b'\arrUp[ g\arrUp d\arrDown] b'\arrUp g\arrUp |
}


\score {
  \new StaffGroup <<
    \new Staff <<
      \context Voice { \clef "G_8" \music }
    >>
    \new TabStaff  <<
      \context TabVoice { \clef "moderntab" \music }
    >>
  >>
  \layout {
    \context {
      \Score
      \override TextScript.padding = #3
    }
    \context {
      \Staff
      \override StringNumber.stencil = ##f
    }
  }
}
