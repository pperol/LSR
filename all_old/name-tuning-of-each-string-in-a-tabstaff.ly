%% http://lsr.dsi.unimi.it/LSR/Item?id=658
%% see also http://www.lilypondforum.de/index.php?topic=1522.msg8568#msg8568

%%------------------------------------------
%%postscript tuning name 
EADGBE =
\markup {
  \with-dimensions #'(0 . 0.8) #'(0 . 1.0) 
  \postscript #"/Arial-Bold findfont
                1.3 scalefont
                setfont 0 3.6 moveto
                (E) show 0 2.0 moveto
                (B) show 0 0.6 moveto
                (G) show 0 -0.8 moveto
                (D) show 0 -2.2 moveto
                (A) show 0 -3.6 moveto
                (E) show
                stroke"
}
%%------------------------------------------------
\new TabStaff {
  \set TabStaff.instrumentName = \markup { " " \EADGBE }
  \set TabStaff.shortInstrumentName = \markup \EADGBE
  e,8 c e gis b e'
}
%%------------------------------------------------
