%% http://lsr.di.unimi.it/LSR/Item?id=254
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/note-heads


fragment = {
  \key c \major
  c2 d
  e2 f
  g2 a
  b2 c
}

\new Staff {
  \transpose c d 
  \relative c' {
    \set shapeNoteStyles = ##(do re mi fa
                               #f la ti)
    \fragment
  }

  \break

  \relative c' {
    \set shapeNoteStyles = ##(cross triangle fa #f
                               mensural xcircle diamond)
    \fragment
  }
}
