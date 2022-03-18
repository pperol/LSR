%% http://lsr.dsi.unimi.it/LSR/Item?id=215
%% see also : http://www.lilypond.org/doc/v2.18/Documentation/internals/glissando
%% see also : http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines#glissando
%% see also : http://www.lilypond.org/doc/v2.17/Documentation/snippets/expressive-marks

\layout{
  line-width = 50\mm
  indent = 0
}

\new Staff 
\relative c''{
  \override Glissando.breakable = ##t
  %% gliss non gliss and 
  c4 \glissando d e \glissando f \glissando 
  \break
  %% consecutive 
  c \glissando d, \glissando e'
  << 
    { \stemUp e8 \glissando g8 }
    \context Voice = VB 
    {\stemDown \repeat unfold 4 d16 } 
  >>
  \override Glissando.style = #'zigzag
  c4 \glissando c,, \glissando c' \glissando d
  \break
  \override Glissando.style = #'trill
  c4 \glissando c,, \glissando c' \glissando d
}
