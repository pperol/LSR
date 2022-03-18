%% http://lsr.di.unimi.it/LSR/Item?id=619
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/changing-context-default-settings.fr.html


%LSR originally contributed by Graham Breed for version "2.11.65"

% Dodecaphonic notation, after Erv Wilson, but probably an earlier idea.

\include "english.ly"

% set the nominals to be 12-equal
#(ly:set-default-scale (ly:make-scale '#(0 1/2 1 3/2 2 5/2 3 7/2 4 9/2 5 11/2)))

% Set the pitches to 12-equal with enharmonic equivalences
% keep the original pitch names.
% Preserves quartertones as half-sharps.
dodecaPitchNames = #(map (lambda (pitchname)
             (let* (
                     (pitch (cdr pitchname))
                     (nominal-steps (vector-ref '#(0 2 4 5 7 9 11)
                                 (ly:pitch-notename pitch)))
                     (fractional-steps
                         (+ nominal-steps (* 2 (ly:pitch-alteration pitch))))
                     (steps (inexact->exact (floor fractional-steps)))
                    )
                 (cons (car pitchname)
                     (ly:make-pitch
                         (ly:pitch-octave pitch)
                         steps
                         (/ (- fractional-steps steps) 2)))))
         pitchnames)

#(ly:parser-set-note-names parser dodecaPitchNames)

\layout {
  \context {
    \Score
    \override StaffSymbol.line-positions = #'(-5 -3 0 2 4)
    % hack to suppress ledger line, seems to have a lower limit
    \override StaffSymbol.ledger-line-thickness = #'(0.0006 . 0)
  }
}
\score{
  \new Staff
    \relative c' {
    c d e f 
    g a b c
    c, cs d ds 
    e f fs g 
    gs a as b 
    c1
    c4 b bf a 
    af g gf f 
    e ef d df 
    c1
    c4 cqs cs dqf 
    d dqs ds eqf 
    e eqs f fqs 
    fs gqf g gqs 
    gs aqf a aqs 
    as bqf b bqs 
    c1
  }
}
