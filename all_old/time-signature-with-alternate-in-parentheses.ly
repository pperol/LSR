%% http://lsr.di.unimi.it/LSR/Item?id=782
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-time-signature-in-parentheses-_002d-method-3

#(define ((time-parenthesized-time up down upp downp) grob)
   (grob-interpret-markup grob
     (markup #:override '(baseline-skip . 0) #:number
       (#:line (
           (#:column (up down))
           #:vcenter "("
           (#:column (upp downp))
           #:vcenter ")" )))))

\relative c' {
   \override Staff.TimeSignature.stencil = #(time-parenthesized-time "3" "4" "6" "8")      
   \time 3/4
   b8 b8 gis8 gis4 gis8
}
