%% http://lsr.di.unimi.it/LSR/Item?id=662
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines#glissando


%LSR This snippet was contributed by Martial from the French community.

%% \guide #'(0 . shift) #'Ypoint2 note\startTextSpan note\stopTextSpan
guide = #(define-music-function (parser location shift pad) (pair? number?) #{
 	\once \override TextSpanner.dash-period = #1.5
    \once \override TextSpanner.bound-details.left.padding = #'1
    \once \override TextSpanner.bound-details.right.padding = #1
    \once \override TextSpanner.extra-offset = #shift 
    \override TextSpanner.bound-details.right.Y = #pad
    \once \override TextSpanner.bound-details.right.text = #'()
#})

%% \gliss #'(0 . shift) #'Ypoint2 note\startTextSpan note\stopTextSpan
gliss = #(define-music-function (parser location shift pad) (pair? number?) #{
 	\once \override TextSpanner.style = #'line
    \once \override TextSpanner.bound-details.left.padding = #'1
    \once \override TextSpanner.bound-details.right.padding = #1
    \once \override TextSpanner.extra-offset = #shift 
    \override TextSpanner.bound-details.right.Y = #pad
    \once \override TextSpanner.bound-details.right.text = #'()
#})
% Short command for start and stop  TextSpan
#(define Stsp startTextSpan )
#(define Stpsp stopTextSpan )

\new Staff {
  \guide #'(0.0 . -2.0)  #'1.0  <g''-1>2\startTextSpan e'' 
  <b''-1>\stopTextSpan \gliss #'(0.0 . -4) #'-0.8  b'4\Stsp g''8 a'\Stpsp 
}
