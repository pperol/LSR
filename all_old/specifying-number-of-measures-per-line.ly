%% http://lsr.di.unimi.it/LSR/Item?id=838

%LSR completed by P.P.Schneider on Feb. 2014 for v2.18

#(define ((bars-per-line-engraver bar-list) context)
  (let* ((working-copy bar-list)
         (total (1+ (car working-copy))))
    `((acknowledgers
       (paper-column-interface
        . ,(lambda (engraver grob source-engraver)
             (let ((internal-bar (ly:context-property context 'internalBarNumber)))
               (if (and (pair? working-copy)
                        (= (remainder internal-bar total) 0)
                        (eq? #t (ly:grob-property grob 'non-musical)))
                   (begin
                     (set! (ly:grob-property grob 'line-break-permission) 'force)
                     (if (null? (cdr working-copy))
                         (set! working-copy bar-list)
                         (begin
                           (set! working-copy (cdr working-copy))))
                           (set! total (+ total (car working-copy))))))))))))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXAMPLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

myMusic = \relative c' {
  \repeat unfold 4 {
    \time 5/4
    c4 c c c c
    \time 3/4
    c c c
    \time 3/2
    c2 c c
  }
}

\score {
  \new Staff { 
    \once\override Score.RehearsalMark.self-alignment-X = #LEFT
    \mark\markup\small\italic "4 measures per line:"
    \myMusic 
  }
  \layout {
    \context {
      \Score
      %use the line below to insist on your layout
      %\override NonMusicalPaperColumn.line-break-permission = ##f
      \consists #(bars-per-line-engraver '(4))
    }
  }
}
\score {
  \new Staff { 
    \once \override Score.RehearsalMark.self-alignment-X = #LEFT
    \mark\markup\small\italic "6 measures per line:"
    \myMusic 
  }
  \layout {
    \context {
      \Score
      %use the line below to insist on your layout
      %\override NonMusicalPaperColumn.line-break-permission = ##f
      \consists #(bars-per-line-engraver '(6))
    }
  }
}
