%% http://lsr.dsi.unimi.it/LSR/Item?id=633
%% LSR Contributed by Federico Bruni

hideFretNumber = {
  \once \override TabNoteHead.transparent = ##t
  \once \override TabNoteHead.whiteout = ##f
  \once \override NoteHead.transparent = ##t
  \once \override Stem.transparent = ##t
  \once \override NoteHead.no-ledgers = ##t
  \once \override Accidental.transparent = ##t
}

music = \relative c' {
  \key e \major
  s2  fis
  s2 \grace { \hideFretNumber f\2 \glissando s }  fis2\2
}

<<
  \new Staff {
    \override Staff.StringNumber.stencil = ##f
    \new Voice { \music }
  }
  \new TabStaff {
    \new TabVoice { \music }
  }
>>
