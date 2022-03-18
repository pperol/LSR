%%http://lsr.dsi.unimi.it/LSR/Item?id=868

%by: ArnoldTheresius

%incompatible: \version "2.12.3
%tested: \version "2.22.0"


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START of my personal include file 'fullbar-restnumber-purger.ly'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (Fullbar_restnumber_purger ctx)
  (let ((bar-line-found #f)
        (note-head-found #f)
        (collected-note-head-found #f)
        (multi-measure-count 0)
        (current-multi-measure-numbers '())
        (collected-multi-measure-numbers '()))

    `((acknowledgers
       (bar-line-interface
        . ,(lambda (trans grob source)
             (set! bar-line-found #t)))
       (multi-measure-interface
        . ,(lambda (trans grob source)
             (let ((grob-name (ly:assoc-get 'name (ly:grob-property grob 'meta))))
              (if (eq? grob-name 'MultiMeasureRestNumber) (begin
                (set! multi-measure-count (+ 1 multi-measure-count))
                (set! current-multi-measure-numbers
                 (cons grob current-multi-measure-numbers)))))))
       (note-head-interface
        . ,(lambda (trans grob source)
             (let
              ((head-size (ly:grob-property grob 'font-size))
               (minimum-head-size (ly:grob-property grob 'size-threshold-to-remove-mm-rest-rumber -2.5)))
              ; (for-each display (list "\n   Head: font-size = " head-size
              ;  " minimum-head-size = " minimum-head-size " "))
              (if (or (not (number? head-size))
                      (>= head-size minimum-head-size))
               (set! note-head-found #t))))))

      (stop-translation-timestep
       . ,(lambda (trans)
            (if bar-line-found (begin
              (if collected-note-head-found
               (for-each ly:grob-suicide! collected-multi-measure-numbers))
              (set! collected-multi-measure-numbers '())
              (set! collected-note-head-found #f)))
            (if (not (null? current-multi-measure-numbers)) (begin
              (set! collected-multi-measure-numbers
               (append current-multi-measure-numbers collected-multi-measure-numbers))
              (set! current-multi-measure-numbers '())
              (set! multi-measure-count 0)))
            (set! collected-note-head-found
             (or collected-note-head-found note-head-found))
            (set! note-head-found #f)
            (set! bar-line-found #f)
            (set! multi-measure-count 0))))))

% Use this un-engraver by default:
\layout {
  \context {
    \Score
    \consists #Fullbar_restnumber_purger
  }
}

#(define (define-grob-property symbol type? description)
  (if (not (equal? (object-property symbol 'backend-doc) #f))
      (ly:error (_ "symbol ~S redefined") symbol))

  (set-object-property! symbol 'backend-type? type?)
  (set-object-property! symbol 'backend-doc description)
  symbol)

#(for-each
  (lambda (x)
    (apply define-grob-property x))
    `((size-threshold-to-remove-mm-rest-rumber 
      ,number? 
      "The minimum size noteheads need to trigger the removal of multi measure rest numbers.")))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END of my personal include file 'fullbar-restnumber-purger.ly'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\markup { \null \translate #'( 1 . -3 ) \null } % 2.14.2 LSR problem workaroud

\score {
  \new StaffGroup <<
    \new Staff {
      \set Score.restNumberThreshold = #0
      % this way you can tune the size limit, when a notehead is treated as a cue note by this un-engraver:
      \override Score.NoteHead.size-threshold-to-remove-mm-rest-rumber = #-3.0
      \compressEmptyMeasures
      \time 4/4
      R1  c''1  R1*3                 d''1 ~ d''
      << { R1*4 } \new CueVoice { s4*15 a'16 b' c'' d'' } >>
      e''1
      \bar "|."
    }
    \new Staff {
      \set Score.restNumberThreshold = #0
      \compressEmptyMeasures
      \time 4/4
      R1  e'1   R1*2     r4 g'2 g'4  R1*6
      c''1
      \bar "|."
    }
    \new Staff {
      \clef bass
      \set Score.restNumberThreshold = #0
      \compressEmptyMeasures
      \time 4/4
      R1  c1    R1  g,1  R1*2               g1
      R1*4
      g1
      \bar "|."
    }
  >>
}


