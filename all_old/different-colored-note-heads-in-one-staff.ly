%% http://lsr.di.unimi.it/LSR/Item?id=199
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/visibility-and-color-of-objects

%% Note head coloring for better readability of brass section
%% ==========================================================

% variables introduced: \NHblue, \NHmagenta, \NHred, \NHreverts 
% and \NHonly (no coloring) 

% example :
%   \new Staff 
%   <<
%     \transpose c b, { \NHblue \TrpImusic } \\
%     \transpose c es, { \NHmagenta \Altomusic } \\
%     \transpose c c' { \NHred \Tbmusic  } \\
%     { \NHreverts \clef treble s1*3 } % Modify for desired clef
%   >>

SBT = {
  \override Voice.Stem.transparent = ##t
  \override Voice.Beam.transparent = ##t
  \override Voice.TupletBracket.transparent = ##t
  \override Voice.TupletNumber.transparent = ##t
}

RS = {
  \override Voice.Rest.transparent = ##t
  \override Voice.MultiMeasureRest.transparent = ##t
  \override Voice.Slur.transparent = ##t
  \override Voice.PhrasingSlur.transparent = ##t
}

NHonly = {
  % Remove everything exept note heads.
  % Add more if needed, but also do the \revert 
  % in NHreverts!
  \SBT
  \RS
}

NHblue = { % top voice
  \override Voice.NoteHead.color = #blue 
  % move rests to their expected positons
  \override Voice.Rest.staff-position = #-0.1 % #0 wont change position; bug?
  \override Voice.MultiMeasureRest.staff-position = #0
}

NHmagenta = { % Copy this and modify for additional colors
  \override Voice.NoteHead.color = #magenta 
  \NHonly
}
  
NHred = { % lowest voice only blanks out rests
  \override Voice.NoteHead.color = #red
  \RS
  \stemDown % should be automatic, but just to be sure!
  \tieDown
}

NHreverts = { 
  \revert Voice.Stem.transparent 
  \revert Voice.Beam.transparent 
  \revert Voice.TupletBracket.transparent 
  \revert Voice.TupletNumber.transparent 
  \revert Voice.Rest.transparent 
  \revert Voice.Rest.staff-position 
  \revert Voice.MultiMeasureRest.transparent
  \revert Voice.Slur.transparent 
  \revert Voice.PhrasingSlur.transparent
  \stemNeutral
}

% {
% All pitches in C
trpmusic = \relative g' {
  \override Voice.NoteHead.color = #blue
  \clef treble
  \key c \major
  | \tuplet 3/2 { g8(\( a a) } b4 ~ b4 c4\) 
  | b c r e
  \bar "|."
}

altomusic = \relative e' {
  \override Voice.NoteHead.color = #magenta
  \clef treble
  \key c \major
  | \tuplet 3/2 { e8(\( f f) } g4 ~ g4 a4\)
  | g a r c
  \bar "|."
}

tbmusic = \relative c' {
  \override Voice.NoteHead.color = #red
  \clef bass
  \key c \major
  | \tuplet 3/2 { c8(\( c d) } d4 e4 ~ e4\)
  | d e r g
  \bar "|."
}
\score { {
  \new StaffGroup
    <<
      \new Staff {
        \set Staff.instrumentName = "Trumpet Bb"
        \set Staff.shortInstrumentName = "trp"
        \transpose bes, c { \trpmusic }
      }
      \new Staff {
        \set Staff.instrumentName = "Alto Sax Eb"
        \set Staff.shortInstrumentName = "asax"
        \transpose es, c { \altomusic }
      }
      \new Staff {
        \set Staff.instrumentName = "Trombone C"
        \set Staff.shortInstrumentName = "tb"
        \tbmusic
      }
      \new Staff  {
        \set Staff.instrumentName = "Brass in C"
        \set Staff.shortInstrumentName = "br"
        <<
          { \NHblue \trpmusic } \\
          { \NHmagenta \altomusic } \\
          \transpose c c { \NHred \tbmusic  } \\ % Transpose for better readability
          { \NHreverts \clef treble } % Modify for desired clef
        >>
      }
    >>
  }
  \layout { 
    ragged-right = ##t
    indent = 20
  }
  % \midi { }
}
% }
