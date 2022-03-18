%% Combining a time signature glyph
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks#expressive-marks-combining-dynamics-with-markup-texts


piuF = \markup { \italic più \dynamic f }

\layout { ragged-right = ##f }

\relative c'' {
  c2\f c-\piuF
}
