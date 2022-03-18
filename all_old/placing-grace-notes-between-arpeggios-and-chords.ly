%% http://lsr.dsi.unimi.it/LSR/Item?id=410
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/chords

\score {
  \new PianoStaff { <<
    \new Staff \relative c' {
      \clef treble \key es \major
      \override PhrasingSlur.positions = #'(2.5 . 2.2)
      \override Slur.minimum-length = #3
      <f d bes>4^\( <g es des bes>
      << {
        \acciaccatura bes8\arpeggio
        \once \override NoteColumn.ignore-collision = ##t
        as4
      }
      \new Voice { \voiceTwo
        \hideNotes \grace bes,8\arpeggio
        \unHideNotes \oneVoice <es c>4
      } >> <g e bes>4\)\fermata |
      <f c as>4^\( <es! c g>
      << {
        \acciaccatura g8\arpeggio
        \once \override NoteColumn.ignore-collision = ##t
        f4
      }
      \new Voice { \voiceTwo
        \hideNotes \grace g,8\arpeggio
        \unHideNotes \oneVoice <c as>4
      } >> <es c g>4\)\fermata |
    }
    \new Staff \relative c {
      \clef bass \key es \major
      bes4 es as, c\fermata |
      <f, c'> <c c'> <f c'> <c c'>\fermata
    }
  >> }
  \layout {
    \context {
      \Staff
      \consists "Span_arpeggio_engraver"
      connectArpeggios = ##t
    }
  }
}



