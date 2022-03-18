%% http://lsr.di.unimi.it/LSR/Item?id=298
%% see also  http://lilypond.org/doc/v2.18/Documentation/snippets/simultaneous-notes#simultaneous-notes-changing-a-single-note_0027s-size-in-a-chord


\relative c' {
  <\tweak font-size #+2 c e g c \tweak font-size #-2 e>1^\markup { A tiny e }_\markup { A big c }
}
