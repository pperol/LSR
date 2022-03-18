%% http://lsr.di.unimi.it/LSR/Item?id=770
%% see also doc v-2.18 http://lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides#tweaks-and-overrides-cross_002dstaff-chords-_002d-beaming-problems-workaround
%% see also doc v-2.19 http://lilypond.org/doc/v2.19/Documentation/snippets/tweaks-and-overrides#tweaks-and-overrides-cross_002dstaff-chords-_002d-beaming-problems-workaround


\new PianoStaff <<
  \new Staff = up
    \relative c' {
      <<
        { r4
          \override Stem.cross-staff = ##t
          \override Stem.length = #19 % this is in half-spaces,
              % so it makes stems 9.5 staffspaces long
          \override Stem.Y-offset = #-6 % stems are normally lengthened
              % upwards, so here we must lower the stem by the amount
              % equal to the lengthening - in this case (19 - 7) / 2
              % (7 is default stem length)
          e e e }
        { s4
          \change Staff = "bottom"
          \override NoteColumn.ignore-collision = ##t
          c, c c
        }
      >>
    }
  \new Staff = bottom
    \relative c' {
      \clef bass
      \voiceOne
      g8 a g a g a g a
    }
>>
