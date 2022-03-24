%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LSR workaround:
#(set! paper-alist (cons '("snippet" . (cons (* 190 mm) (* 90 mm))) paper-alist))
\paper {
  #(set-paper-size "snippet")
  tagline = ##f
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

voice =  \fixed c' {
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
       \voice
    >>
    \new Staff <<
      \context Voice <<
        \voice
      >>
    >>
  >>
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LSR workaround:
\markup\vspace #.5
