%% http://lsr.dsi.unimi.it/LSR/Item?id=651


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Store the following until
%%   %% end of include file
%% as BarNumberStaff-1.0.ily.
%% To use it in your projects, write
%%   \include "<path-to-file/>BarNumberStaff-1.0.ily"
%% to define the BarNumberStaff context described below.
%%
%% Cheers,
%%   Alexander
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BarNumberStaff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Version 1.0
%% 2009, Alexander Kobel (www.a-kobel.de)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Defines the
%%   BarNumberStaff
%% context, to be used as a more prominent measure counter
%% in between of staff groups in large scores.
%%
%% To use it, insert
%%   \new BarNumberStaff { ... }
%% into your score, where { ... } is a combination of
%% MultiMeasureRests, RehearsalMarks and optionally skips and
%% attached TextScripts.
%% Every MultiMeasureRest is translated to the bar number of
%% the current measure, RehearsalMarks and TextScripts are
%% printed as usual.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% This should also work with older versions, probably up
%% to <= 2.10. Please report if this is the case.
%% However, note that Joe Neeman's new vertical spacing
%% algorithm greatly improves the default influence of a
%% BarNumberStaff to the overall score layout, thus version
%% >= 2.13.x is recommended (see lines 213 - 231).
%\version "2.22.0"


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Internals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BarNumberStaves use MultiMeasureRests to render bar numbers.
%% The underlying concept is as follows:
%%
%% A global measure counter is initialized to 0.
%% Conceptually, each time a MultiMeasureRestNumber is rendered, the
%% global measure counter is examined, incremented, and used as 'text.
%% To handle compressed full measure rests, the 'text callback of
%% MultiMeasureRestNumber hijacks the 'measure-count property of the
%% parental MultiMeasureRest to know how many bars have been compressed.
%%
%% To allow several scores per file, or several BarNumberStaves per score,
%% without forcing the user to reset the global counter or initialize
%% several 'text callbacks per BarNumberStaff, the callback further
%% checks the 'when moment of the NonMusicalPaperColumn of the rest,
%% and stores both the moment and the respective bar number in another
%% global variable. If a moment before the cached value is encountered,
%% a new score is assumed and the global state is reset. If the same
%% moment is encountered, another BarNumberStaff calls the bar number
%% at the same position, so the increment of the global measure counter
%% has already been done.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define global-measure-count 0)
#(define measure-at-when (cons (ly:make-moment 0 0) 1))

