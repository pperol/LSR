%% http://lsr.dsi.unimi.it/LSR/Item?id=836
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-rests#full-measure-rests

cadenzaToMusic =
#(define-music-function (parser location cadenzaMusic music)
                                                (ly:music? ly:music?)
"Adjust the length of `music and the measureLength, to fit the length of
`cadenzaMusic"
(let* ((clen (ly:music-length cadenzaMusic))
     (mlen (ly:music-length music))
     (factor (ly:moment-div clen mlen))
     (compressed (ly:music-compress music factor)))
 ;; (format #t "factor : ~a\n" factor)
 #{
  \set Timing.measureLength = $clen
  $compressed
  \unset Timing.measureLength
 #}))

\include "english.ly"

cadenzaC = \relative c''' {
 b2 ^\markup { \italic "cadenza" } ~
 \oneVoice b8 \fermata [a8] ) e'16 ( [a, fs a] \voiceOne b4 \fermata ~
}

cadenzaD = \relative c''' {
 b4 ~ ^\markup { \italic "cadenza" } b8 \fermata [a8] ) g16 ( [fs e d
e fs ] e4 ) \fermata ~
}

\score {
 <<
  \new Staff {
    \override Score.BarNumber.break-visibility = #'#(#t #t #t)
    \key d \major \numericTimeSignature
    R1
    \cadenzaToMusic \cadenzaC R1
    R1
    \cadenzaToMusic \cadenzaD R1
    R1
  }
  \new Staff \relative c''' {
    \key d \major \numericTimeSignature
    r2 r4 a4 (
    \cadenzaC
    b1 ~
    \cadenzaD
    e,4. r8 r2
  }
 >>
}
