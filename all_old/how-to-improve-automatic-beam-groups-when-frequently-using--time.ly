%% http://lsr.dsi.unimi.it/LSR/Item?id=268
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/beams#setting-automatic-beam-behavior
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-beam-endings-in-score-context

% timenb sets TIMEesignature and measure length, but Not Beatlength
timenb = #(define-music-function (parser location x y ) (integer? integer?) #{
	  \set Staff.timeSignatureFraction = #(cons x y)
	  \set Score.measureLength = #(ly:make-moment x y)
#})

\new Staff {
  \relative c''
  {
    \set Score.baseMoment = #(ly:make-moment 1/8)
    \set subdivideBeams = ##t

    \timenb #3 #8 c16.[ c32 c16. c32 c16. c32] |
    \timenb #5 #8 d8[ d] d16.[ d32  d16. d32 d8] |
    \timenb #3 #4 e8[ e16. e32] e16.[ e32 e16. e32] e16.[ f32 f8] |
    \timenb #2 #4
    g16.[ g32 g16. g32] g16.[ g32 g16. g32] |
    
  }
}
