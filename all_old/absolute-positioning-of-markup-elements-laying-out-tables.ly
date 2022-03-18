%% http://lsr.di.unimi.it/LSR/Item?id=628
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/text-markup-commands.fr.html

%{
Snippet for overlay markup command - absolute positioning of items

Defines a new markup command \overlay which takes a list of markup elements and positions them all at the same point.
        By translating each markup element, you can gain control of the absolute position of each.
%}

#(define-public (stack-stencil-overlay stencils)
  "Recursive function to add stencils together"
  (if (and (pair? stencils)
           (ly:stencil? (car stencils)))
      
      (if (and (pair? (cdr stencils))
               (ly:stencil? (cadr stencils)))
          (let ((tail (stack-stencil-overlay (cdr stencils)))
                (head (car stencils)))
               (ly:stencil-add head tail))
          (car stencils))
      point-stencil))

#(define-markup-command (overlay layout props args)
  (markup-list?)
  "Overlay arguments one on top of the next"
  (let ((stencils (interpret-markup-list layout props args)))
       (stack-stencil-overlay
         (remove ly:stencil-empty? stencils))))

\markup {
  \overlay {
    \justify-string #"Tabular arrangement of elements"

    \translate #'(20 . -3) \overlay {
      \translate #'(0 . 0) \center-align Ignatzek
      \translate #'(20 . 0) \center-align Alternative
      \translate #'(40 . 0) \center-align Diagram

      \translate #'(0 . -8) \center-align C
      \translate #'(20 . -8) \center-align C
      \translate #'(40 . -10) \fret-diagram #"6-x;5-3-3;4-2-2;3-o;2-1-1;1-o;"

      \translate #'(0 . -18) \center-align Cm
      \translate #'(20 . -18) \center-align  \concat { C \super { \flat 5 } }
      \translate #'(40 . -20) \fret-diagram #"6-x;5-1-1;4-3-3;3-3-4;2-2-2;1-1-1;c:5-1-1;"

      \translate #'(0 . -28) \center-align C+
      \translate #'(20 . -28) \center-align \concat { C \super { \sharp 5 } }
      \translate #'(40 . -30) \fret-diagram #"6-x;5-x;4-2-2;3-1-1;2-1-1;1-4-4;c:2-3-1;"
    }
  }
}

\markup \null

\markup {
  \overlay {
    \translate #'(0 . 7)
    \justify-string #"Musical notation with each element placed by hand"

    \translate #'(0 . -3) \fontsize #2 "1"
    \postscript #"
      0.15 setlinewidth
      4  0 moveto 74  0 lineto stroke
      4 -1 moveto 74 -1 lineto stroke
      4 -2 moveto 74 -2 lineto stroke
      4 -3 moveto 74 -3 lineto stroke
      4 -4 moveto 74 -4 lineto stroke

      11.6 -5 moveto 13.6 -5 lineto stroke
      42.6 -5 moveto 44.6 -5 lineto stroke

      17.6 -5 moveto 0 0 2 -1 7 -1 9 0 rcurveto stroke
      48.6 -5 moveto 0 0 2 -1 7 -1 9 0 rcurveto stroke

      0.3 setlinewidth
      73.85 0 moveto 73.85 -4 lineto stroke
      "
    \translate #'(4 . 2) "Präludium"

    \translate #'(5 . -3)   \musicglyph #"clefs.G_change"
    \translate #'(8 . -2) \musicglyph #"timesig.C44"

    \translate #'(12 . -5) \note-by-number #1 #0 #DOWN
    \translate #'(12 . -2) \musicglyph #"rests.4"
    \translate #'(12 . 0) \musicglyph #"rests.3"

    \translate #'(16 . -4) \note-by-number #3 #0 #DOWN
    \translate #'(17.4 . -4.4) \musicglyph #"dots.dot"

    \translate #'(19 . -3) \note-by-number #2 #0 #UP
    \translate #'(23 . -1.5) \note-by-number #2 #0 #1.2
    \translate #'(20.25 . 0) \beam #4 #0.5 #0.40
    \translate #'(20.25 . -1) \beam #4 #0.5 #0.40

    \translate #'(27 . -4) \note-by-number #2 #0 #DOWN

    \translate #'(27 . -0.5) \note-by-number #2 #0 #UP
    \translate #'(31 . -3) \note-by-number #2 #0 #1.7
    \translate #'(35 . -1.5) \note-by-number #2 #0 #1.3
    \translate #'(39 . -0.5) \note-by-number #2 #0 #UP

    \translate #'(28.25 . 2.25) \beam #12 #0 #0.4
    \translate #'(28.25 . 1.35) \beam #12 #0 #0.4

    \translate #'(43 . -5) \note-by-number #1 #0 #DOWN
    \translate #'(43 . -2) \musicglyph #"rests.4"
    \translate #'(43 . 0) \musicglyph #"rests.3"

    \translate #'(47 . -4) \note-by-number #3 #0 #DOWN
    \translate #'(48.4 . -4.4) \musicglyph #"dots.dot"

    \translate #'(50 . -3) \note-by-number #2 #0 #UP
    \translate #'(54 . -1.5) \note-by-number #2 #0 #1.2

    \translate #'(51.25 . 0) \beam #4 #0.5 #0.40
    \translate #'(51.25 . -1) \beam #4 #0.5 #0.40

    \translate #'(58 . -4) \note-by-number #2 #0 #DOWN

    \translate #'(58 . -0.5) \note-by-number #2 #0 #UP
    \translate #'(62 . -3) \note-by-number #2 #0 #1.7
    \translate #'(66 . -1.5) \note-by-number #2 #0 #1.3
    \translate #'(70 . -0.5) \note-by-number #2 #0 #UP

    \translate #'(59.25 . 2.25) \beam #12 #0 #0.40
    \translate #'(59.25 . 1.35) \beam #12 #0 #0.40
  }
}
