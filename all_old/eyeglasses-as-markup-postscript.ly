%% http://lsr.dsi.unimi.it/LSR/Item?id=435
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic

% The postscript code to produce eyeglasses:
eyeglassesps = #"0.15 setlinewidth
-0.9 0 translate
1.1 1.1 scale
1.2 0.7 moveto
0.7 0.7 0.5 0 361 arc
stroke
2.20 0.70 0.50 0 361 arc
stroke
1.45 0.85 0.30 0 180 arc
stroke
0.20 0.70 moveto
0.80 2.00 lineto
0.92 2.26 1.30 2.40 1.15 1.70 curveto
stroke
2.70 0.70 moveto
3.30 2.00 lineto
3.42 2.26 3.80 2.40 3.65 1.70 curveto
stroke"

eyeglasses =  \markup { 
  \with-dimensions #'(0 . 4.4) #'(0 . 2.5) 
  \postscript #eyeglassesps 
}

\relative c'' { c2^\eyeglasses  a2_\eyeglasses }
