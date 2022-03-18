%% http://lsr.di.unimi.it/LSR/Item?id=642
%% see also http://lsr.di.unimi.it/LSR/Item?id=554
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-time-signature-in-parentheses-_002d-method-3

#(define-public (format-time-sig-note grob)
   (let* ((frac (ly:grob-property grob 'fraction))
          (num (if (pair? frac) (car frac) 4))
          (den (if (pair? frac) (cdr frac) 4))
          (m (markup #:override '(baseline-skip . 0.5)
                     #:center-column (#:number (number->string num)
                                               #:override '(style . default)
                                               #:note (number->string den) DOWN))))
     (grob-interpret-markup grob m)))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some sample music
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\relative c' {
  \override Staff.TimeSignature.stencil = #format-time-sig-note
  \time 2/4
  \repeat unfold 4 c4

  \time 3/8
  \repeat unfold 3 c8

  \time 3/16
  \repeat unfold 3 c16

  \time 3/1
  \repeat unfold 3 c1

  \time 5/2
  \repeat unfold 5 c2

  \bar"|."
}
