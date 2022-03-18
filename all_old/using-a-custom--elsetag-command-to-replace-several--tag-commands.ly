%% http://lsr.di.unimi.it/LSR/Item?id=381
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/different-editions-from-one-source#using-tags

% improbable name ...
elseTagName = #(gensym)

%% elseTag defines two symbols for property 'tags of the music
elseTag =
#(define-music-function (parser location tag arg)(symbol? ly:music?)
   (set! (ly:music-property arg 'tags)
         (cons tag (cons elseTagName (ly:music-property arg 'tags))))
   arg)

%% this redefinition of keepWithTag verifies that the music has NOT at the same
%% time the symbol "tag" and "elseTagName" (above) in its 'tags property
keepWithTag =
#(define-music-function (parser location tag music) (symbol? ly:music?)
   (music-filter
    (lambda (m)
      (let* ((tags (ly:music-property m 'tags))
             (resA (memq tag tags))
             (resB (memq elseTagName tags)))
        (or (eq? tags '())
            (and (not (equal? resA #f))
                 (equal? resB #f))
            (and (not (equal? resB #f))
                 (equal? resA #f)))))
    music))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

musicOld = \new Staff \relative c' {
  \tag #'any s1*0^\markup "Only with tag"
  \tag #'partD { c1 ~ c ~ c }
  \tag #'any \tag #'partA \tag #'partB \tag #'partC {
    c4 d e
    \tag #'partC { g4 ~ g1 ~ g }
    \tag #'any \tag #'partA \tag #'partB {
      g4 c
      \tag #'partB { d2. ~ d1 }
      \tag #'any \tag #'partA {
        d4
        \tag #'partA { e2 ~ e1 }
        \tag #'any { e4 g c1 }
      }
    }
  }
}

music = \new Staff \relative c' {
  \tag #'any s1*0^\markup "With elseTag"
  \tag #'partD { c1 ~ c ~ c }
  \elseTag #'partD {
    c4 d e
    \tag #'partC { g4 ~ g1 ~g }
    \elseTag #'partC {
      g4 c
      \tag #'partB { d2. ~d1 }
      \elseTag #'partB {
        d4
        \tag #'partA { e2 ~ e1 }
        \elseTag #'partA { e4 g c1 }
      }
    }
  }
}

<<
  \new StaffGroup <<
    \keepWithTag #'any \musicOld
    \keepWithTag #'partA \musicOld
    \keepWithTag #'partB \musicOld
    \keepWithTag #'partC \musicOld
    \keepWithTag #'partD \musicOld
  >>
  \new StaffGroup <<
    \keepWithTag #'any \music
    \keepWithTag #'partA \music
    \keepWithTag #'partB \music
    \keepWithTag #'partC \music
    \keepWithTag #'partD \music
  >>
>>



