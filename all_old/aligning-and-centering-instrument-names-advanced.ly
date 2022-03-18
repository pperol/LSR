%% http://lsr.di.unimi.it/LSR/Item?id=383
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/paper-and-layout

% This code was originally contributed by Nicolas Sceaux, for LilyPond 2.11.38 and above

#(define-markup-command (hcenter-pad layout props width arg)
 (number? markup?)
 (let* ((arg-stencil (interpret-markup layout props arg))
        (w (interval-length (ly:stencil-extent arg-stencil X)))
        (pad-stencil (ly:make-stencil ""
                       (cons 0 (if (> w width)
                                0
                                (/ (- width w) 2.0)))
                       '(-0.1 . 0.1))))
  (stack-stencil-line 0
    (list pad-stencil arg-stencil pad-stencil))))

#(define-markup-command (instruments layout props texts) (markup-list?)
   (let ((indent (ly:output-def-lookup layout 'indent)))
     (interpret-markup layout props
      (make-column-markup
        (map (lambda (m) (markup #:hcenter-pad indent #:huge m))
        texts)))))

#(define-markup-command (instrument layout props text) (markup?)
 (interpret-markup layout props
  (markup #:instruments (text))))

\score {
  \new StaffGroup <<
    \new Staff <<
      \set Staff . instrumentName = \markup \instrument Violons
      { c'4 d' e' f' g'1 }
    >>
    \new Staff <<
      \set Staff . instrumentName = \markup \instruments { Haute-
contres Tailles }
      { \clef alto c'4 d' e' f' g'1 }
    >>
    \new Staff <<
      \set Staff . instrumentName = \markup \instrument Basses
      { \clef bass c4 c c g, c1 }
    >>
  >>
  \layout { indent = 4\cm }
}