#(define (bar-number-staff-text-callback grob)
  (let* (
    (parent-rest (ly:grob-parent grob Y))
    (measure-count (ly:grob-property parent-rest 'measure-count))
    (parent-NMPC (ly:grob-parent parent-rest X)) ;; NonMusicalPaperColumn
    (when (ly:grob-property parent-NMPC 'when))
    (moment=? (lambda (a b)
               (let ((diff (ly:moment-sub a b)))
                (and (zero? (ly:moment-main-numerator diff))
                 (zero? (ly:moment-grace-numerator diff))))))
    (start-measure
     (if (ly:moment<? (car measure-at-when) when)
      (1+ global-measure-count)
      (if (moment=? (car measure-at-when) when)
       (cdr measure-at-when)
       1)))
    (end-measure (+ start-measure (1- measure-count)))
  )
   (if (> start-measure end-measure)
    ;; Probably in a partial, but a MultiMeasureRest can't be positioned
    ;; well there. Thus commit suicide.
    (ly:grob-suicide! grob))

   (set! measure-at-when (cons when start-measure))
   (set! global-measure-count end-measure)
   (if (= start-measure end-measure)
    (number->string start-measure)
    (string-append
     (number->string start-measure) " – " (number->string end-measure)))))

#(define (bar-number-staff-plain-stencil grob)
  (let* (
    ;; get text layout properties
    (layout (ly:grob-layout grob))
    (props (ly:grob-alist-chain grob
            (ly:output-def-lookup layout 'text-font-defaults)))
    ;; determine maximum Y-extent of digits
    (target-Y-extent
     (ly:stencil-extent
      (ly:text-interface::interpret-markup layout props (markup "0123456789"))
      Y))
  )
   ;; return the current text, with Y-extent enlarged to include all digits
   ;; centered for better alignment with RehearsalMarks and TextScripts,
   ;; and better fit of box-stencil around them
   (ly:stencil-add
    (ly:make-stencil "" '(0 . 0) target-Y-extent)
    (ly:text-interface::print grob))))

#(define (bar-number-staff-boxed-stencil grob)
  (box-stencil (bar-number-staff-plain-stencil grob) 0.125 0.5))

#(define (bar-number-staff-circled-stencil grob)
  (circle-stencil (bar-number-staff-plain-stencil grob) 0.125 0.5))

\layout {
  \context {
    \type Engraver_group
    \name BarNumberStaff
    \alias Voice
    %% This in conceptually more elegant than \alias Staff,
    %% because Voice is a bottom context.

    \consists Output_property_engraver
    \consists Mark_engraver
    \consists Multi_measure_rest_engraver
    \consists Text_engraver

    \consists Script_row_engraver
    \consists Separating_line_group_engraver
    \consists Font_size_engraver
    \consists Collision_engraver

    \consists Axis_group_engraver

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% MultiMeasureRests are not to be shown themselves,
    %% but serve as a positioning anchor for the
    %% MultiMeasureRestNumbers showing the bar numbers.
    \override MultiMeasureRest.staff-position = #0
    \override MultiMeasureRest.Y-offset = #0
    \override MultiMeasureRest.Y-extent = #'(+inf.0 . -inf.0)
    \override MultiMeasureRest.transparent = ##t

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% The MultiMeasureRestNumbers do the actual work
    %% of showing bar numbers.

    %% Initialize fonts.
    \override MultiMeasureRestNumber.font-encoding = #'latin1
    \override MultiMeasureRestNumber.font-family = #'roman
    \override MultiMeasureRestNumber.font-series = #'bold
    \override MultiMeasureRestNumber.font-shape = #'upright
    \override MultiMeasureRestNumber.font-size = #1

    %% The nasty tweak
    \override MultiMeasureRestNumber.text = #bar-number-staff-text-callback

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Predefined stencils:
    %% - bar-number-staff-plain-stencil
    %% - bar-number-staff-boxed-stencil
    %% - bar-number-staff-circled-stencil
    %%   (use with care; in particular, does not work well with
    %%    \compressEmptyMeasures)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \override MultiMeasureRestNumber.stencil = #bar-number-staff-plain-stencil

    %% Positioning and spacing
    \override MultiMeasureRestNumber.extra-spacing-width = #'(0 . 0)
    \override MultiMeasureRestNumber.Y-offset = #0

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Allow RehearsalMarks and TextScripts to be printed in the
    %% BarNumberStaff.

    \override RehearsalMark.break-align-symbols =
    #(lambda (grob)
      (if (= (ly:item-break-dir grob) 1)
       '(time-signature key-signature staff-bar clef left-edge)
       '(staff-bar)))
    \override RehearsalMark.Y-offset = #0

    markFormatter = #format-mark-box-letters

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% BarNumberStaves are intended to be used between StaffGroups,
    %% where no SpanBar occurs. In case of collisions, either use
    %% a whiteout stencil for the RehearsalMarks, or try
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% \override RehearsalMark.self-alignment-X = #LEFT
    %% \override RehearsalMark.X-offset = #1
    %%
    %% \override RehearsalMark.stencil =
    %% #(lambda (grob) (stencil-whiteout-box (ly:text-interface::print grob)))
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    \override TextScript.Y-offset = #0

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Vertical spacing
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% BarNumberStaves should not disturb the vertical spacing
    %% of a score, thus the defaults are to fit them very tightly
    %% into the score. Your mileage may vary, though - feel free
    %% to adjust the settings as you wish.
    %% Joe Neeman's new vertical spacing algorithm in version 2.13
    %% greatly simplifies a tight positioning of the BarNumberStaff.
    %% No substantial effort has been made to achieve the same
    %% quality in <= 2.12.2.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%    %% version 2.12.2
%
%    \override VerticalAxisGroup.minimum-Y-extent = #'(0 . 0)
%
%    %% requires version 2.13.x
%    \override VerticalAxisGroup.staff-affinity = #CENTER
%    \override VerticalAxisGroup.inter-staff-spacing =
%    #'((space . 5) (padding . 1.5) (minimum-distance . 1.5))
%
%    %% (Updaters note: due to some changes in 2.14.x the following is used)

     \override VerticalAxisGroup.staff-staff-spacing = 
     	#'((basic-distance . 1)
     	   (minimum-distance . 1)
     	   (padding . 3)
     	   (stretchability . 3))
  }

  \context { \Score      \accepts BarNumberStaff }
  \context { \ChoirStaff \accepts BarNumberStaff }
  \context { \GrandStaff \accepts BarNumberStaff }
  \context { \PianoStaff \accepts BarNumberStaff }
  \context { \StaffGroup \accepts BarNumberStaff }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% end of include file
%%
%% example follows:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

marks = {
  \partial 2. s2.
  s1 s1 \mark \default
  s1 s1 \mark \default
  s1*3 \bar "|."
}

music = { \partial 2. c'4 c' c' | \repeat unfold 20 c'4 c'\breve }

\score {
  <<
    \new BarNumberStaff <<
      \marks
      { \compressEmptyMeasures \partial 2. s2. | R1*7 }
    >>

    \new StaffGroup <<
      \new Staff \with { instrumentName = "Tromba" } \music
      \new GrandStaff <<
        \new Staff \with { instrumentName = "Violino I" } \music
        \new Staff \with { instrumentName = "Violino II" } \music
      >>
      \new Staff \with { instrumentName = "Viola" }
      { \clef alto \music }
    >>
    
    \new BarNumberStaff <<
      \marks
      { \compressEmptyMeasures \partial 2. s2. | R1*7 }
    >>
    
    \new ChoirStaff <<
      \new Staff \with { instrumentName = "Soprano" } \music
      \new Staff \with { instrumentName = "Alto" }
      { \clef alto \music }
      \new Staff \with { instrumentName = "Tenore" }
      { \clef tenor \music }
      \new Staff \with { instrumentName = "Basso" }
      { \clef bass \music }
    >>
    
    \new BarNumberStaff {
      \compressEmptyMeasures
      \override TextScript.extra-spacing-width = #'(0 . 0)
      \partial 2. f'''2.^"Notes in BarNumberStaves are silently ignored…"
                        -\markup { \dynamic p " Foo?" }
      | R1 f,,-\markup { \dynamic ff \bold " Bar!" } R
      | r_"…as well as standard rests." R R1*2
    }
    
    \new PianoStaff \with { instrumentName = "Continuo" } <<
      \new Staff \music
      \new Staff { \clef bass \music }
    >>
    \new Staff { \clef bass \music }
  >>

  \layout {
    \context {
      \Score
      \override NonMusicalPaperColumn.line-break-permission = ##f
      \remove Bar_number_engraver
      \remove Mark_engraver
    }
  }
}
