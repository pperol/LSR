%% http://lsr.di.unimi.it/LSR/Item?id=566

%% http://lsr.dsi.unimi.it/LSR/Search?q=Flams%2C+drags+and+ruffs
%% rewrote by Harm : http://lilypond.1069038.n5.nabble.com/flam-snippet-not-working-td149310.html

#(define (grace-from-main-note chord? lngth music)
  (let* ((mus (if (music-is-of-type? music 'event-chord)
                  (first (ly:music-property music 'elements))
                  music))
         (note (map-some-music
                  (lambda (m)
                    (and (ly:duration? (ly:music-property m 'duration))
                         (begin
                           (set! (ly:music-property m 'duration)
                                 (ly:make-duration (if (> lngth 1) 4 3) 0 1 1))
                           m)))
                  (ly:music-deep-copy (if chord? music mus))))
         (next-note (ly:music-deep-copy note))
         (last-note (ly:music-deep-copy note))
         (m-list
           (flatten-list
             (list note
                   (make-list (max 0 (- lngth 2)) next-note)
                   last-note))))

  (cond ((= lngth 1 )
           note)
        ((> lngth 1)
           (list-set!  m-list 0
             (begin
                (ly:music-set-property!
                    note
                    'articulations
                    (list (make-music
                           'BeamEvent
                           'span-direction -1)))
                 note))
           (list-set!  m-list (- lngth 1)
             (begin
                (ly:music-set-property!
                    last-note
                    'articulations
                    (list (make-music
                           'BeamEvent
                           'span-direction 1)))
                last-note))
            (make-music 'SequentialMusic 'elements m-list)))))


flam =
#(define-music-function (parser location note) (ly:music?)
  "Return { \\slashedGrace { note8 } note }.
  If @var{note} is a chord the first written note of it is used.
  "
  #{
    \slashedGrace {  $(grace-from-main-note #f 1 note) }
    $note
  #})

drag =
#(define-music-function (parser location note) (ly:music?)
  "Return { \\slashedGrace { note16[  note16] } note }.
  If @var{note} is a chord the first written note of it is used."
  #{
    \slashedGrace {  $(grace-from-main-note #f 2 note) }
    $note
  #})

ruff =
#(define-music-function (parser location note) (ly:music?)
  "Return { \\slashedGrace { note16[ note16 note16] } note }.
  If @var{note} is a chord the first written note of it is used."
  #{
    \slashedGrace {  $(grace-from-main-note #f 3 note) }
    $note
  #})

grace-repeat =
#(define-music-function (parser location chord-repeat? how-much note)
  ((boolean? #f) integer? ly:music?)
  "Return @var{note} preceded by repeated and beamed grace-notes. The number of
  grace-notes is specified by @var{how-much}.
  If @var{note} is a chord the first written note of it is used.
  If @var{chord-repeat?} is specified the whole chord is repeated during
  @code{GraceMusic}"
  #{
    \slashedGrace {  $(grace-from-main-note chord-repeat? how-much note) }
    $note
  #})


\new DrumStaff {
  \new DrumVoice \drummode {
    r4 \flam sn4 \drag cymr4 \ruff bd4
    \flam <sn bd>2 \flam <bd sn>2
    \grace-repeat ##t #4 <bd sn>1
  }
}

\new Staff
\relative c' {
    \flam c \drag d \ruff e \grace-repeat #4 f
    \flam <c f>
    \drag <f c>
    \ruff <c f>
    \grace-repeat  #4 <f c>
    \grace-repeat  #5 <c f>
    \grace-repeat ##t #6 <f c>
} 