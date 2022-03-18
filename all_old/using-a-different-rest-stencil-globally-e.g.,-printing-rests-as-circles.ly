%% http://lsr.di.unimi.it/LSR/Item?id=548
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/modifying-stencils.fr.html

% Our own stencil for rests: quarter rests are shown as a centered filled circle, 
% eighth rests are an underlined filled circle:
#(define (ly:rest-interface::dot-rests grob)
  (let ((duration (ly:grob-property grob 'duration-log))
        (circle (ly:stencil-translate-axis (make-circle-stencil 0.55 0.1 #t) 0.3 X)))
    (case duration
      ((2) circle)
      ((3) (ly:stencil-add
               circle
               (make-filled-box-stencil '(-0.275 . 0.9) '(-1.35 . -1.0))))
      (else (ly:rest::print grob)))))

\layout {
  \context {
    \Voice
    \override Rest.stencil = #ly:rest-interface::dot-rests
  }
}

\relative c' {
  R1 |
  r2 e |
  e4. r8 e4 r4 |
  r8. r16 r4. r8 e4 |
}

% If you want this rest style only for some parts of a score, remove the 
% \layout block above and simply override the Rest stencil wherever you want.
% After the block with circle rests, simply revert the stencil property to its
% default values:
% \relative c' {
%   e4. r8 e4 r4
%   \override Rest.stencil = #ly:rest-interface::dot-rests
%   e4. r8 e4 r4
%   \revert Rest.stencil
%   e4. r8 e4 r4
% }



