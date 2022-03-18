%% http://lsr.di.unimi.it/LSR/Item?id=870

%by: ArnoldTheresius
%tested: \version "2.22.0"

%tested: \version "2.12.3
%tested: \version "2.22.0"
%tested: \version "2.22.0"
%tested: \version "2.22.0"


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START of my personal include file 'percenting.ly'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define-public (unfold-percent-repeats music)
  "This function replaces all 'percent repeats' with 'unfold repeats'. "
  (let*
   ((es (ly:music-property music 'elements))
    (e  (ly:music-property music 'element)))
   (if (memq 'repeated-music (ly:music-property music 'types))
    (let*
     ((props (ly:music-mutable-properties music))
      (old-name (ly:music-property music 'name))
      (flattened  (flatten-alist props)))
     (if (equal? old-name 'PercentRepeatedMusic)
      (set! music (apply make-music (cons 'UnfoldedRepeatedMusic flattened))))))
   (if (pair? es)
    (set! (ly:music-property music 'elements) (map unfold-percent-repeats es)))
   (if (ly:music? e)
    (set! (ly:music-property music 'element) (unfold-percent-repeats e)))
   music))

unfoldPercentRepeats =
#(define-music-function (music) (ly:music?)
 (unfold-percent-repeats music))

unfoldPercentRepeatsR = #(define-music-function (music) (ly:music?)
 #{ \unfoldPercentRepeats \removeWithTag #'% $music #} )

taggedPercentRepeat =
#(define-music-function
  (repcount melody initspacer)
  (integer? ly:music? ly:music?)
  (let*
   ((repred (- repcount 1))
    (used-version (ly:version))
    (neu #t))
   (if (< (car used-version) 2)
    (set! neu #f)
    (if (> (car used-version) 2)
     (set! neu #t)
     (if (> (cadr used-version) 12)
      (set! neu #t)
      (set! neu #f))))
   (if neu
    (if (> repred 1)
     (begin ;(display "\n -neu(new)-multiple-\n")
     #{
       << {
             $initspacer
             \tag #'% \repeat unfold $repred {
                \noBreak $(skip-of-length initspacer)
             }
          }
          {
             \set countPercentRepeats = ##t
             \repeat percent $repcount $melody
             \set countPercentRepeats = ##f
          }
       >>
     #}
     ) (begin ;(display "\n -neu(new)-once_only-\n")
     #{
       << {
             $initspacer
             \tag #'% {
                \noBreak $(skip-of-length initspacer)
             }
          }
          {
             \repeat percent $repcount $melody
          }
       >>
     #}
     )
    )
    (if (> repred 1)
     (begin ;(display "\n -alt(old)-multiple- compatibiliy mode for 2.12.3\n")
     #{
       << {
             $initspacer
             \tag #'% \repeat unfold $repred {
                \noBreak #(ly:export (skip-of-length $initspacer))
             }
          }
          {
             \set countPercentRepeats = ##t
             \repeat percent $repcount $melody
             \set countPercentRepeats = ##f
          }
       >>
     #}
     ) (begin ;(display "\n -alt(old)-once_only- compatibiliy mode for 2.12.3\n")
     #{
       << {
             $initspacer
             \tag #'% {
                \noBreak #(ly:export (skip-of-length $initspacer))
             }
          }
          {
             \repeat percent $repcount $melody
          }
       >>
     #}
     )))))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END of my personal include file 'percenting.ly'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\markup { \null \translate #'( 1 . -3 ) \null } % 2.14.2 LSR problem workaroud

First = {
  \partial 4 e'4\p
  \repeat volta 2 {
    f'1\<
    \repeat unfold 6 { g'1 a' g' f' }
    g'1 a'
    \taggedPercentRepeat #2 { f'1 } { s1\f\> }
    d'1 b
  }
  c'2.\pp
  \bar "|."
}

Second = {
  \partial 4 c'4\p
  \repeat volta 2 {
    \taggedPercentRepeat #27 { c'1 } { s1\< }
    c'1\f\>
    \taggedPercentRepeat #2 { g } { s1 }
    g2 f
  }
  e2.\pp
  \bar "|."
}

\score {
  \new Staff {
    \First
  }
  \header {
    piece = "Part #1"
  }
}

\score {
  \new Staff {
    \Second
  }
  \header {
    piece = "Part #2"
  }
}

\score {
  \new StaffGroup <<
    \new Staff {
      \unfoldPercentRepeatsR \First
    }
    \new Staff {
      \unfoldPercentRepeatsR \Second
    }
  >>
  \header {
    piece = "Score"
  }
}
