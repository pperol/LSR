%% http://lsr.dsi.unimi.it/LSR/Item?id=465

%LSR This snippet was contributed by Jay Anderson
%=> http://comments.gmane.org/gmane.comp.gnu.lilypond.general/37271
%LSR upgraded by Harm on Feb.2014 for v2.18 
%LSR upgraded by David Kastrup on Feb.2014 for v2.18 
%=> http://lilypond.1069038.n5.nabble.com/LSR-v-2-18-quot-Easy-Rhythm-Template-Creation-quot-does-not-compile-tt159397.html#a159859

rhythmTemplate =
#(define-scheme-function (parser location pattern) (ly:music?)
   (define-music-function (parser location chord) (ly:music?)
     (make-relative (chord) chord
       (map-some-music
	(lambda (m)
	  (and (music-is-of-type? m 'skip-event)
	       (let ((dur (ly:music-property m 'duration))
		     (art (ly:music-property m 'articulations))
		     (res (ly:music-deep-copy chord)))
		 ;; transfer duration of skip to all elements with duration
		 (for-some-music
		  (lambda (c)
		    (and (ly:duration? (ly:music-property c 'duration))
			 (begin
			   (set! (ly:music-property c 'duration) dur)
			   #t)))
		  res)
		 ;; transfer articulations of skip to all relevant targets
		 (for-some-music
		  (lambda (c)
		    (let ((prop
			   (cond ((music-is-of-type? c 'event-chord) 'elements)
				 ((music-is-of-type? c 'rhythmic-event) 'articulations)
				 (else #f))))
		      (and prop
			   (begin
			     (set! (ly:music-property c prop)
				   (append (ly:music-property c prop)
					   art))
			     #t))))
		  res)
		 res)))
	(ly:music-deep-copy pattern)))))

rhya = \rhythmTemplate { s8.-> s16 s8 }
rhyb = \rhythmTemplate { s8[ r16 s16 s8] }
rhyc = \rhythmTemplate { s16 s~ s4 }

rhyd = \rhythmTemplate { \times 2/3 { s8 s8 s8 } s4 s4 s8 s8 s4 }
rhye = \rhythmTemplate { \times 2/3 { s8---\pp s8-- s8-- } s4--
                                      s4-- s8-- s8-- s4-- }
rhyf = \rhythmTemplate { \times 2/3 { s4 \times 2/3 { s8 s-> s } s4 } }

\score
{
 \new Staff \relative c'
 {
  \time 6/8
  \rhya c \rhyb c' |
  \rhya <c, e> \rhyb <c f> |
  \rhyc <c e> \rhyc <c d> |
  \time 5/4
  \rhyd c
  \rhyd e
  \rhye <c e g>
  \time 4/4
  \rhyf c \rhyf d
  }
}
