%% http://lsr.dsi.unimi.it/LSR/Item?id=704
%% see also http://www.lilypond.org/doc/v2.17/Documentation/snippets/rhythms#rhythms-partcombine-and-autobeamoff

{
  %\set Staff.autoBeaming = ##f % turns off all autobeaming
  \partcombine
  {
    \autoBeamOff % applies to split up stems
    \repeat unfold 4 a'16
    %\autoBeamOff % applies to combined up stems
    \repeat unfold 4 a'8
    \repeat unfold 4 a'16
  }
  {
    \autoBeamOff % applies to down stems
    \repeat unfold 4 f'8
    \repeat unfold 8 f'16 |
  }
}
