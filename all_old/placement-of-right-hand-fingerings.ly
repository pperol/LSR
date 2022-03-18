%% see http://lsr.dsi.unimi.it/LSR/Item?id=496
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-fretted-strings#right_002dhand-fingerings

#(define RH rightHandFinger)

\relative c {
  \clef "treble_8"
  
  \set strokeFingerOrientations = #'(up down)
  <c-\RH #1 e-\RH #2 g-\RH #3 c-\RH #4 >4
  
  \set strokeFingerOrientations = #'(up right down)
  <c-\RH #1 e-\RH #2 g-\RH #3 c-\RH #4 >4
  
  \set strokeFingerOrientations = #'(left)
  <c-\RH #1 e-\RH #2 g-\RH #3 c-\RH #4 >2
}
