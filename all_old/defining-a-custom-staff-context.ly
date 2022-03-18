%% http://lsr.di.unimi.it/LSR/Item?id=882
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/defining-new-contexts

% DEFINE A CUSTOM STAFF CONTEXT FOR "LAYOUT" 
\layout {
  \context {
    \Staff
    % give the custom staff a name of your choice
    \name MyCustomStaff
    % tell LilyPond that commands that work on a standard
    % Staff context should also work with this custom context
    \alias Staff
    % add customizations, they can be anything that can go in 
    % a staff's \with block (these are just examples)
    \consists "Pitch_squash_engraver"
    squashedPosition = #0
    \override NoteHead.style = #'slash
    \override Stem.transparent = ##t
    \override Flag.transparent = ##t
  }
  % define the "parent" contexts that will accept this custom context
  \context { \Score      \accepts MyCustomStaff }
  \context { \ChoirStaff \accepts MyCustomStaff }
  \context { \GrandStaff \accepts MyCustomStaff }
  \context { \PianoStaff \accepts MyCustomStaff }
  \context { \StaffGroup \accepts MyCustomStaff }
}

% DEFINE THE CUSTOM STAFF CONTEXT FOR "MIDI" TOO
% to avoid warnings it has to be defined for each type of desired output 
\midi {
  \context {
    \Staff
    \name MyCustomStaff
    \alias Staff
  }
  % since the customizations are for visual output only,
  % there is no need to include them for midi
  \context { \Score      \accepts MyCustomStaff }
  \context { \ChoirStaff \accepts MyCustomStaff }
  \context { \GrandStaff \accepts MyCustomStaff }
  \context { \PianoStaff \accepts MyCustomStaff }
  \context { \StaffGroup \accepts MyCustomStaff }
}

% EXAMPLE
\score {
  <<
    \new Staff {
      c' d' e' f'
    }
    \new MyCustomStaff {
      c' d' e' f'
    }
  >>
  \layout { }
  \midi { }
}
