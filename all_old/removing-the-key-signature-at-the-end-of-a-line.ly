%% http://lsr.di.unimi.it/LSR/Item?id=124
%% http://www.lilypond.org/doc/v2.18/Documentation/notation/visibility-of-objects

\paper {
  ragged-right = ##t
}

\score {
   \relative c' {
    \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
    c d e f | g a b c | \break
    \key d \major
    d cis b a | g fis e d |
  }
}
