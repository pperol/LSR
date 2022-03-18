%% http://lsr.di.unimi.it/LSR/Item?id=537
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-chords


hideVoiceNotation = {
  \hideNotes
  \override TupletBracket.bracket-visibility = ##f
  \override TupletNumber.stencil = ##f
  \override Tie.transparent = ##t
  \override Rest.transparent = ##t
  \override Slur.transparent = ##t
  % hide the articulations
  \override Script.transparent = ##t
}

lowerChords = { \override ChordName.Y-offset = #-2.3 }
raiseLyrics = { \override LyricText.Y-offset = #1.5 }

text = \lyricmode { Ho ho, ho ho ho. Ha ha, ha. }

melody = \relative c'' {
  r4 e8(-- \melisma f) \melismaEnd e4.-> e8-. |
  a4. d,8 ~ \melisma d2 \melismaEnd |
  \tuplet 3/2 { d4( \melisma b4) \melismaEnd gis4 } b,2  |
}

harmonies = \chordmode { a1:m | d:m | e:7 | }

\score {
  <<
    \new ChordNames { \harmonies }
    \new Staff {
      \new Voice = "vocal" { \melody }
    }
    \new Lyrics \lyricsto "vocal" \text
  >>
  \layout { }
}

\score {
  <<
    \new ChordNames { \lowerChords \harmonies }
    \new Staff {
      \new Voice = "vocal" { \hideVoiceNotation \melody }
    }
    \new Lyrics \lyricsto "vocal" { \raiseLyrics \text }
  >>
  \layout { }
}
