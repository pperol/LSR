%% http://lsr.dsi.unimi.it/LSR/Item?id=248
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/arabic-music.html

\relative c' {
  \set Staff.keySignature = #`(((0 . 6) . ,FLAT)
                               ((0 . 5) . ,FLAT)
                               ((0 . 3) . ,SHARP))
  c4 d e fis
  aes4 bes c2
}
