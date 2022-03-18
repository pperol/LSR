%% http://lsr.dsi.unimi.it/LSR/Item?id=396
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-merging-multi_002dmeasure-rests-in-a-polyphonic-part

normalPos = \revert MultiMeasureRest.direction

{
  <<
    {
      c''1
      R1
      c''1
      \normalPos
      R1
    }
    \\
    {
      c'1
      R1
      c'1
      \normalPos
      R1
    }
  >>
}
