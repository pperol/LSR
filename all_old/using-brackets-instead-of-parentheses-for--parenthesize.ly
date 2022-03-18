%% http://lsr.di.unimi.it/LSR/Item?id=564
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks#expressive-marks-adding-parentheses-around-an-expressive-mark-or-chordal-note

#(define-public (bracket-stencils grob)
  (let ((lp (grob-interpret-markup grob (markup #:fontsize 3.5 #:translate (cons -0.3 -0.5) "[")))
        (rp (grob-interpret-markup grob (markup #:fontsize 3.5 #:translate (cons -0.3 -0.5) "]"))))
    (list lp rp)))

bracketify = #(define-music-function (parser loc arg) (ly:music?)
   (_i "Tag @var{arg} to be parenthesized.")
#{
  \once \override ParenthesesItem.stencils = #bracket-stencils
  \parenthesize $arg
#})

\relative c'' {
  \bracketify c4
  \bracketify g4
  %<e \bracketify g b> % This doesn't work!!!
  \bracketify <e g b>4
  \bracketify r4
}
