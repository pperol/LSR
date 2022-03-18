%% http://lsr.di.unimi.it/LSR/Item?id=143
%% http://www.lilypond.org/doc/v2.18/Documentation/learning/size-of-objects

\score {
  {
    \relative c' {
      \context Staff = One { c4 d e f }
      <<
        { c d e f | c d e f | c c c c | c c c c }
        \context TemporaryStaff = Two { c4 c8 d e4 f | c d e f |
          c c c c | c c c8 b c b |}
      >>
      c4 d e f |
    }
  }
  \layout {
    \context {
      \Score
      \consists "Span_bar_engraver"
      % Avoid a vertical line at the beginning of the system:
      \remove "System_start_delimiter_engraver"
      % Incorporate the new context in the hierarchy
      \accepts "TemporaryStaff"
    }
    \context {
      \Staff
      \name "TemporaryStaff"
      \alias "Staff"
      \remove "Clef_engraver"
      \remove "Time_signature_engraver"
      \remove "Key_engraver"
    }
  }
}
