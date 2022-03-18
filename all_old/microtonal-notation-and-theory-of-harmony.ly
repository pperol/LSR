%% http://lsr.dsi.unimi.it/LSR/Item?id=786
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/pitch-and-harmony-in-contemporary-music.html#microtonal-notation
%% see also http://www.ekmelic-music.org/en/ekmelily.htm

% The pitches for the scale are specified in terms of equal-tempered
  %  whole tones.
  % Transposition, key signatures, transposition, and
  %  MIDI output will use these pitches.
  % A perfect fifth is 701.955 'cents' where a cent is 1/200 of an
  %  equal-tempered whole tone.  LilyPond uses rational numbers for
  %  pitches, so we use 702/200 whole tones for the fifth.
  % Building the scale starting on C,
  %  G is a perfect fifth higher at 702/200, D is another fifth higher
  %  at 1404/200 so the pitch within the first octave is 204/200, etc.
  % (You can write a Scheme code to generate the series if you prefer.)
scalepitches = #`#(0/200 204/200 408/200 498/200 702/200 906/200 1110/200)
#(ly:set-default-scale (ly:make-scale scalepitches))

  % Seven perfect fifths (4914 cents) above C, is a C-sharp.
  % Lowered to the first octave this is 114 cents.
SHARP = #114/200

#(define-public FLAT         (* SHARP -1))
#(define-public DOUBLE-SHARP (* SHARP 2))
#(define-public DOUBLE-FLAT  (* FLAT 2))

  % The pitch E built from perfect fifths is 408 cents above C,
  %  but a perfect major third is 386 cents.
  % The notes in perfect thirds use arrows on accidentals
  %  to represent adjustment by this 22-cent difference.
  
ARROW = #22/200
#(define-public SHARP-RAISE   (+ SHARP ARROW))
#(define-public SHARP-LOWER   (- SHARP ARROW))  % 92/200
#(define-public NATURAL-RAISE (+ NATURAL ARROW))
#(define-public NATURAL-LOWER (- NATURAL ARROW))
#(define-public FLAT-RAISE    (+ FLAT ARROW))
#(define-public FLAT-LOWER    (- FLAT ARROW))

  % Note names can now be defined to represent these pitches in our
  % Lilypond input.  We extend the list of Dutch note names:
  
