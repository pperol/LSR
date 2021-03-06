%% http://lsr.di.unimi.it/LSR/Item?id=646
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% A function to position tuplet numbers next to kneed beams on a single
%% staff and between staves. Will ignore tuplets on ordinary beams and
%% with visible brackets.
%%
%% Usage: \override TupletNumber.Y-offset = #kneed-beam
%%
%% You must use manual beaming for this function to work properly.
%%
%% An additional function, called with a separate override (see below), will
%% horizontally center the tuplet number on the kneed beam.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (kneed-beam tuplet-number)
   (let* ((tuplet-bracket (ly:grob-object tuplet-number 'bracket))
          (first-note (ly:grob-parent tuplet-number X))
          (first-stem (ly:grob-object first-note 'stem))
          (beam (ly:grob-object first-stem 'beam)))

     (if (and (ly:grob? beam) ; beam on first note?
              (ly:grob-property beam 'knee) ; is it kneed?
              (interval-empty? (ly:grob-property tuplet-bracket 'Y-extent))) ; visible bracket?
         (let* ((stems (ly:grob-object beam 'stems))
                (closest-stem (nearest tuplet-number stems))
                (direction-first-stem (ly:grob-property first-stem 'direction))
                (direction-closest-stem (ly:grob-property closest-stem 'direction))
                (beaming-near-number (car (ly:grob-property closest-stem 'beaming)))
                (beam-multiplier
                 (if (= direction-closest-stem UP)
                     (length (filter positive? beaming-near-number))
                     (length (filter negative? beaming-near-number))))
                (beam-ends (ly:grob-property beam 'positions))
                (mid-beam-Y (/ (+ (car beam-ends) (cdr beam-ends)) 2)) ; mid-beam Y-coordinate
                (number-height (ly:grob::stencil-height tuplet-number))

                ;; inital value of Y-offset (will cause number to overlap beam slightly)
                (correction
                  (- mid-beam-Y
                    (if (= direction-closest-stem UP)
                        (car number-height)
                        (cdr number-height))))
                (beam-width (ly:grob-property beam 'beam-thickness))
                (beam-gap (* 0.5 (ly:grob-property beam 'gap)))
                (beam-padding 0.2)) ; change to move number closer or farther from beam

           ;; refinement of initial value of Y-offset
           (cond
             ((= direction-first-stem direction-closest-stem DOWN)
              (- correction
                (* 0.5 beam-width)
                beam-padding))

             ((= direction-first-stem direction-closest-stem UP)
              (+ correction
                (* 0.5 beam-width)
                beam-padding))

             ((and (= direction-first-stem DOWN) (= direction-closest-stem UP))
              (+ correction
                (* beam-multiplier (+ beam-gap beam-width))
                (* 0.5 beam-width)
                beam-padding))

             ((and (= direction-first-stem UP) (= direction-closest-stem DOWN))
              (- correction
                (* beam-multiplier (+ beam-gap beam-width))
                (* 0.5 beam-width)
                beam-padding)))))))

%% find the stem closest to the tuplet-number
#(define (nearest tuplet-number stems)
  (let* ((refp (ly:grob-system tuplet-number))
         (X-coord (interval-center (ly:grob-extent tuplet-number refp X)))
         (closest (ly:grob-array-ref stems 0)))
    (let lp ((x 1))
     (if (<= (abs (- X-coord
                    (ly:grob-relative-coordinate
                      (ly:grob-array-ref stems x) refp X)))
             (abs (- X-coord
                    (ly:grob-relative-coordinate closest refp X))))
         (set! closest (ly:grob-array-ref stems x)))
     (if (< x (1- (ly:grob-array-length stems)))
         (lp (1+ x))
         closest))))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% A function which horizontally centers a tuplet number on a kneed beam.  May
%% be used in conjunction with the earlier function.
%%
%% Usage: \override  TupletNumber.X-offset = #center-on-beam
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (center-on-beam tuplet-number)
  (let* ((tuplet-bracket (ly:grob-object tuplet-number 'bracket))
         (first-note (ly:grob-parent tuplet-number X))
         (first-stem (ly:grob-object first-note 'stem))
         (beam (ly:grob-object first-stem 'beam)))

    (if (and (ly:grob? beam)
             (ly:grob-property beam 'knee)
             (interval-empty? (ly:grob-property tuplet-bracket 'Y-extent)))
      (let* ((refp (ly:grob-system tuplet-number))
             (number-X (interval-center (ly:grob-extent tuplet-number refp X)))
             (beam-center-X (interval-center (ly:grob-extent beam refp X))))

        (- beam-center-X number-X)))))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXAMPLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
top = \change Staff = "1"
bottom = \change Staff = "2"

music = \relative c {
  \override Beam.auto-knee-gap = #1
  \tupletSpan 4
  \tuplet 3/2 {
    \bottom c8[ g' \top e']
    c'[ e, \bottom g,]
    \top e''[ \bottom c,, \top g'']
  }
  \tuplet 5/4 {
    \bottom c,,16[ \top g'' e' \bottom g,, \top c']
  }
}

\score {
  \new PianoStaff <<
    \new Staff = "1" {
      s1^"Before:"
      s1^"After:"
    }
    \new Staff = "2" {
      \clef bass
      \music
      \bar "||"
      \override TupletNumber.Y-offset = #kneed-beam
      \override TupletNumber.X-offset = #center-on-beam
      \music
    }
  >>
}
