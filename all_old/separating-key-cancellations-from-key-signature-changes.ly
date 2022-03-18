%% http://lsr.di.unimi.it/LSR/Item?id=541
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-separating-key-cancellations-from-key-signature-changes

%LSR Thanks to Gilles Thibault for this snippet!

\new Staff {
  \override Score.BreakAlignment.break-align-orders =
    ##((left-edge ambitus breathing-sign clef staff-bar
                   key-cancellation key-signature time-signature custos)
      
        (left-edge ambitus breathing-sign clef key-cancellation
                   staff-bar key-signature time-signature custos)
      
        (left-edge ambitus breathing-sign clef key-cancellation
                   key-signature staff-bar time-signature custos))

  \key des \major
  c'1
  \bar "||"
  \key bes \major
  c'1
}
