%% http://lsr.di.unimi.it/LSR/Item?id=857

% contributed by harm6
% Code by David Nalesnik and Thomas Morley (v2.16.0)
% => http://lists.gnu.org/archive/html/lilypond-user/2011-10/msg00500.html
% => http://lists.gnu.org/archive/html/lilypond-user/2012-11/msg00567.html

#(define (text-spanner-start-stop mus)
    (let ((elts (ly:music-property mus 'elements)))
    (make-music 'SequentialMusic 'elements 
       (append  
          (list (make-music 'TextSpanEvent 'span-direction -1))
          (reverse (cdr (reverse elts)))
          (list (make-music 'TextSpanEvent 'span-direction 1))
          (list (last elts))))))

barre =
#(define-music-function (parser location strg music)(string? ly:music?)
   (let ((arg (string-append "B " strg)))
      #{
         \override TextSpanner.bound-details.left.text = $arg
         $(text-spanner-start-stop music)
      #}))
      
stringNumberSpanner =
#(define-music-function (parser location strg music)
   (string? ly:music?)
  #{
     \once \override Voice.TextSpanner.style = #'solid
     \once \override Voice.TextSpanner.font-size = #-5
     \once \override TextSpanner.bound-details.left.stencil-align-dir-y = #CENTER
     \once \override TextSpanner.bound-details.left.text = \markup { \circle \number $strg }
  
     $(text-spanner-start-stop music)
  #})


\relative c {
 \clef "treble_8"
 \textSpannerDown
 \stringNumberSpanner "5" { a8 b c d e f }
 \textSpannerUp
 \barre "V" { g a bes4 a g2 }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% with version 2.16.0 you could use:

#(define (text-spanner-start-stop mus)
     (begin
        (let* ((elts (ly:music-property mus 'elements)))
          (set! (ly:music-property (car elts) 'elements)
            (cons (make-music 'TextSpanEvent 'span-direction -1)
                  (ly:music-property (car elts) 'elements)))
          (set! (ly:music-property (car (reverse elts)) 'elements)
            (cons (make-music 'TextSpanEvent 'span-direction 1)
                  (ly:music-property (car (reverse elts)) 'elements)))
          (make-music 'SequentialMusic 'elements (list mus)))))
          
barre =
#(define-music-function (parser location strg music)
   (string? ly:music?)
   (let ((arg (string-append "B " strg)))
  #{
     \once \override TextSpanner.bound-details.left.stencil-align-dir-y = #CENTER
     \once \override TextSpanner.bound-details.left.text = $arg
  
     $(text-spanner-start-stop music)
  #}))

stringNumberSpanner =
#(define-music-function (parser location strg music)
   (string? ly:music?)
  #{
     \once \override Voice.TextSpanner.style = #'solid
     \once \override Voice.TextSpanner.font-size = #-5
     \once \override TextSpanner.bound-details.left.stencil-align-dir-y = #CENTER
     \once \override TextSpanner.bound-details.left.text = \markup { \circle \number $strg }
  
     $(text-spanner-start-stop music)
  #})

\relative c {
        \clef "treble_8"
        \textSpannerDown
        \stringNumberSpanner "5" { a8 b c d e f }
        \textSpannerUp
        \barre V { g a bes4 a g2 }
}
%}
