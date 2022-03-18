%% http://lsr.dsi.unimi.it/LSR/Item?id=544

\relative c'' {
  \override Staff.NoteColumn.ignore-collision = ##t
  \override NoteHead.style = #'harmonic-mixed
  <<
    {
      \oneVoice
      <a e'\harmonic>4
    }
    \\
    {
      \oneVoice
      \tiny
      \override Stem.stencil = ##f
      \override Flag.stencil = ##f
      \override ParenthesesItem.font-size = #0
      <\parenthesize e''>4
    }
  >>
}
