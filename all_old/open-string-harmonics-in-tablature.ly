%% http://lsr.di.unimi.it/LSR/Item?id=819
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-fretted-strings.html
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings#fretted-strings-slides-in-tablature

%LSR modified by P.P.Schneider on Feb.2014

openStringHarmonics = {
  %first harmonic
  \harmonicByFret #12 e,2\6_\markup{"1st harm."}
  \harmonicByRatio #1/2 e,\6
  %second harmonic
  \harmonicByFret #7 e,\6_\markup{"2nd harm. - - - -"}
  \harmonicByRatio #1/3 e,\6
  \harmonicByFret #19 e,\6
  \harmonicByRatio #2/3 e,\6
  %\harmonicByFret #19 < e,\6 a,\5 d\4 >
  %\harmonicByRatio #2/3 < e,\6 a,\5 d\4 >
  %third harmonic
  \harmonicByFret #5 e,\6_\markup{"3rd harm. - - - -"}
  \harmonicByRatio #1/4 e,\6
  \harmonicByFret #24 e,\6
  \harmonicByRatio #3/4 e,\6
  \break
  %fourth harmonic
  \harmonicByFret #4 e,\6_\markup{"4th harm. - - - - - - - - - - - - -"}
  \harmonicByRatio #1/5 e,\6
  \harmonicByFret #9 e,\6
  \harmonicByRatio #2/5 e,\6
  \harmonicByFret #16 e,\6
  \harmonicByRatio #3/5 e,\6
  %fifth harmonic
  \harmonicByFret #3 e,\6_\markup{"5th harm."}
  \harmonicByRatio #1/6 e,\6
  \break
  %sixth harmonic
  \harmonicByFret #2.7 e,\6_\markup{"6th harm."}
  \harmonicByRatio #1/7 e,\6
  %seventh harmonic
  \harmonicByFret #2.3 e,\6_\markup{"7th harm."}
  \harmonicByRatio #1/8 e,\6
  %eighth harmonic
  \harmonicByFret #2 e,\6_\markup{"8th harm."}
  \harmonicByRatio #1/9 e,\6
}

\score {
  <<
    \new Staff \with { \omit StringNumber } {
      \new Voice {
        \clef "treble_8"
        \openStringHarmonics
      }
    }
    \new TabStaff {
      \new TabVoice {
        \openStringHarmonics
      }
    }
  >>
}
