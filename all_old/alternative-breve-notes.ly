%% http://lsr.di.unimi.it/LSR/Item?id=798
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks#expressive-marks-alternative-breve-notes

\relative c'' {
  \time 4/2
  c\breve | 
  \override Staff.NoteHead.style = #'altdefault
  b\breve
  \override Staff.NoteHead.style = #'baroque
  b\breve
  \revert Staff.NoteHead.style
  a\breve
}
