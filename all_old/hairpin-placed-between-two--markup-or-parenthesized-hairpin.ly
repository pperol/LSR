%% http://lsr.dsi.unimi.it/LSR/Item?id=771
% this snippet is useful to put a hairpin between to markups i.e. parentheses or slash
% or any other text

% este fragmento sirve para poner un regulador de angulo entre dos markups, p.e.
% parentesis, corchetes, barras o cualquier otro texto

% leftText y rightText serán los textos a la izquierda y a la derecha respectivamente
% leftText and rightText will be the markup texts on each side of the hairpin

hairpinBetweenText =
#(define-music-function (parser location leftText rightText) (markup? markup?)	
   #{
     \once \override Hairpin.stencil =
     #(lambda (grob)
        (ly:stencil-combine-at-edge
         (ly:stencil-combine-at-edge
          (ly:stencil-aligned-to (grob-interpret-markup grob leftText) Y CENTER)
          X RIGHT
          (ly:stencil-aligned-to (ly:hairpin::print grob) Y CENTER)
          0)
         X RIGHT
         (ly:stencil-aligned-to (grob-interpret-markup grob rightText) Y CENTER)
         0.6))
   #})

%cambiando el contenido de los \markup cambiamos el objeto de texto (elemento 
%de marcado y aceptara cualquier cosa que se pueda incluir en estos.

%you can change de content of the \markup to show diferent texts
%or any other thing you can put in a \markup 

parenthesizedHairpin = \hairpinBetweenText \markup "(" \markup ")"

% the music
\score {
  \relative c' {
    \time 3/4    
    \parenthesizedHairpin 
    c16\< d e f g a b c d e f g a\!
  }
}



