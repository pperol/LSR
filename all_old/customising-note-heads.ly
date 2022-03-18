%% http://lsr.di.unimi.it/LSR/Item?id=475
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/note-heads

%LSR This snippet was contributed by Victor Adan

headCircle   = {
\once \override NoteHead.stencil = #ly:text-interface::print
\once \override NoteHead.text = #(markup #:musicglyph "scripts.flageolet" ) }

headPlus        = {
\once \override NoteHead.stencil = #ly:text-interface::print
\once \override NoteHead.text = #(markup #:musicglyph "scripts.stopped") }

{
  \headCircle
  c'4
  \headPlus
  d'4
  % normal
  e'4
}
