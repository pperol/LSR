%% http://lsr.di.unimi.it/LSR/Item?id=664
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/long-repeats
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats

% these snippets will permit the to segno and coda at the end of the last bar, too
% Instead of the glyphs you may choose to remove the \musicglyph and simply use text

toSegno = {
  % the align part, to the right, and below staff
  \once \override Score.RehearsalMark.self-alignment-X = #RIGHT 
  \once \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
  \override Score.RehearsalMark.direction = #DOWN 
  %prefered size, is about 1/3 smaller than normal
  \once \override Score.RehearsalMark.font-size = #-2
  \mark \markup { { \lower #1 "D.S. al  " { \musicglyph #"scripts.segno"} } } 
}
toCoda = {
  % the align part
  \once \override Score.RehearsalMark.self-alignment-X = #RIGHT  
  \once \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
  \override Score.RehearsalMark.direction = #DOWN
  %prefered size
  \once \override Score.RehearsalMark.font-size = #-2
  \mark \markup { { \lower #1 "D.S. al  " { \musicglyph #"scripts.coda"} } } 
}

% An example score fragment (klezzzzmer) demonstrating the use of above.
% accidentals in german
voiceOne =  \relative c''  {  
  r2^ "Allegro" r8 \p e,8 a c |
  \repeat "volta" 2 {
    e4 \segno e dis e | c8 b a4( a8) e a c | e4 e dis e | 
    fis8 g e4(e8) e f gis | a4 e dis e | c8 b a4(a8) a b c |
  }
  \alternative {
    { d4. c8 \tuplet 3/2 {e d c} \tuplet 3/2 {c b a} | c2 r8 e, a c }
    { d4. f8 e d c b | a2 r8 a'8 gis a }
  }
  f4 r4 r8 a gis a | e4 r4 r8 b c d | e4 e e e | e8. d16 c8 d e a gis a |
  f4 r r8 a gis a | e4 r r8 b c d \toCoda | e4 e e e | e8. d16 c8 b a e a c \toSegno |
  e4 \coda e e e | e8. e16 fis8 gis8 a4 r |
}
\score {
  <<
    \new Staff = "one" {
      \voiceOne
    }
  >>  
  \layout { }
}
