%% http://lsr.di.unimi.it/LSR/Item?id=750
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/chords

% correct markup for "b" and "#" (use symbols from current font...)
chordFlat = \markup { \hspace #0.2 \fontsize #-1 \raise #0.3 "b" }
chordSharp = \markup { \hspace #0.1 \fontsize #-1 \raise #0.3 "#" }

% define custom chords
myPopChordsMusic =
{
    <c es ges bes>-\markup { "m" \super { "7/" \chordFlat "5" } }
    <c e g bes dis'>-\markup { \super { "7/" \chordSharp "9" } }
    % ... define all other possible chords here...
}

% Add to existing exceptions
myPopChordsAdd = #(append (sequential-music-to-chord-exceptions myPopChordsMusic #t) ignatzekExceptions)

#(define (conditional-string-downcase str condition)
  (if condition
      (string-downcase str)
      str))
      
% fix accidentals with some Scheme (using the current font's symbols)
#(define (my-chord-name->pop-markup pitch lowercase?)
  (let* ((alt (ly:pitch-alteration pitch)))
  (make-line-markup
    (list
      (make-simple-markup 
       (conditional-string-downcase
        (vector-ref #("C" "D" "E" "F" "G" "A" "B") (ly:pitch-notename pitch))
        lowercase?))
      ;; If it's natural, do nothing
      (if (= alt 0)
        (make-line-markup (list empty-markup))
        (if (= alt FLAT)
          ;; Otherwise, handle adding the flat symbol
          (make-line-markup
            (list
              (make-hspace-markup 0.3)
              (make-small-markup (make-raise-markup 0.7
                (make-text-markup "b")))))
          ;; or handle adding the sharp symbol
          (make-line-markup
            (list
              (make-hspace-markup 0.1)
              (make-small-markup (make-raise-markup 0.7
                (make-text-markup "#")))))))))))

semiGermanChords = {
  \set chordRootNamer = #(chord-name->german-markup #f)
  \set chordNoteNamer = #note-name->german-markup
}

\new Score
{
    \new ChordNames
    {
        % for demonstration purposes, use Arial as font
        % this does not look very nice, but shows the functionality

        \override ChordNames.ChordName.font-name = #"Arial"

        % use our new chord definitions (including the new accidentals)

        \set chordNameExceptions = #myPopChordsAdd

        % use our new markup chord naming functions to get the new accidentals

        \set chordRootNamer = #my-chord-name->pop-markup

        \chordmode { cis1:m7.5-  s1*2 des1:7.9+ }

%        % It's now possible to use some of these commands: 
%        \set chordNameLowercaseMinor = ##t
%        \set chordNoteNamer = #note-name->german-markup
%
%
%        \chordmode { s1*2 cis1:m7.5-/b s1*2 b:7/b s1 des1:7.9+ }
    }
}


% % use like this:
%
% {
%     popChords =
%     {
%         \set chordNameExceptions = #myPopChordsAdd
%         \set chordRootNamer = #my-chord-name->pop-markup
%     }
% }
% 
% % or like this:
%
% \layout
% {
%     \context
%     {
%         \Score
%         chordNameExceptions = #myPopChordsAdd
%         chordRootNamer = #my-chord-name->pop-markup
%     }
% }


