%% http://lsr.di.unimi.it/LSR/Item?id=842
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines

\relative c' {
  c4 d e g\glissando
  
  \once\override NoteColumn.glissando-skip = ##t
  \once \override ParenthesesItem.font-size = #2
  
  \parenthesize r8 c'4. r2
  c,,4 d e g\glissando
  
  \once\override NoteColumn.glissando-skip = ##t
  \once \override NoteHead.transparent = ##t
  % If the stem doesn't align well with the glissando, it may need repositioning. e.g.:
  \once \override NoteHead.stem-attachment = #'(1 . 0)
  
  f'8 c'4. r2
}
