%% http://lsr.dsi.unimi.it/LSR/Item?id=585
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-makam-example

% Initialize makam settings
\include "makam.ly"

\relative c' {
  \set Staff.keySignature = #`((6 . ,(- KOMA)) (3 . ,BAKIYE))
  c4 cc db fk
  gbm4 gfc gfb efk
  fk4 db cc c
}
