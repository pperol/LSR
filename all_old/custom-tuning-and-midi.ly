%% http://lsr.di.unimi.it/LSR/Item?id=785
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/creating-midi-files.fr.html


% The tempered fifth in quarter-comma meantone is (from any mathematical
  %  music theory reference book) 0.5805 of an octave, which is 696.6 cents
FIFTH = # 5805/10000  % or equivalently, # 6966/12000
  % 31-equal-temperament has
  %  FIFTH = # 18/31
  % 12-equal-temperament has
  %  FIFTH = # 7/12
  % 53-equal-temperament has
  %  FIFTH = # 31/53
  %
  % When you experiment, stay within the range 1/2 < FIFTH < 3/5
  % so that two fifths <c d'> is more than an octave,
  % and five fifths <c b''> is less than three octaves.
  %
#(define fracpart (lambda (x) (- x (floor x))))
#(define tones-from-c (lambda (nfifths) (* 6 (fracpart (* FIFTH nfifths)))))
  %
  % This is a list of pitches, in units of an equal tempered whole tone,
  %  for the notes c d e f g a b, relative to c
scalepitches = #(list->vector (map tones-from-c '(0 2 4 -1 1 3 5)))

  % One may skip the Scheme code and simply enter the pitches in cents.
  % For quarter-comma meantone, these can be found in a book:
  % scalepitches = `#(0 193/200 386/200 503/200 697/200 890/200 1083/200)

#(ly:set-default-scale (ly:make-scale scalepitches))

SHARP = #(tones-from-c 7)
  % Alternatively, for quarter-comma meantone, SHARP = # 76/200
#(define-public FLAT         (* SHARP -1))
#(define-public DOUBLE-SHARP  (* SHARP 2))
#(define-public DOUBLE-FLAT  (* SHARP -2))

  % Reload the note names (c, cis, des, d, etc.) ...
#(ly:load "define-note-names.scm") \language "nederlands"

  % and the table of glyphs for alterations ...
alterationList = #`(
  (,NATURAL . "accidentals.natural")
  (,FLAT . "accidentals.flat")
  (,SHARP . "accidentals.sharp")
  (,DOUBLE-SHARP . "accidentals.doublesharp")
  (,DOUBLE-FLAT . "accidentals.flatflat")
)
  % and the table of alterations in any modes (major, minor, dorian) you use
minor = #`(
  (0 . ,NATURAL)
  (1 . ,NATURAL)
  (2 . ,FLAT)
  (3 . ,NATURAL)
  (4 . ,NATURAL)
  (5 . ,FLAT)
  (6 . ,FLAT)
)
  % so that these tables are indexed to pitches from our tuning.

  % keyAlterationOrder needs to know our pitches to typeset key signatures.
  % Each object that draws accidentals to know the size of our alterations.
\layout{
  \context {
    \Score
  keyAlterationOrder = #`(
    (6 . ,FLAT) (2  . ,FLAT) (5 . ,FLAT) (1  . ,FLAT) (4  . ,FLAT) (0  . ,FLAT) (3  . ,FLAT)
    (3 . ,SHARP) (0 . ,SHARP) (4 . ,SHARP) (1 . ,SHARP) (5 . ,SHARP) (2 . ,SHARP) (6 . ,SHARP)
    (6 . ,DOUBLE-FLAT) (2 . ,DOUBLE-FLAT) (5 . ,DOUBLE-FLAT ) (1 . ,DOUBLE-FLAT) (4 . ,DOUBLE-FLAT) (0 . ,DOUBLE-FLAT) (3 . ,DOUBLE-FLAT)
    (3 . ,DOUBLE-SHARP) (0 . ,DOUBLE-SHARP) (4 . ,DOUBLE-SHARP) (1 . ,DOUBLE-SHARP) (5 . ,DOUBLE-SHARP) (2 . ,DOUBLE-SHARP) (6 . ,DOUBLE-SHARP)
    )
    \override KeySignature.glyph-name-alist = \alterationList
    \override Accidental.glyph-name-alist = \alterationList
    \override AccidentalCautionary.glyph-name-alist = \alterationList
    \override TrillPitchAccidental.glyph-name-alist = \alterationList
    \override AmbitusAccidental.glyph-name-alist = \alterationList
  }
}
  % MIDI implements microtones as a pitch bend, with one bend per channel.
  % These lines below assign one channel to each Voice, in case there are
  % multiple voices on a staff, so that each voice can have its correct
  % pitch bend.
\midi {
  \context {
    \Staff
    \remove "Staff_performer"
    \remove "Key_performer" % avoid midi bug, issue 748
  }
  \context {
    \Voice
    midiInstrument = "drawbar organ"
    \consists "Staff_performer"
  }
  \tempo 4 = 30
}

  % The end of a Chorale from Bach's St Matthew Passion.
  %
  % The original choral music, in B-minor, involves notes such as
  % E-sharp and D-sharp that do not exist on an organ, those keys
  % being tuned to F and E-flat, respectively.
  %
  % Therefore we transpose to D minor to make it playable on the organ.
  %
\score { 
  \new PianoStaff \with { instrumentName = "Organ" } \transpose b d' <<
    \partial 4
    \new Staff \relative c'' {
      \key b\minor
      s1*0^\markup\huge"transposed from St. Matthew Passion, J. S. Bach"
      << {
        d4 | cis  b  e  d8 cis | cis2 b
      } \\ {
        fis4 | e8 fis gis ais b4 b | b ais fis2
      } >>
    }
    \new Staff \relative c' {
      \key b\minor
      s1*0_\markup { \line { $(format "Fifths tempered by ~,1F cents relative to perfect fifth"
      (* (- FIFTH 0.5849625) 1200)) }}
      << {
        \clef bass
        a8 b | cis dis e4 b8 cis d4 | gis, cis dis2
      } \\ {
        fis,8 gis | a4 gis g fis | eis fis b,2
      } >>
    }
  >>
  \layout{}
  \midi{}
}
