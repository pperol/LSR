%% http://lsr.di.unimi.it/LSR/Item?id=726
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/visibility-and-color-of-objects


%LSR contributed by Valentin: http://lists.gnu.org/archive/html/lilypond-user-fr/2010-10/msg00252.html

bgcolor =
#(define-music-function (parser location color) (string?)
 #{\override Staff.StaffSymbol $'stencil = $(lambda (grob)
    (let* ((staff (ly:staff-symbol::print grob))
           (X-ext (ly:stencil-extent staff X))
           (Y-ext (ly:stencil-extent staff Y)))
         (set! Y-ext (cons
            (- (car Y-ext) 2)
            (+ (cdr Y-ext) 2)))
         (ly:grob-set-property! grob 'layer -10)
         (ly:stencil-add
           (ly:make-stencil (list 'color (eval-string color)
               (ly:stencil-expr (ly:round-filled-box X-ext Y-ext 0))
               X-ext Y-ext))
           staff)))
#})

<<
  \new Staff { \bgcolor "blue" a'1 } % basic colors
  \new Staff { \bgcolor "(x11-color 'red)" b' } % x11 colors
  \new Staff { \bgcolor "(rgb-color 1 0.8 0.6)" c'' } % rgb colors
>>
