%% http://lsr.di.unimi.it/LSR/Item?id=335
%% see also http://lsr.di.unimi.it/LSR/Item?id=827

%LSR Wilbert Berendsen and Han-Wen Nienhuys; see http://www.mail-archive.com/lilypond-user%40gnu.org/msg30785.html

#(define-markup-command (snappizz layout props) ()
  (interpret-markup layout props
    (markup #:stencil
      (ly:stencil-translate-axis
        (ly:stencil-add
          (make-circle-stencil 0.7 0.1 #f)
          (ly:make-stencil
            (list 'draw-line 0.1 0 0.1 0 1)
            '(-0.1 . 0.1) '(0.1 . 1)))
        0.7 X))))

snapPizzicato = \markup \snappizz

% now it can be used as \snappizzicato after the note/chord
% Note that a direction (-, ^ or _) is required.
\relative c' {
  c4^\snapPizzicato
  % This does NOT work:
  %<c e g>\snapPizzicato
  <c' e g>-\snapPizzicato
  <c' e g>^\snapPizzicato
  <c, e g>_\snapPizzicato
}
