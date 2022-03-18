%% http://lsr.di.unimi.it/LSR/Item?id=638
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/writing-pitches.fr.html#note-names-in-other-languages

\include "deutsch.ly"

melody = {
  c8 d e f g a h c |
  ces8 des es fes ges as b ces |
  cis8 dis eis fis gis as his cis |
  \bar "|."
}

\include "english.ly"
\displayLilyMusic { \melody }
