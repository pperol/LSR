%% http://lsr.di.unimi.it/LSR/Item?id=643
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-vocal-music

%LSR contributed by Neil Puttock

#(define (extend text . padding)
   (let ((extender (make-music 'ExtenderEvent))
	 ;; optional padding
	 (padding (if (pair? padding)
		      (car padding)
		      0)))

     (set! (ly:music-property extender 'tweaks)
	   (acons 'stencil (lambda (grob)
			     (let* ((orig (ly:grob-original grob))
				    (siblings (ly:spanner-broken-into orig)))

			       (if (or (null? siblings)
				       (and (>= (length siblings) 2)
					    (eq? (car (last-pair siblings))
						 grob)))
				   (ly:stencil-combine-at-edge
				    (ly:lyric-extender::print grob)
				    X RIGHT
				    (grob-interpret-markup grob text)
				    padding)
				   (ly:lyric-extender::print grob))))
		  (ly:music-property extender 'tweaks)))
     extender))

%Define custom extenders, first with extra padding
extendComma = #(extend "," 0.2)
extendExclaim = #(extend "!")

\score {  
  <<
    \new Staff \new Voice = melody \relative c' {
      c4( d e f)
      g4( f e2)
    }
    \new Lyrics \lyricsto melody {
      Aah \extendComma
      Ooh \extendExclaim
    }
  >>
  \layout {
    \context {
      \Lyrics
      \consists "Tweak_engraver"
    }
  }
}
