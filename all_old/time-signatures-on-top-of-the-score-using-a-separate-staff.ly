%% http://lsr.di.unimi.it/LSR/Item?id=272
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-time-signature-in-parentheses-_002d-method-3


\layout {
  \context {
    \type "Engraver_group"
    \consists "Time_signature_engraver"
    \consists "Axis_group_engraver"
    \name "TimeSig"
    \alias "Staff"
    \override TimeSignature.font-size = #3
    \override TimeSignature.break-align-symbol = ##f
    \override TimeSignature.X-offset =
      #ly:self-alignment-interface::x-aligned-on-self
    \override TimeSignature.self-alignment-X = #CENTER
    \override TimeSignature.after-line-breaking =
      #shift-right-at-line-begin
  }
  \context {
    \Score
    \accepts TimeSig
  }
  \context {
    \Staff
    \remove "Time_signature_engraver"
  }
}

timeSignatures = { \numericTimeSignature \time 2/4 s2 \time 3/4 s2. \time 4/4 s1 }

\score {
  <<
    \new TimeSig \timeSignatures
    \new Staff \relative c' { c'2 c2. c1 }
    \new Staff { a2 a2. a1 }
  >>
}
