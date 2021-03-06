%% http://lsr.di.unimi.it/LSR/Item?id=346
%% see also http://www.lilypond.org/doc/v2.18/Documentation/extending/lilypond-code-blocks

% This file demonstrates how to typeset different pitches with the
% same rhythm.

% It defines a function, defineTransform,
% that you can use to make transformation functions.

% Call it like this:
% myTransformation =
% \defineTransform { c'4 c'8 c'8 d'16 d' d' d' < c' d' > }

% You have now defined a transformation with the name "myTransformation".
% The rhythm in the transformation must be specified with notes c' d' e' f' g'  etc.

% After having defined the transformation, you can call it like this:

% \myTransformation { e gis }
% To insert the rhythm from the transformation,
% where c' is substituted with e and d' is substituted with gis


%%% The following scheme function is just some mumbo-jumbo
%%% That you should add at the top of your program:

defineTransform =
#(define-scheme-function (parser location pattern)
   (ly:music?)
   (define-music-function (parser location pitchseq)
     (ly:music?)
     (let ((pitches (list->vector
                     (reverse!
                      (fold-some-music
                       (lambda (m)
                         (ly:pitch? (ly:music-property m 'pitch)))
                       (lambda (m l)
                         (cons (ly:music-property m 'pitch) l))
                       '()
                       pitchseq))))
           (m (ly:music-deep-copy pattern)))
       (for-some-music
        (lambda (m)
          (let ((p (ly:music-property m 'pitch)))
            (and (ly:pitch? p)
                 (begin
                   (set! (ly:music-property m 'pitch)
                         (vector-ref pitches
                                     (ly:pitch-steps p)))
                   #t))))
        m)
       m)))

%%% To illustrate, here follows the Bach Prelude in C major,
%%% Typeset using defineTransform:

% This is the unabridged version of the whole Prelude.
% If we were to implement it in the documentation, we
% might have to consider commenting about 80% of it. -vv

\include "deutsch.ly"

%%% This defines one measure of the prelude,
%%% using the five notes c' d' e' f' g' instead of the "real" notes:
makePreludeMeasure =
\defineTransform \transpose c c' \repeat unfold 2 {
  <<
    \context Staff = "up" {r8 e16 f g e f g }
    \context Staff = "down" << {r16 d8.~d4 } \\ { c2 } >>
  >>
}

%%% This is the last two measures - defined normally:
ending = <<
  \context Staff = up { s1*2 }
  \context Staff = up { r8 f,16 a, c f c a, \stemUp c \change Staff = down
    a, f, a, f, d, f, d, \change Staff = up \stemNeutral
    r8 g16 h d' f' d' h d' h g h d f e\prall d <e g c'>1^\fermata \bar "|."
  }
  \context Staff = down <<
    \new Voice {
      \stemUp \tieUp r16 c,8.~c,4~c,2 r16 h,,8.~h,,4~h,,2 c,1 \bar "|."
    }
    \new Voice {
      \stemDown \tieDown c,,2~c,, c,,~c,, c,,1_\fermata
    }
  >>
>>


\header {
  title = "Praeludium in C major"
  composer = "J. S. Bach"
}

\score {
  \transpose c c' \context PianoStaff <<
    \new Staff = "up"   { \clef "G" }
    \new Staff = "down" { \clef "F"
      \tempo 4 = 80
      %%% The first measure should use notes c e g c' e' :
      \makePreludeMeasure {c e g c' e' }
      %%% Etc. :
      \makePreludeMeasure {c d a d' f' }
                                %we get the idea now.
                                %comment the following block if the snippet is too long.
     
      \makePreludeMeasure {h, d g d' f' }
      \makePreludeMeasure {c e g c' e' }
     
      \makePreludeMeasure {c e a e' a' }
      \makePreludeMeasure {c d fis a d'  }
      \makePreludeMeasure {h, d g d' g' }
      \makePreludeMeasure {h, c e g c' }
      \makePreludeMeasure {a, c e g c'  }
      \makePreludeMeasure {d, a, d fis c' }
      \makePreludeMeasure {g, h, d g h }
      \makePreludeMeasure {g, b, e g cis'  }
      \makePreludeMeasure {f, a, d a d' }
      \makePreludeMeasure {f, as, d f h }
      \makePreludeMeasure {e, g, c g c' }
      \makePreludeMeasure {e, f, a, c f }
      \makePreludeMeasure {d, f, a, c f }
     
      \makePreludeMeasure {g,, d, g, h, f }
      \makePreludeMeasure {c, e, g, c e }
      \makePreludeMeasure {c, g, b, c e }
      \makePreludeMeasure {f,, f, a, c e  }
      \makePreludeMeasure {fis,, c, a, c es }
      \makePreludeMeasure {as,, f, h, c d }
      \makePreludeMeasure {g,, f, g, h, d }
      \makePreludeMeasure {g,, e, g, c e }
      \makePreludeMeasure {g,, d, g, c f }
      \makePreludeMeasure {g,, d, g, h, f }
      \makePreludeMeasure {g,, es, a, c fis }
      \makePreludeMeasure {g,, e, g, c g }
      \makePreludeMeasure {g,, d, g, c f }
      \makePreludeMeasure {g,, d, g, h, f }
      \makePreludeMeasure {c,, c, g, b, e }
      %%% Finally insert the ending:
      \ending
                                % here ends the block to comment

    }
  >>
 
  \layout {}  
  \midi {}
}