arrowedPitchNames = #`(
       (ceses . ,(ly:make-pitch -1 0 DOUBLE-FLAT))
       (ceseh . ,(ly:make-pitch -1 0 FLAT-LOWER))
       (ces   . ,(ly:make-pitch -1 0 FLAT))
       (cesih . ,(ly:make-pitch -1 0 FLAT-RAISE))
       (ceh   . ,(ly:make-pitch -1 0 NATURAL-LOWER))
       (c     . ,(ly:make-pitch -1 0 NATURAL))
       (cih   . ,(ly:make-pitch -1 0 NATURAL-RAISE))
       (ciseh . ,(ly:make-pitch -1 0 SHARP-LOWER))
       (cis   . ,(ly:make-pitch -1 0 SHARP))
       (cisih . ,(ly:make-pitch -1 0 SHARP-RAISE))
       (cisis . ,(ly:make-pitch -1 0 DOUBLE-SHARP))

       (deses . ,(ly:make-pitch -1 1 DOUBLE-FLAT))
       (deseh . ,(ly:make-pitch -1 1 FLAT-LOWER))
       (des   . ,(ly:make-pitch -1 1 FLAT))
       (desih . ,(ly:make-pitch -1 1 FLAT-RAISE))
       (deh   . ,(ly:make-pitch -1 1 NATURAL-LOWER))
       (d     . ,(ly:make-pitch -1 1 NATURAL))
       (dih   . ,(ly:make-pitch -1 1 NATURAL-RAISE))
       (diseh . ,(ly:make-pitch -1 1 SHARP-LOWER))
       (dis   . ,(ly:make-pitch -1 1 SHARP))
       (disih . ,(ly:make-pitch -1 1 SHARP-RAISE))
       (disis . ,(ly:make-pitch -1 1 DOUBLE-SHARP))

       (eeses . ,(ly:make-pitch -1 2 DOUBLE-FLAT))
       (eses  . ,(ly:make-pitch -1 2 DOUBLE-FLAT))
       (eeseh . ,(ly:make-pitch -1 2 FLAT-LOWER))
       (eseh  . ,(ly:make-pitch -1 2 FLAT-LOWER))
       (ees   . ,(ly:make-pitch -1 2 FLAT))
       (es    . ,(ly:make-pitch -1 2 FLAT))
       (eesih . ,(ly:make-pitch -1 2 FLAT-RAISE))
       (esih  . ,(ly:make-pitch -1 2 FLAT-RAISE))
       (eeh   . ,(ly:make-pitch -1 2 NATURAL-LOWER))
       (e     . ,(ly:make-pitch -1 2 NATURAL))
       (eih   . ,(ly:make-pitch -1 2 NATURAL-RAISE))
       (eiseh . ,(ly:make-pitch -1 2 SHARP-LOWER))
       (eis   . ,(ly:make-pitch -1 2 SHARP))
       (eisih . ,(ly:make-pitch -1 2 SHARP-RAISE))
       (eisis . ,(ly:make-pitch -1 2 DOUBLE-SHARP))

       (feses . ,(ly:make-pitch -1 3 DOUBLE-FLAT))
       (feseh . ,(ly:make-pitch -1 3 FLAT-LOWER))
       (fes   . ,(ly:make-pitch -1 3 FLAT))
       (fesih . ,(ly:make-pitch -1 3 FLAT-RAISE))
       (feh   . ,(ly:make-pitch -1 3 NATURAL-LOWER))
       (f     . ,(ly:make-pitch -1 3 NATURAL))
       (fih   . ,(ly:make-pitch -1 3 NATURAL-RAISE))
       (fiseh . ,(ly:make-pitch -1 3 SHARP-LOWER))
       (fis   . ,(ly:make-pitch -1 3 SHARP))
       (fisih . ,(ly:make-pitch -1 3 SHARP-RAISE))
       (fisis . ,(ly:make-pitch -1 3 DOUBLE-SHARP))

       (geses . ,(ly:make-pitch -1 4 DOUBLE-FLAT))
       (geseh . ,(ly:make-pitch -1 4 FLAT-LOWER))
       (ges   . ,(ly:make-pitch -1 4 FLAT))
       (gesih . ,(ly:make-pitch -1 4 FLAT-RAISE))
       (geh   . ,(ly:make-pitch -1 4 NATURAL-LOWER))
       (g     . ,(ly:make-pitch -1 4 NATURAL))
       (gih   . ,(ly:make-pitch -1 4 NATURAL-RAISE))
       (giseh . ,(ly:make-pitch -1 4 SHARP-LOWER))
       (gis   . ,(ly:make-pitch -1 4 SHARP))
       (gisih . ,(ly:make-pitch -1 4 SHARP-RAISE))
       (gisis . ,(ly:make-pitch -1 4 DOUBLE-SHARP))

       (aeses . ,(ly:make-pitch -1 5 DOUBLE-FLAT))
       (ases  . ,(ly:make-pitch -1 5 DOUBLE-FLAT))
       (aeseh . ,(ly:make-pitch -1 5 FLAT-LOWER))
       (aseh  . ,(ly:make-pitch -1 5 FLAT-LOWER))
       (aes   . ,(ly:make-pitch -1 5 FLAT))
       (as    . ,(ly:make-pitch -1 5 FLAT))
       (aesih . ,(ly:make-pitch -1 5 FLAT-RAISE))
       (asih  . ,(ly:make-pitch -1 5 FLAT-RAISE))
       (aeh   . ,(ly:make-pitch -1 5 NATURAL-LOWER))
       (a     . ,(ly:make-pitch -1 5 NATURAL))
       (aih   . ,(ly:make-pitch -1 5 NATURAL-RAISE))
       (aiseh . ,(ly:make-pitch -1 5 SHARP-LOWER))
       (ais   . ,(ly:make-pitch -1 5 SHARP))
       (aisih . ,(ly:make-pitch -1 5 SHARP-RAISE))
       (aisis . ,(ly:make-pitch -1 5 DOUBLE-SHARP))

       (beses . ,(ly:make-pitch -1 6 DOUBLE-FLAT))
       (beseh . ,(ly:make-pitch -1 6 FLAT-LOWER))
       (bes   . ,(ly:make-pitch -1 6 FLAT))
       (besih . ,(ly:make-pitch -1 6 FLAT-RAISE))
       (beh   . ,(ly:make-pitch -1 6 NATURAL-LOWER))
       (b     . ,(ly:make-pitch -1 6 NATURAL))
       (bih   . ,(ly:make-pitch -1 6 NATURAL-RAISE))
       (biseh . ,(ly:make-pitch -1 6 SHARP-LOWER))
       (bis   . ,(ly:make-pitch -1 6 SHARP))
       (bisih . ,(ly:make-pitch -1 6 SHARP-RAISE))
       (bisis . ,(ly:make-pitch -1 6 DOUBLE-SHARP))
       )
pitchnames = \arrowedPitchNames
#(ly:parser-set-note-names parser pitchnames)

  % The symbols for each alteration
  
arrowGlyphs = #`(
        (,DOUBLE-SHARP . "accidentals.doublesharp")
        (,SHARP-RAISE  . "accidentals.sharp.arrowup")
        (,SHARP        . "accidentals.sharp")
        (,SHARP-LOWER  . "accidentals.sharp.arrowdown")
        (,NATURAL-RAISE . "accidentals.natural.arrowup")
        (  0            . "accidentals.natural")
        (,NATURAL-LOWER . "accidentals.natural.arrowdown")
        (,FLAT-RAISE   . "accidentals.flat.arrowup")
        (,FLAT         . "accidentals.flat")
        (,FLAT-LOWER   . "accidentals.flat.arrowdown")
        (,DOUBLE-FLAT  . "accidentals.flatflat")
)

  % If the major scale is built from the tonic, dominant, and subdominant
  %  major chords, then the major scale involves arrowed accidentals.
  % Defining the pitches in the major mode allows us to use it for
  %  key signatures.
  
