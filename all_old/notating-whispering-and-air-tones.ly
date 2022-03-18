%% http://lsr.dsi.unimi.it/LSR/Item?id=847
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/notehead
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/note-head-styles

whisperOn = {
  \override NoteHead.stem-attachment = #'(0 . -1.5)
  \override NoteHead.stencil =
    #(lambda (grob)
       (make-circle-stencil 0.6 0.2
         (> (ly:grob-property grob 'duration-log) 1)))
  \override Staff.AccidentalPlacement.right-padding = #0.6
}

whisperOff = {
  \revert NoteHead.stem-attachment
  \revert NoteHead.stencil
  \revert Staff.AccidentalPlacement.right-padding
}

\new Staff \relative c' {
  \whisperOn
  | c1
  | es2 g4 f8 d8
  \whisperOff
  | c2 c2
  % to print default-BarLines in the section with 'line-count = #1 add:
  % \override Staff.BarLine.bar-extent = #'(-2 . 2)
  \stopStaff
  \override Staff.StaffSymbol.line-count = #1
  \startStaff
  {
    \whisperOn
    | \tuplet 5/4 { b'16 b16 b16 b16 b16 } b16 b16 b8 b8 b4.
  }
  \addlyrics {
    | Hip -- po -- pot -- a -- mus ce -- ler -- y pa -- per
  }
}
