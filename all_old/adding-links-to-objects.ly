%% http://lsr.di.unimi.it/LSR/Item?id=865
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides#tweaks-and-overrides-adding-links-to-objects

% Code by Thomas Morley
% Contributed by harm6
% Tested with 2.14.2 up to 2.17.9

#(define (add-link url-strg)
  (lambda (grob)
    (let* ((stil (ly:grob-property grob 'stencil)))
      (if (ly:stencil? stil)
        (begin
          (let* (
             (x-ext (ly:stencil-extent stil X))
             (y-ext (ly:stencil-extent stil Y))
             (url-expr (list 'url-link url-strg `(quote ,x-ext) `(quote ,y-ext)))
             (new-stil (ly:stencil-add (ly:make-stencil url-expr x-ext y-ext) stil)))
          (ly:grob-set-property! grob 'stencil new-stil)))
        #f))))
        
%%%% test

urlI = 
"http://lilypond.org/doc/v2.14/Documentation/notation/writing-pitches"
        
urlII = 
"http://lilypond.org/doc/v2.14/Documentation/notation/rhythms"

urlIII = 
"http://lilypond.org/doc/v2.14/Documentation/notation/note-heads"

urlIV =
"http://lilypond.org/doc/v2.14/Documentation/notation/beams"

urlV =
"http://lilypond.org/doc/v2.14/Documentation/notation/note-head-styles"
      
\relative c' {
  \key cis \minor
        
  \once \override Staff.Clef.color = #green
  \once \override Staff.Clef.after-line-breaking =
    #(add-link urlI)
    
  \once \override Staff.TimeSignature.color = #green
  \once \override Staff.TimeSignature.after-line-breaking = 
    #(add-link urlII)
    
  \once \override NoteHead.color = #green
  \once \override NoteHead.after-line-breaking =
    #(add-link urlIII)
    
  cis'1
  \once \override Beam.color = #green
  \once \override Beam.after-line-breaking =
    #(add-link urlIV)
  cis8 dis e fis gis2
  <gis, 
   % With 2.17.9 you could use the command below to address the Accidental.
   % \tweak Accidental.before-line-breaking #(add-link url)
   \tweak color #green
   \tweak after-line-breaking #(add-link urlV) 
   \tweak style #'harmonic
   bis 
   dis  
   fis
  >1
  <cis, cis' e>
}