justMajor = #`(
    (0 . ,NATURAL)
    (1 . ,NATURAL)
    (2 . ,NATURAL-LOWER)
    (3 . ,NATURAL)
    (4 . ,NATURAL)
    (5 . ,NATURAL-LOWER)
    (6 . ,NATURAL-LOWER)
)
justMinor = #`(
    (0 . ,NATURAL)
    (1 . ,NATURAL)
    (2 . ,FLAT-RAISE)
    (3 . ,NATURAL)
    (4 . ,NATURAL)
    (5 . ,FLAT-RAISE)
    (6 . ,FLAT-RAISE)
)

  % keyAlterationOrder needs to know our pitches to typeset key signatures.
  % Each object that draws accidentals needs to know our glyphs.
  
\layout {
  \context {
    \Score
  keyAlterationOrder = #`(
    (6 . ,FLAT) (2 . ,FLAT) (5 . ,FLAT) (1 . ,FLAT) (4 . ,FLAT) (0 . ,FLAT) (3 . ,FLAT)
    (3 . ,SHARP) (0 . ,SHARP) (4 . ,SHARP) (1 . ,SHARP) (5 . ,SHARP) (2 . ,SHARP) (6 . ,SHARP)
    (6 . ,FLAT-RAISE) (2 . ,FLAT-RAISE) (5 . ,FLAT-RAISE) (1 . ,FLAT-RAISE) (4 . ,FLAT-RAISE) (0 . ,FLAT-RAISE) (3 . ,FLAT-RAISE)
    (3 . ,SHARP-LOWER) (0 . ,SHARP-LOWER) (4 . ,SHARP-LOWER) (1 . ,SHARP-LOWER) (5 . ,SHARP-LOWER) (2 . ,SHARP-LOWER) (6 . ,SHARP-LOWER) (6 . ,SHARP-RAISE)
    (3 . ,NATURAL-RAISE) (0 . ,NATURAL-RAISE) (4 . ,NATURAL-RAISE) (1 . ,NATURAL-RAISE) (5 . ,NATURAL-RAISE) (2 . ,NATURAL-RAISE) (6 . ,NATURAL-RAISE)
    (6 . ,NATURAL-LOWER) (2 . ,NATURAL-LOWER) (5 . ,NATURAL-LOWER) (1 . ,NATURAL-LOWER) (4 . ,NATURAL-LOWER) (0 . ,NATURAL-LOWER) (3 . ,NATURAL-LOWER)
    )
    \override KeySignature.glyph-name-alist = \arrowGlyphs
    \override KeySignature.padding-pairs = #'(
    (("accidentals.natural.arrowdown" . "accidentals.natural.arrowdown") . 0.5)
    (("accidentals.natural.arrowdown" . "accidentals.sharp.arrowdown") . 0.2)
    (("accidentals.natural.arrowdown" . "accidentals.flat.arrowdown") . 0.7)
    (("accidentals.natural.arrowup" . "accidentals.natural.arrowup") . 0.5)
    (("accidentals.natural.arrowup" . "accidentals.sharp.arrowup") . 0.2)
    (("accidentals.natural.arrowup" . "accidentals.flat.arrowup") . 0.7)
    (("accidentals.flat.arrowup" . "accidentals.flat.arrowup") . 0.3))
    \override Accidental.glyph-name-alist = \arrowGlyphs
    \override AccidentalCautionary.glyph-name-alist = \arrowGlyphs
    \override TrillPitchAccidental.glyph-name-alist = \arrowGlyphs
    \override AmbitusAccidental.glyph-name-alist = \arrowGlyphs
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
    %midiInstrument = "pad 4 (choir)"
    midiInstrument = "drawbar organ"
    \consists "Staff_performer"
  }
  \tempo 4 = 30
}

\score { <<
  \new Staff \with {
    instrumentName = \markup\center-column {"Sopr." "Alto"}
  } \relative c'' {
    \key b\justMinor
    s1*0^\markup\huge"from St. Matthew Passion, J. S. Bach"
    % Was mein Gott will, das gescheh allzeit
    << {
      \accidentalStyle Score.modern
      \partial 4
      dih4 | ciseh b e dih8 cis | cis2 b
    } \\ {
      fis4 | e8 fis giseh aiseh b4 b | b aiseh fis2
    } >>
  }
  \new Staff \with {
    instrumentName = \markup\center-column {"Tenor" "Bass"}
  } \relative c' {
    \key b\justMinor
    << {
      \clef "treble_8"
       aih8 b | ciseh diseh e4 b8 ciseh%{Ellis has cis%} dih4 | gis, cis diseh2
    } \\ {
      fis,8 giseh | a4 giseh gih fis | eiseh fis b,2
    } >>
  }
  >>
  \layout{}
  \midi{}
}
