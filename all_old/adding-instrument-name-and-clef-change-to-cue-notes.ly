%% http://lsr.di.unimi.it/LSR/Item?id=388
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-parts#instrument-names


% set the cue instrument name
setCue = #(define-music-function (parser location instr) (string?)
   #{ \set Voice.instrumentCueName = $instr #} )

% generate a cue music section with instrument names
% Parameters: \namedCueDuring NameOfQuote CueDirection CueInstrument OriginalInstrument music
%                 -) NameOfQuote CueDirection music are the parameters for \cueDuring
%                 -) CueInstrument and OriginalInstrument are the displayed instrument names
% typical call:
% \namedCueDuring #"vIQuote" #UP #"V.I" #"Sop." { R1*3 }
%      This adds the notes from vIQuote (defined via \addQuote) to three measures, prints "V.I" at
%      the beginning of the cue notes and "Sop." at the end
namedCueDuring = #(define-music-function (parser location cuevoice direction instrcue instr cuemusic) (string? number? string? string? ly:music?)
   #{
     \tag #'cued { \cueDuring #cuevoice #direction { \setCue #instrcue $cuemusic \setCue #instr } }
     \tag #'uncued $cuemusic
   #}
)

% set the cue instrument name and clef
setClefCue = #(define-music-function (parser location instr clef) 
                                                     (string? string?)
   #{
     \once \override Staff.Clef.font-size = #-3 \clef $clef
     \set Voice.instrumentCueName = $instr
   #} )

% generate a cue music section with instrument names and clef changes
% Parameters: \cleffedCueDuring NameOfQuote CueDirection CueInstrument CueClef OriginalInstrument OriginalClef music
%                 -) NameOfQuote CueDirection music are the parameters for \cueDuring
%                 -) CueInstrument and OriginalInstrument are the displayed instrument names
%                 -) CueClef and OriginalClef are the clefs for the the cue notes and the clef of the containing voice
% typical call:
% \cleffedCueDuring #"vIQuote" #UP #"V.I" #"treble" #"Basso" #"bass" { R1*3 }
%      This adds the notes from vIQuote (defined via \addQuote) to three measures, prints "V.I" at
%      the beginning of the cue notes and "Basso" at the end. The clef is changed to treble at the 
%      beginning of the cue notes and reset to bass at the end
cleffedCueDuring = #(define-music-function (parser location cuevoice direction instrcue clefcue instr clefinstr cuemusic) 
                                                        (string? number? string? string? string? string? ly:music?)
   #{
     \tag #'cued { \cueDuring #cuevoice #direction { \setClefCue #instrcue #clefcue $cuemusic \setClefCue #instr #clefinstr } }
     \tag #'uncued $cuemusic
   #}
)

% the voice, where cue notes are inserted:
Solo = \relative c'' {
   c2 c |
   \namedCueDuring #"vIQuote" #1 #"Vio.1" #"Sop." { R1*2 }
   c2 c \bar"||"
   \clef "bass"
   c,,2 c |
   \cleffedCueDuring #"vIQuote" #1 #"V1" #"treble" #"Basso" #"bass" { R1*2 }
   c2 c |
}

% the voice to be quoted
vI = \relative c'' { \clef "treble" f2 f | f f | f f | f f | f f | f f | f f | f f | }
\addQuote vIQuote { \vI }
% Lilypond >= 2.11 changed the spelling to \addQuote, so use the following command instead
% \addQuote vIQuote { \vI }

\layout {
  \context { \Score % set the font of the instrument names to a smaller size:
      \override InstrumentSwitch.font-size = #-3
  }
}


% Solo score with cue notes:
\score {
  \new Staff \keepWithTag #'cued \Solo
  \header { piece="Solo score with cue notes"}
}

% full score with cue notes removed
\score {
        <<
                \new Staff \keepWithTag #'uncued \Solo
                \new Staff \keepWithTag #'uncued \vI
        >>
  \header { piece="Full score with cue notes removed"}
}
