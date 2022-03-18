%% http://lsr.di.unimi.it/LSR/Item?id=116
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/vaticana_002dligature_002dinterface
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/typesetting-mensural-music

\include "gregorian.ly"

cantus = \context VaticanaVoice = "cantus"  {
  \clef "vaticana-fa2"
  \[ f\melisma \quilisma g \auctum \descendens a\melismaEnd \]
  \[ \virga a\melisma g \pes a \inclinatum f \inclinatum d
     c \pes d \quilisma e \pes f \virga g
     a \flexa f \pes g \inclinatum f \inclinatum e\melismaEnd \]
  \[ d\melisma \quilisma e f \flexa e \pes f\melismaEnd \]
  \[ e\melisma \flexa d\melismaEnd \]
}

verba = \context Lyrics = "verba" \lyricmode {
  Al- le- lu- ia.
}

\paper {
 %   linethickness = \staffspace / 7.0
}

\score {
  <<
    \cantus
    \lyricsto "cantus" \verba
  >>
  \layout {
    linewidth = 137.0 \mm
    width = 137.0 \mm
    indent = 0.0
    raggedright = ##t
    packed = ##t
    \context {
      \Score
      \remove Bar_number_engraver
      timing = ##f
      barAlways = ##t
    }
  }
}
