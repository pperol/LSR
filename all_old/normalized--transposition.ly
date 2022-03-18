%% http://lsr.dsi.unimi.it/LSR/Item?id=697
%% see also http://lilypond.1069038.n5.nabble.com/LSR-v2-18-quot-Normalized-transposition-quot-does-not-compile-tc159368.html

%LSR contributed by Jay Anderson http://lists.gnu.org/archive/html/lilypond-user/2008-06/msg00426.html
%% see upraded version by David Kastrup on Feb. 15, 2014.
%% "it might be worth just using quoted music for that: it automatically transforms itself into concert pitch."

#(define (adjust-note mus key currkey)
 (cond ((eq? (ly:music-property mus 'name) 'NoteEvent)
         (ly:music-transpose mus (car currkey)))
       ((and
          (eq? (ly:music-property mus 'name) 'PropertySet)
          (eq? (ly:music-property mus 'symbol) 'instrumentTransposition))
         (set-car! currkey (ly:music-property mus 'value))
         (ly:music-set-property! mus 'value (ly:make-pitch 0 0 0))
         mus)
       (else mus)))

normalizeTransposition =
#(define-music-function (parser location key music) (ly:pitch? ly:music?)
 (ly:music-transpose
   (let ((currkey (list (ly:make-pitch 0 0 0))))
     (music-map (lambda (x) (adjust-note x key currkey)) music))
   (ly:pitch-negate key)))

music = \relative c' {
 \time 4/4
 \transposition f
 c e g c |
 \transposition ees
 c, e g c |
 \transposition d
 c, e g c |
}

\score {
 <<
   \new Staff {
     \music
   }
   \new Staff {
     \normalizeTransposition f \music
   }
 >>
 \layout {}
 \midi {}
}
