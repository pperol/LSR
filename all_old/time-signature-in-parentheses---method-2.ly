%% http://lsr.di.unimi.it/LSR/Item?id=733
%% see also http://lsr.di.unimi.it/LSR/Item?id=169
%% see also http://lsr.di.unimi.it/LSR/Item?id=734
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-time-signature-in-parentheses-_002d-method-3

#(define ((parenthesize-time up down) grob)
   (grob-interpret-markup grob
     (markup #:override '(baseline-skip . 0) #:number
       (#:line (
           #:vcenter "("
           (#:column (up down))
           #:vcenter ")" )))))

\relative c'' {
   \override Staff.TimeSignature.stencil = #(parenthesize-time "2" "4")      
   \time 2/4
   a4 b8 c
}
