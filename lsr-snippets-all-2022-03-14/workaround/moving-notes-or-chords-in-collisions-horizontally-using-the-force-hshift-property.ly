\header {
  texidoc = "
You can manually determine the horizontal shift of a note or a chord
when it collides with notes in other voices, using the @code{NoteColumn
#'force-hshift} property. Overriding this property will appropriately
move all objects associated with the note or chord—that is, the stem
with all its noteheads, ledger lines, augmentation dots and beams.

Note that this technique will only work when the notehead collides with
noteheads in other voices, and has no effect in monophonic situations. 

"
  doctitle = "Moving notes or chords in collisions horizontally using the force-hshift property"
}
%% http://lsr.di.unimi.it/LSR/Item?id=14
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/fixing-overlapping-notation#the-force_002dhshift-property

\relative c' {
  <<
    { c8. c16 } 
    \\
    { c4 }
  >>
  <<
    { \once \override NoteColumn.force-hshift = #-2 c8. c16 } 
    \\
    { c4 }
  >>
}

