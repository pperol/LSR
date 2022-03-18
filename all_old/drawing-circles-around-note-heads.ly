%% http://lsr.di.unimi.it/LSR/Item?id=722
%% see also http://lsr.di.unimi.it/LSR/Item?id=260
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic

%LSR contributed by Valentin http://lists.gnu.org/archive/html/lilypond-user/2010-10/msg00523.html

circle =
\once \override NoteHead.stencil = #(lambda (grob)
    (let* ((note (ly:note-head::print grob))
           (combo-stencil (ly:stencil-add
               note
               (circle-stencil note 0.1 0.8))))
          (ly:make-stencil (ly:stencil-expr combo-stencil)
            (ly:stencil-extent note X)
            (ly:stencil-extent note Y))))

{ \circle c' }
