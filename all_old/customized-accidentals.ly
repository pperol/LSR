%% http://lsr.di.unimi.it/LSR/Item?id=378
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/accidental


upp =
#(define-music-function (parser location note)   (ly:music?)
 #{ \once \override Voice.Accidental.stencil =
          #ly:text-interface::print
        \once \override Voice.Accidental.text =
          \markup {\musicglyph #"accidentals.sharp"
       \postscript #"gsave 0.17 setlinewidth -1.4 0.5 moveto -1.4 2 lineto
       stroke grestore
       gsave 0.1 setlinewidth -1.7 1.4 moveto -1.4 2.18 lineto -1.1 1.4 lineto
       stroke grestore"}
        $note #})
        
        
dwn =
#(define-music-function (parser location note)   (ly:music?)
 #{ \once \override Voice.Accidental.stencil =
          #ly:text-interface::print
        \once \override Voice.Accidental.text =
          \markup {\musicglyph #"accidentals.flat"
       \postscript #"0.17 setlinewidth -2 0.5 moveto -0.6 1.8 lineto
       stroke "
       }
        $note #})
        
\relative c' {
       d \dwn bes d \upp gis
}




