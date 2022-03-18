%% http://lsr.di.unimi.it/LSR/Item?id=670
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-positioning-grace-note-beams-at-the-height-of-normal-note-beams

\relative c {
  f8[ e]
  \grace { 
    f8[ e] 
    \override Stem.no-stem-extend = ##f
    f8[ e] 
    \revert Stem.no-stem-extend
  }
  f8[ e]
}
