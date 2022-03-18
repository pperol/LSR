%% http://lsr.dsi.unimi.it/LSR/Item?id=690

%LSR Slur avoidance was fixed in version 2_13_24

thumb =
#(let ((finger (make-music 'FingeringEvent)))
   (set! (ly:music-property finger 'tweaks)
         (acons 'text (markup #:fontsize 5 #:musicglyph "scripts.thumb")
                (ly:music-property finger 'tweaks)))
   finger)

\relative c' {
  c2\thumb
  \set fingeringOrientations = #'(right)
  <c\thumb>2
}
