%% http://lsr.di.unimi.it/LSR/Item?id=743
%% see also http://lsr.di.unimi.it/LSR/Item?id=835
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-compound-time-signatures

\relative c' {
  \compoundMeter #'(1 2 3 4 8)
  \repeat unfold 10 c8 \repeat unfold 20 c16\break

  \time 3/4
  \repeat unfold 6 c8 \repeat unfold 12 c16\break

  \compoundMeter #'((1 2 3 4 8) (2 4))
  \repeat unfold 14 c8 \repeat unfold 28 c16\break

  \compoundMeter #'((1 2 3 4 8) (2 4) (2 3 8))
  \repeat unfold 19 c8 \repeat unfold 38 c16\break

  \compoundMeter #'(1 2 3 4 8)
  \repeat unfold 10 c8 \repeat unfold 20 c16\break

  \compoundMeter #'((1 8) (3 8))
  \repeat unfold 4 c8 \repeat unfold 8 c16\break

  \compoundMeter #'((3 8) (1 8))
  \repeat unfold 4 c8 \repeat unfold 8 c16\break

  \time 4/4
  \repeat unfold 8 c8 \repeat unfold 16 c16\break

  \bar"|."
}

%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Formatting of (possibly complex) compound time signatures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (insert-markups l m)
  (let* ((ll (reverse l)))
    (let join-markups ((markups (list (car ll)))
                       (remaining (cdr ll)))
      (if (pair? remaining)
        (join-markups (cons (car remaining) (cons m markups)) (cdr remaining))
        markups))))

% Use a centered-column inside a left-column, because the centered column
% moves its reference point to the center, which the left-column undoes.
#(define (format-time-fraction time-sig-fraction)
  (let* ((revargs (reverse (map number->string time-sig-fraction)))
         (den (car revargs))
         (nums (reverse (cdr revargs))))
    (make-override-markup '(baseline-skip . 0)
      (make-number-markup 
        (make-left-column-markup (list
          (make-center-column-markup (list
            (make-line-markup (insert-markups nums "+"))
            den))))))))

#(define (format-complex-compound-time time-sig)
  (let* ((sigs (map format-time-fraction time-sig)))
    (make-override-markup '(baseline-skip . 0)
      (make-number-markup
        (make-line-markup
          (insert-markups sigs (make-vcenter-markup "+")))))))

#(define-public (format-compound-time time-sig)
  (cond
    ((not (pair? time-sig)) (null-markup))
    ((pair? (car time-sig)) (format-complex-compound-time time-sig))
    (else (format-time-fraction time-sig))))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Measure length calculation of (possibly complex) compound time signatures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (calculate-time-fraction time-sig-fraction)
  (let* ((revargs (reverse time-sig-fraction))
         (den (car revargs))
         (num (apply + (cdr revargs))))
    (ly:make-moment num den)))

#(define (calculate-complex-compound-time time-sig)
  (let* ((sigs (map calculate-time-fraction time-sig)))
    (let add-moment ((moment ZERO-MOMENT)
                     (remaining sigs))
      (if (pair? remaining)
        (add-moment (ly:moment-add moment (car remaining)) (cdr remaining))
        moment))))

#(define-public (calculate-compound-measure-length time-sig)
  (cond
    ((not (pair? time-sig)) (ly:make-moment 4/4))
    ((pair? (car time-sig)) (calculate-complex-compound-time time-sig))
    (else (calculate-time-fraction time-sig))))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Base beat lenth: Use the smallest denominator from all fraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (calculate-compound-base-beat-full time-sig)
    (apply max (map last time-sig)))

#(define-public (calculate-compound-base-beat time-sig)
  (ly:make-moment 1 (cond
    ((not (pair? time-sig)) 4)
    ((pair? (car time-sig)) (calculate-compound-base-beat-full time-sig))
    (else (calculate-compound-base-beat-full (list time-sig))))))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beat Grouping
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



#(define (normalize-fraction frac beat)
  (let* ((thisbeat (car (reverse frac)))
         (factor (/ beat thisbeat)))
    (map (lambda (f) (* factor f)) frac)))

#(define (beat-grouping-internal time-sig)
  ; Normalize to given beat, extract the beats and join them to one list
  (let* ((beat (calculate-compound-base-beat-full time-sig))
         (normalized (map (lambda (f) (normalize-fraction f beat)) time-sig))
         (beats (map (lambda (f) (reverse (cdr (reverse f)))) normalized)))
    (apply append beats)))

#(define-public (calculate-compound-beat-grouping time-sig)
  (cond
    ((not (pair? time-sig)) '(2 . 2))
    ((pair? (car time-sig)) (beat-grouping-internal time-sig))
    (else (beat-grouping-internal (list time-sig)))))





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The music function to set the complex time signature
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

compoundMeter =
#(define-music-function (parser location args) (pair?)
"Create compound time signatures. The argument is a Scheme list of "
"lists. Each list describes one fraction, with the last entry being the "
"denominator, while the first entries describe the summands in the "
"enumerator. If the time signature consists of just one fraction, "
"the list can be given directly, i.e. not as a list containing a single list."
"For example, a time signature of (3+1)/8 + 2/4 would be created as "
"@code{\\compoundMeter #'((3 1 8) (2 4))}, and a time signature of (3+2)/8 "
"as @code{\\compoundMeter #'((3 2 8))} or shorter "
"@code{\\compoundMeter #'(3 2 8)}."
  (let* ((mlen (calculate-compound-measure-length args))
         (beat (calculate-compound-base-beat args))
         (beatGrouping (calculate-compound-beat-grouping args))
         (timesig (cons (ly:moment-main-numerator mlen)
                        (ly:moment-main-denominator mlen))))
  #{
    \once \override Staff.TimeSignature.stencil = #ly:text-interface::print
    \once \override Staff.TimeSignature.text = #(format-compound-time args)
    \set Timing.timeSignatureFraction = $timesig
    \set Timing.baseMoment = $beat
    \set Timing.beatStructure = $beatGrouping
    \set Timing.beamExceptions = #'()
    \set Timing.measureLength = $mlen
  #} ))

%}