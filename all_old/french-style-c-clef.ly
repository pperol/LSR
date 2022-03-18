%% http://lsr.dsi.unimi.it/LSR/Item?id=612

%%%%% Valentin Villanave's macro for the French-style C clef %%%%%%%

altoClef = \markup \postscript #"
gsave newpath
   0.004 0.004 scale
   -180 0 translate
   248 -306 moveto
	 248 -492 lineto
	 248 -496 245 -500 240 -500 curveto
	 218 -500 lineto
	 213 -500 210 -496 210 -492 curveto
	 210 492 lineto
	 210 496 213 500 218 500 curveto
	 240 500 lineto
	 245 500 248 496 248 492 curveto
	 248 292 lineto
	 274 270 348 242 370 242 curveto
	 404 242 462 228 462 453 curveto
	 462 560 476 670 576 670 curveto
	 628 670 671 626 671 571 curveto
	 671 516 628 471 576 471 curveto
	 526 471 530 496 520 503 curveto
	 513 502 510 478 510 437 curveto
	 510 340 lineto
	 510 192 490 94 477 79 curveto
	 442 39 332 70 248 70 curveto
	 248 -83 lineto
	 332 -83 442 -53 477 -93 curveto
	 490 -108 510 -206 510 -354 curveto
	 510 -451 lineto
	 510 -491 513 -516 520 -517 curveto
	 530 -509 526 -485 576 -485 curveto
	 628 -485 671 -530 671 -584 curveto
	 671 -640 628 -684 576 -684 curveto
	 476 -684 462 -574 462 -467 curveto
	 462 -242 404 -256 370 -256 curveto
	 348 -256 274 -283 248 -306 curveto
	closepath
	130 -500 moveto
	 8 -500 lineto
	 4 -500 0 -496 0 -492 curveto
	 0 492 lineto
	 0 496 4 500 8 500 curveto
	 130 500 lineto
	 134 500 138 496 138 492 curveto
	 138 -492 lineto
	 138 -496 134 -500 130 -500 curveto
	closepath
fill grestore"

%%%%%%%%%%%%%%%%%%%%%%%%%%

\relative c' {
  \clef "alto"
  \numericTimeSignature
  \override Staff.Clef.stencil = #(lambda (grob)
    (grob-interpret-markup grob altoClef))
  c1
}
