%% http://lsr.di.unimi.it/LSR/Item?id=760
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/notenames

tiedNoteToSkip = #(define-music-function (parser location music) (ly:music?)
(let ((prev-was-tie? #f))
  (define (tied-note->skip evt)
     (let ((elt (ly:music-property evt 'element))
           (elts (ly:music-property evt 'elements))
           (name (ly:music-property evt 'name)))
      (cond ((and prev-was-tie?
                  (eq? name 'EventChord)
                  (pair? elts)
                  (ly:duration? (ly:music-property (car elts) 'duration)))
                (set! prev-was-tie? #f)
                (skip-of-length  evt)) ;; eventChord -> skip 
            ((eq? name 'TieEvent)
                (set! prev-was-tie? #t)
                #f) ;; all tie events will be deleted
            (else
                (if (ly:music? elt) (ly:music-set-property! evt 'element
                                        (tied-note->skip elt)))
                (if (pair? elts) (ly:music-set-property! evt 'elements
                                        (filter-map tied-note->skip elts)))
                evt))))
 (tied-note->skip music)))

mymusic = { e'4 d' ~ d'2 c'1}

\score {
 <<
 \new Voice \mymusic
 \context NoteNames \tiedNoteToSkip \mymusic
 >>
}


