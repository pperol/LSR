%% http://lsr.di.unimi.it/LSR/Item?id=547
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides

% alteration position
posbc = { \override Accidental.extra-offset = #'(-0.4 . 0) }
posbm = { \override Accidental.extra-offset = #'(0.4 . 0) }

% alteration size
sizeft = { \override Score.Accidental.font-size = #-1 }

\relative c'' {
  % so that the two alterations are not too close
  \sizeft
  <<
    { \posbc a!4 a! a! a! }
    \\
    { \posbm aes! aes! aes! aes! }
  >>
}
