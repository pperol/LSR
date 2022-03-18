%% http://lsr.dsi.unimi.it/LSR/Item?id=542


#(use-modules (srfi srfi-39))

#(define *current-moment* (make-parameter (ly:make-moment 0/1 0/1)))

#(define moment-null (ly:make-moment 0/1 0/1))

#(define (music-has-no-length? music)
  "Is music empty of notes, rests or skips?"
  (equal? (ly:music-length music) moment-null))

#(define (simultaneous? music)
  (memq (ly:music-property music 'name)
    (list 'SimultaneousMusic 'EventChord)))

#(define (defined-music? music)
  (not (eq? 'Music (ly:music-property music 'name))))

#(define (chord-event? music)
  (eq? 'EventChord (ly:music-property music 'name)))

#(define (get-duration music)
  (ly:music-property music 'duration))

#(define (moment>=? momentA momentB)
  (not (ly:moment<? momentA momentB)))

#(define (moment-inside? moment from-moment to-moment)
  (and
    (moment>=? moment from-moment)
    (ly:moment<? moment to-moment)))

#(define (whole-music-inside? begin-music end-music left-range right-range)
  (and
    (moment>=? begin-music left-range)
    (moment>=? right-range end-music )
    (not (equal? begin-music right-range))))

#(define (whole-music-outside? begin-music end-music left-range right-range)
  (or
    (moment>=? left-range end-music)
    (moment>=? begin-music right-range)))

#(define (moment->duration moment)
  ;see duration.cc in Lilypond sources (Duration::Duration)
  (let* ((p (ly:moment-main-numerator moment))
         (q (ly:moment-main-denominator moment))
         (k (- (ly:intlog2 q) (ly:intlog2 p)))
         (dots 0))
   ;(ash p k) = p * 2^k
   (if (< (ash p k) q) (set! k (1+ k)))
   (set! p (- (ash p k) q))
   (while (begin (set! p (ash p 1))(>= p q))
    (set! p (- p q))
    (set! dots (1+ dots)))
   (if (> k 6)
    (ly:make-duration 6 0)
    (ly:make-duration k dots))
))

#(define (extract-music music from to)
  "Keeps only music between `from' and `to', `from' and `to' as moment"
  (let ((begin-pos (*current-moment*))
        (end-pos (ly:moment-add
                   (*current-moment*)
                   (ly:music-length music))))
   (cond
    ((whole-music-inside? begin-pos end-pos from to)
      (*current-moment* end-pos)
      music)
    ((whole-music-outside? begin-pos end-pos from to)
      (*current-moment* end-pos)
      (make-music 'Music))
    ; the intervals [begin-pos end-pos] [from to] overlap
    (else
    (cond
    ; inside a chords or for multiRest events
    ((ly:duration? (get-duration music))
      (if (moment-inside? begin-pos from to)
        (set! end-pos to)
        (begin
          (set! begin-pos from)
          (if (not (moment-inside? end-pos from to))(set! end-pos to))))
      (ly:music-set-property! music 'duration 
          (moment->duration  (ly:moment-sub end-pos begin-pos)))
      (*current-moment* end-pos)
      music)
    (else     ; for containers of chords
      (let ((elts (ly:music-property music 'elements))
          (elt  (ly:music-property music 'element)))
        (if (ly:music? elt)
        (ly:music-set-property! music 'element (extract-music elt from to)))
        (if (pair? elts) 
        (cond  
          ((simultaneous? music)    ; simultaneous music OR EventChords
          (ly:music-set-property! music 'elements (filter
            (lambda (evt)
              (or (music-has-no-length? evt) ; i.e for 'VoiceSeparator
                (begin
                  (*current-moment* begin-pos)  ; restore *current-moment*
                  (set! evt (extract-music evt from to))
                  (defined-music? evt)))) ; keeps if not (make-music 'Music)
            elts))
          (*current-moment* end-pos))
         (else              ; sequential music
          (ly:music-set-property! music 'elements (filter
            (lambda (evt)
              (set! evt (extract-music evt from to))
              (defined-music? evt))
            elts)))))
        music)))))))

%%%%%%%%%%%%%%%%%%%%%% the main function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
extractMusic =
#(define-music-function (parser location music from during) (ly:music? ly:music? ly:music?)
  (let* ((from-length (ly:music-length from))
         (during-length (ly:music-length during))
         (to-length (ly:moment-add during-length from-length)))
    (parameterize ((*current-moment* (ly:make-moment 0/1 0/1)))
                  (extract-music music from-length to-length))))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

music = \relative c' {
  \override Staff.NoteHead.color = #blue
  <c e>4-- d\< \tuplet 3/2 { e8 f g } a8^"a text" c\!
  b8 c b a^"another text" << { g4 f8 e } \\ { e4 d8 c } >>
  \override Voice.NoteHead.color = #green
  d2 g
  \override Voice.NoteHead.color = #red
  g16 a g f e8 d c2
}

\score {
  <<
    \new Staff \new Voice {
      \music
      c'1
    } 
    \new Staff \new Voice {
      s1
      \extractMusic \music  s1 s1*2
      s1
      c'1
    }
  >>
}
