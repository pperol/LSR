%% http://lsr.di.unimi.it/LSR/Item?id=598
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/special-rhythmic-concerns
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-tweaking-grace-layout-within-music

\relative c'' {
  \new Staff {
    $(remove-grace-property 'Voice 'Stem 'direction)
    $(add-grace-property 'Voice 'NoteHead 'style 'cross)
    \new Voice {
       \acciaccatura { f16 } g4
       \grace { d16 e } f4
       \appoggiatura { f,32 g a } e2
    }
  }
}
