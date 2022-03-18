%% http://lsr.di.unimi.it/LSR/Item?id=532
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/techniques-specific-to-lyrics
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music

\score {
  \new Staff \relative c' {
    \cadenzaOn
    f4
    % resume normal timing so that rest can be typeset
    \cadenzaOff
    % change print function to percent repeat
    \once \override MultiMeasureRest.stencil =
      #ly:multi-measure-rest::percent
    % correct percent repeat slash thickness
    \once \override MultiMeasureRest.thickness = #0.48
    % align percent repeat with hidden note
    \once \override MultiMeasureRest.X-offset = #3.2
    << { R1 } { \hideNotes f \unHideNotes } >>
    % hide bar line from timed section
    \bar ""
    \cadenzaOn f4 g4 a2 \bar ";"
    a4 a a g bes4 a1( g4 a) g f1 \bar "|"
  }
  \addlyrics {
    The "LORD hath said unto me: Thou" art my Son;
    this day have I be -- got -- ten thee.
  }
  \layout {
    \context {
      \Staff
      \remove "Time_signature_engraver"
    }
    \context {
      \Score
      \override BarNumber.transparent = ##t
    }
  }
}
