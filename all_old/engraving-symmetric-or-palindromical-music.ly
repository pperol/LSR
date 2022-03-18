%% http://lsr.dsi.unimi.it/LSR/Item?id=130
%% see also http://lilypond.1069038.n5.nabble.com/LSR-v-2-18-quot-Engraving-symmetric-or-palindromical-music-quot-works-partially-tc159398.html

% provided by harm on Feb. 2014
% partially new coding to reflect the changes to 'EventChord, introduced after 2.14.

#(define (turn-span-dir music)
  (let ((span-dir (ly:music-property music 'span-direction)))
    (if (ly:dir? span-dir)
        (ly:music-set-property! music 'span-direction (- span-dir))
        (music-map
          (lambda (mus)
            (if (music-is-of-type? mus 'note-event)
                (begin
                   (for-each
                     (lambda (m) 
                        (if (music-is-of-type? m 'span-event)
                            (ly:music-set-property! m 'span-direction 
                               (- (ly:music-property m 'span-direction)))
                            m))
                     (ly:music-property mus 'articulations))
                   mus)
                 mus))
          music))))

#(define (reverse-music music)
  (let* ((elements (ly:music-property music 'elements))
         (reversed (reverse elements))
         (e (ly:music-property music 'element)))

    (if (not (null? elements))
        (ly:music-set-property! music 'elements reversed))

    (if (ly:music? e)
        (ly:music-set-property!
         music 'element
         (reverse-music e)))

    (turn-span-dir music)

    (map reverse-music reversed)
    
    music))

reverseMusic =
#(define-music-function (parser location m) (ly:music?)
  (reverse-music m))	

music =
\relative c'' { c4-.\(\cresc\startTrillSpan <d f>4--( e4\startTextSpan f4 }

\score {
  \context Voice {
    \music
    \reverseMusic \music
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% above one simply uses event-chord-wrap!
%{
  
#(define (reverse-music music)
  (let* ((elements (ly:music-property music 'elements))
         (reversed (reverse elements))
         (e (ly:music-property music 'element))
         (span-dir (ly:music-property music 'span-direction)))

    (ly:music-set-property! music 'elements reversed)

    (if (ly:music? e)
        (ly:music-set-property!
         music 'element
         (reverse-music e)))

    (if (ly:dir? span-dir)
        (ly:music-set-property! music 'span-direction (- span-dir))) 

    (map reverse-music reversed)
    
    music))

reverseMusic =
#(define-music-function (parser location m) (ly:music?)
   (reverse-music (event-chord-wrap! m)))

%}
  
