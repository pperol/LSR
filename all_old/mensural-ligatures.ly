%% http://lsr.dsi.unimi.it/LSR/Item?id=118
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/typesetting-mensural-music


voice =  \transpose c c' {
  \cadenzaOn
  \set Score.defaultBarType = #"-"
  g\longa c\breve a\breve f\breve d'\longa^\fermata
  \bar "|"
  \[
  g\longa c\breve a\breve f\breve d'\longa^\fermata
  \]
  \bar "|"
  e1 f1 a\breve g\longa^\fermata
  \bar "|"
  \[
  e1 f1 a\breve g\longa^\fermata
  \]
  \bar "|"
  e1 f1 a\breve g\longa^\fermata
  \bar "||"
}

\score {
  \context ChoirStaff <<
    \new MensuralStaff <<
      \context MensuralVoice <<
        \voice
      >>
    >>
    \new Staff <<
      \context Voice <<
        \voice
      >>
    >>
  >>
}
