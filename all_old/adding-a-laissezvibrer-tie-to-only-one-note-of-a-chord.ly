%% http://lsr.di.unimi.it/LSR/Item?id=714
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-rhythms#ties

%LSR after a mail from Robin Bannister http://lists.gnu.org/archive/html/lilypond-user/2009-04/msg00344.html

% laissezVibrer using feta char overlay: dir: UP or DOWN (or pad per magnitude)
#(define (flvSt dir)
  (lambda (grob)
   (define dirsign
    (if (positive? dir) + -) )
   (let* ((pos (ly:grob-property grob 'staff-position))
          (height (if (odd? pos) +0.8 +0.55)) (angle +90))
    (ly:stencil-combine-at-edge (ly:note-head::print grob) 0 1
     (grob-interpret-markup grob (markup
                                  #:with-dimensions '(0 . 0) '(0 . 0)
                                  #:concat (#:hspace (abs dir)
                                            #:raise (dirsign height)
                                            #:rotate (dirsign angle)
                                            #:musicglyph "accidentals.rightparen" ))) 0))))

flvUP =
\once \override NoteHead.stencil = #(flvSt UP)

flvDOWN =
\once \override NoteHead.stencil = #(flvSt DOWN) % or \tweak stencil   ___ditto____

flvUPtw =
#(define-music-function (parser location mus) (ly:music?)
   (set! (ly:music-property mus 'tweaks)
         (acons 'stencil  (flvSt UP)
                (ly:music-property mus 'tweaks))) mus)

flvDOWNtw =
#(define-music-function (parser location mus) (ly:music?)
   (set! (ly:music-property mus 'tweaks)
         (acons 'stencil  (flvSt DOWN)
                (ly:music-property mus 'tweaks))) mus)

\relative c' {
  <a e'>4\laissezVibrer s
  <\flvDOWNtw a \flvUPtw e'>4 s
  <a \flvUPtw e'>4 s
  <\flvDOWNtw a e'>4 s
}
