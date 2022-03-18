%% http://lsr.di.unimi.it/LSR/Item?id=752
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/accidental

% If you want pitchnames other than English, change the include.
% For tunings other than 31 note equal temperament, change the "31".
\include "english.ly"
tuning = #31


% Resets LilyPond's "default scale" containing the pitch of each
% unaltered note (the C major scale).
#(define (retune-nominals ET)
   (ly:set-default-scale
    (ly:make-scale (list->vector 
		    (map (lambda (fifths octaves)
			   (* 6
			      (+ (* fifths (best-fifth ET)) octaves)))
			 '(0 2 4 -1 1 3 5) '(0 -1 -2 1 0 -1 -2))))))

% Finds the best size of fifth in the equal temperement with
% the given number of fifths to the octave.
% Note: the effective equal temperament may end up larger.
% For example, ask for 12 and "quartertones" will give you 24.
#(define (best-fifth ET)
   (/ (inexact->exact (round (* ET 0.5849625007))) ET))

% Takes the association of pitch names and returns a
% new copy where each alteration has the correct value
% relative to fifths in the given equal temperament.
#(define (retuned-pitchnames pitchnames ET)
   (map (lambda (pitchname)
	  (let ((pitch (cdr pitchname)))
	    (cons (car pitchname)
		  (ly:make-pitch
		   (ly:pitch-octave pitch)
		   (ly:pitch-notename pitch)
		   (scale-alteration (ly:pitch-alteration pitch) ET)))))
	pitchnames))

% Takes a list mapping alterations to glyphs
% and re-tunes the alterations according to the size of fifth
% in the given equal temperament.
#(define (retune-glyphs glyphs ET)
   (map (lambda (glyph) (cons (scale-alteration (car glyph) ET) (cdr glyph)))
	glyphs))

% Converts an alteration from the initial alteration size
% (that would give 12-equal) to the given equal temperament.
#(define (scale-alteration alteration ET)
   (* 12 alteration (- (* 7 (best-fifth ET)) 4)))

% Set the innards
newglyphs =
#(begin
   (retune-nominals tuning)
   (ly:parser-set-note-names parser (retuned-pitchnames pitchnames tuning))
   (retune-glyphs standard-alteration-glyph-name-alist tuning))

% Apply the new glyphs.
\layout {
  \context {
    \Score
    \override Accidental.glyph-name-alist = \newglyphs
    \override KeySignature.glyph-name-alist = \newglyphs
    \override AccidentalCautionary.glyph-name-alist = \newglyphs
    \override TrillPitchAccidental.glyph-name-alist = \newglyphs
    \override AmbitusAccidental.glyph-name-alist = \newglyphs
  }
}

\score {
  \new Staff \relative c' {
    \set Staff.extraNatural = ##f
    cff4 ctqf cf cqf
    c4 cqs cs df
    dqf4 d dqs ds
    dtqs4 dx e f
    g4 a bf b
    c1
    \transpose c d \relative c' {
      cff4 ctqf cf cqf
      c4 cqs cs df
      dqf4 d dqs ds
      dtqs4 dx e f
      g4 a bf b
      c1
    }
  }
  \layout {}
  \midi {}
}


