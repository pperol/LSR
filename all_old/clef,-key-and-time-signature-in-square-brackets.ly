%% http://lsr.di.unimi.it/LSR/Item?id=647


\layout { ragged-right = ##t }

\relative c'' {
  % Use \once \override if you only want the object immediately following
  % to be in brackets.
  \override Staff.Clef.stencil = #(lambda (grob)
    (bracketify-stencil (ly:clef::print grob) Y 0.1 0.2 0.1))
  \override Staff.TimeSignature.stencil = #(lambda (grob)
    (bracketify-stencil (ly:time-signature::print grob) Y 0.1 0.2 0.1))
  \override Staff.KeySignature.stencil = #(lambda (grob)
    (bracketify-stencil (ly:key-signature-interface::print grob) Y 0.1 0.2 0.1))
  \time 2/4
  \key cis \minor
  a4 b8 cis \break
  \clef "bass"
  c,,2
}
