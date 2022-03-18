%% http://lsr.di.unimi.it/LSR/Item?id=796
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines#glissando

% The positions of the headless notes are dependent on the clef.
% You can use a Pitch_squash_engraver to get around this.

\new PianoStaff <<
  \new Staff = "right" {
    \clef treble
    e'''8\glissando^"gliss. ad lib." s8*3
    \change Staff = "left"
    \override NoteHead.transparent = ##t
    \override NoteHead.no-ledgers = ##t
    c,8\glissando s8*3 |
    \change Staff = "right" c'''8 r
    % Back to normal
    \override NoteHead.transparent = ##f
    \override NoteHead.no-ledgers = ##f
    c''4 d'' e''
  }
  \new Staff = "left" {
    \clef bass
    s1 |
    r4 c d e
  }
>>
