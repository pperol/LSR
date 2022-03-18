%% http://lsr.di.unimi.it/LSR/Item?id=198
%% see also http://lsr.di.unimi.it/LSR/Item?id=190
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats#repeats-positioning-segno-and-coda-_0028with-line-break_0029
%% modified by P.P.Schneider on Feb. 2014

%%% Usage:
%%% ------
%%%   \theSegnoRMark 
%%%   \toCodaRMark 
%%%   \codaNoNewLine \toSegnoRMark \DSMarkup
%%%   \theCodaRMark 
%%%
%%% Example:
%%% --------
%%% { c d e f \segnoRMark
%%%   f d e c \toCodaRMark 
%%%   c c e d \codaNoNewLine \toSegnoRMark \DSMarkup
%%%   \bar "||"
%%%   \theCodaRMark
%%%   c d e f 
%%%   \bar "|." }

%%% Predefined options
%%% ------------------
%%% 1. "The-Coda-On-New-Line Layout" (\theCodaRMark)
%%% 1.1 Position of "The Coda"-Markup (\theCodaRMarkOnNewLine )
%%% 2. "The-Coda-No-New-Line Layout" (\theCodaRMark)


%%% Definitions
%%% ===========
%% Glyphs
%% ------
theSegnoGlyph = \markup { \musicglyph #"scripts.segno" }
toSegnoGlyph = \theSegnoGlyph
toCodaGlyph = \markup { \musicglyph #"scripts.coda" }
theCodaGlyph = \toCodaGlyph 

%% some general shorthand commands
%% -------------------------------
padSegno = { 
  \once \override Score.RehearsalMark.padding = #'2 
} 
showClefKey = {
  \once \override Staff.KeySignature.break-visibility = #all-visible
  \once \override Staff.Clef.break-visibility = #all-visible
}
blankClefKey = {
  \once \override Staff.KeySignature.break-visibility = #all-invisible
  \once \override Staff.Clef.break-visibility = #all-invisible
}

%% segno-coda-markup related shorthands
%% ----------------------------
theSegnoRMark = {
  \padSegno % Pad away from key-accidentals 
  \mark \markup { \theSegnoGlyph }
}
toCodaRMark = {
  \padSegno % keep "To Coda" on same level as Segno
  \once \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
  \once \override Score.RehearsalMark.font-size = #4 % Enlarge Coda-Sign
  \mark \markup { \toCodaGlyph }
}
toSegnoRMark = {
  \padSegno % keep "To Segno" on same level as "The Segno" and "To Coda"
  \once \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
  \mark \markup { \toSegnoGlyph }
  \cadenzaOn % \stopStaff removes the staff lines (and creates some annoyances related to grob positioning, too)
  \stopStaff % \cadenzaOn will suppress the bar count and
}

%% Textual "dal segno" shorthands 
%% ------------------------------
DSCodaTextLine = { % choice one
  \once \override TextScript.extra-offset = #'( 2 . -3.5 )
  <>^\markup { D.S. al Coda }
}
DSCodaTextCenter = { % choice two
  \once \override TextScript.extra-offset = #'( 6 . -5.0 )
  <>^\markup { \center-column { D.S. "al Coda" } }
}
DSCodaTextSymbolCenter = { % choice three
  % 'padding or 'staff-padding won't accept negative values in 2.9.10,
  % so I had to use 'extra-offset instead of X-offset and one of the above
  % \once \override TextScript.baseline-skip = #0
  \repeat unfold 1 { % Adjust unfold counter to manipulate indentation
    s1
    \noBreak
    \bar ""
  }
  \once \override TextScript.extra-offset = #'( 0 . -4.0 )
  \once \override TextScript.word-space = #1.5 
  <>^\markup { 
          \center-column { 
            "D.S. al Coda" 
            \line { % some kerning
              \halign #0 \musicglyph #"scripts.coda" 
              \halign #0.7 \musicglyph #"scripts.tenuto" 
              \halign #0 \musicglyph #"scripts.coda" }
          } }
}

%% "The Coda" related markup shorthands
%% ------------------------------------
theCodaRMarkSize = { % Make "the Coda" RehearsalMark easy to spot!
  \once \override Score.RehearsalMark.font-size = #6 
}

theCodaMiddleLeft = { % Choice 1 of The-Coda-On-New-Line Layout
  \theCodaRMarkSize
  % \once \override Score.RehearsalMark.staff-padding = #-4.75 % can't use staff-padding (due to removerd staff?) - must use 'extra-offset
  % \once \override Score.RehearsalMark.X-offset = #-4.5 % produces error - \stopStaff-related? - must use 'extra-offset
  \once \override Score.RehearsalMark.extra-offset = #'( -1 . -10.65 ) % -10.65: volta bracket present
  \mark \markup { \theCodaGlyph }
}

theCodaTopLeft = { % Choice 2 of The-Coda-On-New-Line Layout
  \theCodaRMarkSize
  % \once \override Score.RehearsalMark.staff-padding = #3 % can't use - see above
  % \once \override Score.RehearsalMark.X-offset = #5 % can't use - see above
  \once \override Score.RehearsalMark.extra-offset = #'( 3.2 . 0 ) % Adjust to your layout
  \mark \markup { \theCodaGlyph }
}

theCodaRMarkNoNewLine = { % The-Coda-No-New-Line Layout
  % \once \override Score.RehearsalMark.X-offset = #1.75
  \once \override Score.RehearsalMark.padding = #2
  \once \override Score.RehearsalMark.break-align-symbols = #'(clef)
  \theCodaRMarkSize
  \mark \markup { \theCodaGlyph }
}

%% "The-Coda-On-New-Line": define position of "The Coda"-Markup
%% choices: \theCodaMiddleLeft or \theCodaTopLeft
%% ------------------------------------------------------------
theCodaRMarkOnNewLine = 
  \theCodaMiddleLeft  
  
%% "The-Coda-No-New-Line" Layout: space between "toSegno" and "theCoda"
%% --------------------------------------------------------------------
spacerNoNewLine = { % Increase unfold counter to adjust space 
  \repeat unfold 3 {
    s1
    \noBreak
    \bar ""
  }
}
%% "The-Coda-On-New-Line" Layout: space between "toSegno" and right margin
%% -----------------------------------------------------------------------
spacerWithNewLine = { % Increase unfold counter to adjust space
  \repeat unfold 5 {
    s1
    \noBreak
    \bar ""
  }
}
%% shared Variable for both Layouts
%% --------------------------------
resumeStaff = {
  \set Timing.measureLength = #(ly:make-moment 1/32)
  s32 % Add a wee bit of staff before the clef!
  \unset Timing.measureLength
  \bar ""
  \cadenzaOff \startStaff % Resume bar count and show staff lines again
}
%% "The-Coda-On-New-Line" Layout: With indent 
%% ------------------------------------------
doIndentTheCoda = {
  \blankClefKey
  \repeat unfold 1 { % Adjust unfold counter to manipulate indentation
    s1
    \noBreak
    \bar ""
  }
  \theCodaRMarkOnNewLine  
  \partial 64 s64
  \noBreak
  \bar ""
  \resumeStaff
  \showClefKey
}
%% "The-Coda-On-New-Line" Layout: WithOUT indent 
%% ---------------------------------------------
dontIndentTheCoda = {
  \startStaff \cadenzaOff  % Resume bar count and show staff lines again
  \theCodaRMarkOnNewLine
}

codaNoNewLine = { } % merely to avoid error message

%%% The Coda layout: uncomment only ONE set of the following 
%%% ========================================================
%% Choice One: The Coda NOT on a new line 
%% (a.k.a. "The-Coda-No-New-Line Layout")
%% --------------------------------------
% { !!Active!!
codaNoNewLine = { \noBreak }
theCodaRMark = { 
  \spacerNoNewLine
  \resumeStaff
  \showClefKey % Show up, you clef and key!
  \theCodaRMarkNoNewLine
}
% } % !!Active!!

%% Choice Two: The Coda INDEED on a new line 
%% (a.k.a. "The-Coda-On-New-Line Layout")
%% -----------------------------------------
%{ !!Off!!
theCodaRMark = { 
  \spacerWithNewLine
  \break % This is the New line!
  \doIndentTheCoda % use \doIndentTheCoda or \dontIndentTheCoda to your liking
} 
%} % !!Off!!

%%% Markup for textual D.S. display
%%% Choices are: \DSCodaTextCenter \DSCodaTextLine \DSCodaTextSymbolCenter 
%%% ======================================================================
DSMarkup = \DSCodaTextSymbolCenter

{ 
  \clef treble
  \key g \major
  \time 4/4
  % \override Score.BarNumber.break-visibility = #all-visible
  \relative c'' {
    \repeat unfold 5 { c4 c c c }
    \theSegnoRMark % Set segno sign as rehearsal mark 
    
    \repeat unfold 2 { c4 c c c }
    \toCodaRMark % Set coda sign as rehearsal mark 
    
    \repeat unfold 2 { c4 c c c }
    \codaNoNewLine % Forbid line-break, if forthcoming Coda shouldn't be on new line
    \bar "||"
    
    \toSegnoRMark % Set segno sign as rehearsal mark 
    \DSMarkup % Textual display of "dal Segno"
    
    % The coda
    \theCodaRMark % Set coda sign as rehearsal mark, add line break if wanted
    \repeat unfold 5 { c4 c c c }
    \bar ".|:-||"
    \repeat volta 3 { c4 c c c }
    \alternative { { d d d e } { e e e f } { f f f g } }
    c1
    \bar"|."
  }
}
