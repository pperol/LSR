%% http://lsr.di.unimi.it/LSR/Item?id=482
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-rhythms


% a formatter function, which is simply a wrapper around an existing 
% tuplet formatter function. It takes the value returned by the given
% function and appends a note of given length. 
#(define-public ((tuplet-number::append-note-wrapper function note) grob)
  (let ((txt (function grob)))
    (markup txt #:fontsize -5 #:note note UP)))
  
{
  % Tuplet text of the form:  2:3 quarternote; 
  % "2:3" is produced by tuplet-number::calc-fraction-text, we only append the quarter note
  \override TupletNumber.text = #(tuplet-number::append-note-wrapper tuplet-number::calc-fraction-text "4")
  \tuplet 3/2 {c'4 c' c'}
  \tuplet 3/2 {c' c' c'} 
  % Tuplet text of the form:  12:15 eighthnote, 2:3 eighthnote, etc.
  \override TupletNumber.text = #(tuplet-number::append-note-wrapper tuplet-number::calc-fraction-text "8")
  \tuplet 3/2 {c'8 c' c'}
  \tuplet 6/4 {c'4:8 c'4:8 c'4:8}
  \tuplet 3/2 {c'8 c'8 c'8}
  \tuplet 3/2 {c'4 c' c'}
  \tuplet 12/8 {c':16 c':16 c':16} 
  \break
  % Tuplet text of the form:  2 quarternote
  % We can use the same wrapper function, only that we now use 
  % calc-denominator-text, not the full calc-faction-text
  \override TupletNumber.text = #(tuplet-number::append-note-wrapper tuplet-number::calc-denominator-text "8")
  \tuplet 3/2 {c'8 c' c'}
  \tuplet 6/4 {c'4:8 c'4:8 c'4:8}
  \tuplet 3/2 {c'8 c'8 c'8}
  \tuplet 3/2 {c'4 c' c'}
  \tuplet 120/80 {c' c' c'}
}
