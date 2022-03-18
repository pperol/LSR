%% http://lsr.dsi.unimi.it/LSR/Item?id=674
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-moving-dotted-notes-in-polyphony

\new Staff \relative c' <<
  { 
    f2. f4
    \override Staff.NoteCollision.prefer-dotted-right = ##f
    f2. f4
    \override Staff.NoteCollision.prefer-dotted-right = ##t
    f2. f4
  }
  \\
  { e4 e e e e e e e e e e e }
>>
