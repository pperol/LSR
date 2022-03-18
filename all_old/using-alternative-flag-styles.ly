%% http://lsr.di.unimi.it/LSR/Item?id=678
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides#tweaks-and-overrides-using-alternative-flag-styles
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/modifying-stencils.fr.html

testnotes = {
  \autoBeamOff
  c8 d16 c32 d64 \acciaccatura { c8 } d64 r4
}

\relative c' {
  \time 2/4
  \testnotes

  \override Flag.stencil = #modern-straight-flag
  \testnotes

  \override Flag.stencil = #old-straight-flag
  \testnotes

  \revert Flag.stencil
  \testnotes
}
