%% http://lsr.di.unimi.it/LSR/Item?id=558
%% http://lilypond.org/doc/v2.18/Documentation/notation/special-rhythmic-concerns

startAcciaccaturaMusic = {
  s1*0(
  \override Flag.stroke-style = #"grace"
  \slurDashed
}

stopAcciaccaturaMusic = {
  \revert Flag.stroke-style
  \slurSolid
  s1*0)
}

\relative c'' {
  \acciaccatura d8 c1
}
