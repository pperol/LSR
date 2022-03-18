%% http://lsr.dsi.unimi.it/LSR/Item?id=837
%% see also http://comments.gmane.org/gmane.comp.gnu.lilypond.general/63777

% by Edward Neeman

slideNotes = {
 \override NoteHead.stencil = #(ly:make-stencil
   (list 'draw-line 0.15 -0.5 -0.4 2 0.4)
   '(-0.1 . 0.1) '(0.1 . 1))
 \override Stem.stencil = ##f
 \override Flag.stencil = ##f
}

\new Staff \relative c' {
 \key e \minor
 \time 3/4
 \partial 4

 <<
   { 
     \voiceOne g'8. g16 g4
   }
   \new Voice {
     \voiceTwo <b, e>4
     \stemUp \once \override Slur.extra-offset = #'(0 . 1)
     \appoggiatura b8 \stemDown <c e>4
   }
   \new Voice = "slides" { \slideNotes <d fis>4 fis }
 >>
}
