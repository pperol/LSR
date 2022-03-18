%% http://lsr.di.unimi.it/LSR/Item?id=794
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/repeats

% contributed by harm6
% discussed: http://old.nabble.com/Tie-at-end-of-first-repeat-td33246568.html

 extendLV = #(define-music-function (parser location further) (number?) 
#{
   \once \override LaissezVibrerTie.X-extent = #'(0 . 0)
   \once \override LaissezVibrerTie.details.note-head-gap = #(/ further -2)
   \once \override LaissezVibrerTie.extra-offset = #(cons (/ further 2) 0)
#})

\relative c' {
  c1~
  \repeat volta 2 { c2 c2 }
  \alternative {
    { c2 \extendLV #3 c2 \laissezVibrer }
    { d2 d2 }
  }
  c2 c2 \bar "|."
}
 
%{
 % works with 2.12.3 and 2.14.2 :

extendLV = #(define-music-function (parser location further) (number?) 
#{
   \once \override LaissezVibrerTie  #'X-extent = #'(0 . 0)
   \once \override LaissezVibrerTie  #'details #'note-head-gap = #(/ $further -2)
   \once \override LaissezVibrerTie  #'extra-offset = #(cons (/ $further 2) 0)
#})

\relative c' {
  c1~
  \repeat volta 2 { c2 c2 }
  \alternative {
    { c2 \extendLV #1.5 c2 \laissezVibrer }
    { d2 d2 }
  }
  c2 c2 \bar "|."
}
 
% for higher versions use: 
%}
