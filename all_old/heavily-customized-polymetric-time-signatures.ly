%% http://lsr.dsi.unimi.it/LSR/Item?id=192
%% modified by P.P.Schneider onn Fab. 2014.
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-heavily-customized-polymetric-time-signatures

melody = \relative c'' {
  \set Staff.instrumentName = #"Bb Sop."
  \key g \major
  \compoundMeter #'((3 8) (2 8) (2 8) (3 8) (2 8) (2 8)
                    (2 8) (2 8) (3 8) (2 8) (2 8))
  c8 c c d4 c8 c b c b a4 g fis8 e d c b' c d e4-^ fis8 g \break
  c,4. d4 c4 d4. c4 d c2 d4. e4-^ d4
  c4. d4 c4 d4. c4 d c2 d4. e4-^ d4 \break
  c4. d4 c4 d4. c4 d c2 d4. e4-^ d4
  c4. d4 c4 d4. c4 d c2 d4. e4-^ d4 \break
}

drum = \new DrumStaff \drummode {
  \bar ".|:" bd4.^\markup { Drums } sn4 bd \bar ";" sn4.
  bd4 sn \bar ";" bd sn bd4. sn4 bd \bar ":|."
}

{
  \melody
  \drum
}

