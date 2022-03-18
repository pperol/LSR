%% http://lsr.di.unimi.it/LSR/Item?id=202
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats

%% Definitions for letter-based rehearsalmarks (complete)
%% ------------------------------------------------------
#(define (format-mark-box-letters-segno mark context)
  (markup #:line
    (#:center-column 
      (#:musicglyph "scripts.segno" 
        #:bold #:box (#:markletter (- (ly:context-property context 'rehearsalMark) 2))
        ))))

#(define (format-mark-box-letters-dsegno mark context)
  (markup #:line
    (#:center-column 
      (#:line (#:musicglyph "scripts.segno" #:hspace 0.5 #:musicglyph "scripts.segno")
        #:bold #:box (#:markletter (- (ly:context-property context 'rehearsalMark) 2))
        ))))

#(define (format-mark-box-letters-coda mark context)
  (markup #:line
    (#:center-column 
      (#:fontsize 3 #:musicglyph "scripts.coda" 
        #:bold #:box (#:markletter (- (ly:context-property context 'rehearsalMark) 2))
        ))))

#(define (format-mark-box-letters-dcoda mark context)
  (markup #:line
    (#:center-column 
      (#:line (#:fontsize 3 #:musicglyph "scripts.coda" #:hspace 0.5 #:fontsize 3 #:musicglyph "scripts.coda")
        #:bold #:box (#:markletter (- (ly:context-property context 'rehearsalMark) 2))
        ))))

#(define (format-mark-box-letters-varcoda mark context)
  (markup #:line
    (#:center-column 
      (#:fontsize 3 #:musicglyph "scripts.varcoda" 
        #:bold #:box (#:markletter (- (ly:context-property context 'rehearsalMark) 2))
        ))))

#(define (format-mark-box-letters-dvarcoda mark context)
  (markup #:line
    (#:center-column 
      (#:line (#:fontsize 3 #:musicglyph "scripts.varcoda" #:hspace 0.5 #:fontsize 3 #:musicglyph "scripts.varcoda")
        #:bold #:box (#:markletter (- (ly:context-property context 'rehearsalMark) 2))
        ))))

%% Definitions for alphabet-based rehearsalmarks (segno and coda-marks)
%% --------------------------------------------------------------------
#(define (format-mark-box-alphabet-segno mark context)
  (markup #:line
    (#:center-column 
      (#:musicglyph "scripts.segno" 
        #:bold #:box (#:markalphabet (- (ly:context-property context 'rehearsalMark) 2))
        ))))

#(define (format-mark-box-alphabet-coda mark context)
  (markup #:line
    (#:center-column 
      (#:fontsize 3 #:musicglyph "scripts.coda" 
        #:bold #:box (#:markalphabet (- (ly:context-property context 'rehearsalMark) 2))
        ))))

%% Definitions for barnumber-based rehearsalmarks (segno and coda-marks)
%% ---------------------------------------------------------------------
#(define (format-mark-box-barnumber-segno mark context)
  (markup #:line
    (#:center-column 
      (#:musicglyph "scripts.segno" 
        #:bold #:box (number->string (ly:context-property context 'currentBarNumber))
        ))))

#(define (format-mark-box-barnumber-coda mark context)
  (markup #:line
    (#:center-column 
      (#:fontsize 3 #:musicglyph "scripts.coda" 
        #:bold #:box (number->string (ly:context-property context 'currentBarNumber))
        ))))

%% Definitions for number-based rehearsalmarks (segno and coda-marks)
%% --------------------------------------------------------------------
#(define (format-mark-box-numbers-segno mark context)
  (markup #:line
    (#:center-column 
      (#:musicglyph "scripts.segno" 
        #:bold #:box (number->string (- (ly:context-property context 'rehearsalMark) 1))
        ))))

#(define (format-mark-box-numbers-coda mark context)
  (markup #:line
    (#:center-column 
      (#:fontsize 3 #:musicglyph "scripts.coda" 
        #:bold #:box (number->string (- (ly:context-property context 'rehearsalMark) 1))
        ))))


%% some variables        
%% -----------------
stdMarkFormat = { 
  \set Score.markFormatter = #format-mark-box-letters
}

markDefault = {
  \stdMarkFormat % this resets a possible previous segno/coda-mark
  \mark \default
}

markDefaultSegno = {
  \set Score.markFormatter = #format-mark-box-letters-segno
  \once \override Score.RehearsalMark.baseline-skip = #5
  \mark \default
}

markDefaultDSegno = {
  \set Score.markFormatter = #format-mark-box-letters-dsegno
  \once \override Score.RehearsalMark.baseline-skip = #5
  \mark \default
}

markDefaultCoda = {
  \set Score.markFormatter = #format-mark-box-letters-coda
  \once \override Score.RehearsalMark.baseline-skip = #6
  \mark \default
}

markDefaultDCoda = {
  \set Score.markFormatter = #format-mark-box-letters-dcoda
  \once \override Score.RehearsalMark.baseline-skip = #6
  \mark \default
}

markDefaultVarCoda = {
  \set Score.markFormatter = #format-mark-box-letters-varcoda
  \once \override Score.RehearsalMark.baseline-skip = #6
  \mark \default
}

markDefaultDVarCoda = {
  \set Score.markFormatter = #format-mark-box-letters-dvarcoda
  \once \override Score.RehearsalMark.baseline-skip = #6
  \mark \default
}

\score { {
  \relative c' {
    c d e f 
    \markDefault
    g a b c
    \markDefaultSegno
    c b a g 
    \markDefault
    f e d c
    \markDefaultCoda
    c d e f 
    \markDefault
    g a b c
    \markDefaultVarCoda
    c b a g 
    \markDefault
    f e d c
    \markDefaultDSegno
    c d e f 
    \markDefault
    g a b c
    \markDefaultDCoda
    c b a g 
    \markDefault
    f e d c
    \markDefaultDVarCoda
    c b a g 
    \bar "|." }
  }
  \layout {
    indent = 0\cm
    ragged-right = ##t
  }
}



