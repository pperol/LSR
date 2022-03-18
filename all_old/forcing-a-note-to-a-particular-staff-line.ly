%% http://lsr.dsi.unimi.it/LSR/Item?id=778

squashTo = #(define-music-function
  (parser location position music)
  (number? ly:music?)
  #{
    \set squashedPosition = $position
    $music
    \unset squashedPosition
  #})

middleLine = #(define-music-function
  (parser location music)
  (ly:music?)
  #{
    \squashTo #0 $music
  #})

\new Voice 
\with { \consists "Pitch_squash_engraver"} 
\relative c' {
  \clef treble
  \squashTo #1 { c4 d e f }
  \clef alto
  \squashTo #0 { c4 d e f }
  \clef bass
  \squashTo #-1 { c4 d e f }
  \middleLine { c4 d e f }
}
