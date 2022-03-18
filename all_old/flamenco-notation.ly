%% http://lsr.dsi.unimi.it/LSR/Item?id=409
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings#fretted-strings-flamenco-notation

%% Updated/modified by P.P.Schneider on Feb. 2014

%%%%%%%  Cut here ----- Start 'flamenco.ly'

% Text indicators : 
abanico = ^\markup\small { \italic Abanico }
rasgueado = ^\markup\small { \italic Ras. }
alzapua = ^\markup\small { \italic Alzapua }

% Finger stroke symbols :
strokeUp = 
\markup\column {
  \fontsize #2 \arrow-head #Y #UP ##f
  \vspace # -.3
  \override #'(thickness . 1.3)
  \draw-line #'(0 . 2) 
}

strokeDown = 
\markup\column {
  \override #'(thickness . 1.3)
  \draw-line #'(0 . 2.1) 
  \vspace # -1
  \fontsize #2 \arrow-head #Y #DOWN ##f
}

% Golpe symbol :
golpe = \markup {
  \filled-box #'(0 . 1) #'(0 . 1) #0
  \hspace #-1.6
  \with-color #white
  \filled-box #'(0.15 . 0.85) #'(0.15 . 0.85) #0
} 

% Strokes, fingers and golpe command :
RHp = \rightHandFinger #1 
RHi = \rightHandFinger #2
RHm = \rightHandFinger #3
RHa = \rightHandFinger #4
RHx = \rightHandFinger #5
RHu = \rightHandFinger \strokeUp 
RHd = \rightHandFinger \strokeDown
RHg = \rightHandFinger \golpe

% Just handy :)
tupletOff = {
  \once \override TupletNumber.stencil = ##f
  \once \override TupletBracket.stencil = ##f
}

tupletsOff = {
  \override TupletNumber.stencil = ##f
  \override TupletBracket.bracket-visibility = #'if-no-beam
}

tupletsOn = {
  \override TupletBracket.bracket-visibility = #'default
  \revert TupletNumber.stencil
}

headsOff = {
  \override TabNoteHead.transparent = ##t
  \override NoteHead.transparent = ##t
  \override NoteHead.no-ledgers = ##t
}

headsOn = {
  \override TabNoteHead.transparent = ##f
  \override NoteHead.transparent = ##f
  \override NoteHead.no-ledgers = ##f
}

%%%%%%%  Cut here ----- End 'flamenco.ly'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\paper { 
  system-system-spacing #'basic-distance = #18
  indent = 0
}

part = \relative c' {
  \set strokeFingerOrientations = #'(up)
  \override StrokeFinger.add-stem-support = ##t
  <a, e' a cis e\RHu\RHi>8
  <a e' a cis e\RHd\RHi>8
  r4
  r2^\markup\golpe
  <a e' a cis e\RHu\RHi>8
  <a e' a cis e\RHd\RHi>8
  <a e' a cis e\RHu\RHi\RHg>8
  <a e' a cis e\RHd\RHi>8
  r2
  <a e' a cis e\RHu\RHa>16\rasgueado
  \headsOff
  <a e' a cis e\RHu\RHm>
  <a e' a cis e\RHu\RHi>
  <a e' a cis e\RHd\RHi>~
  \headsOn
  <a e' a cis e>2
  r4
  \tupletOff
  \tuplet 5/4 {
    <a e' a cis e\RHu\RHx>16\rasgueado
    \headsOff
    <a e' a cis e\RHu\RHa>
    <a e' a cis e\RHu\RHm>
    <a e' a cis e\RHu\RHi>
    <a e' a cis e\RHd\RHi>~
    \headsOn
  }
  <a e' a cis e>2
  r4
  \tupletsOff
  \tuplet 3/2 {
    <a e' a cis e\RHd\RHp>8\abanico
    \headsOff
    <a e' a cis e\RHu\RHx>
    <a e' a cis e\RHu\RHi>
    \headsOn
  }
  \tuplet 3/2 {
    <a e' a cis e\RHd\RHp>8
    \headsOff
    <a e' a cis e\RHu\RHx>
    <a e' a cis e\RHu\RHi>
    \headsOn
  }
  \tuplet 3/2 {
    <a e' a cis e\RHd\RHp>8
    \headsOff
    <a e' a cis e\RHu\RHx>
    <a e' a cis e\RHu\RHi>
    \headsOn
  }
  \tuplet 3/2 {
    <a e' a cis e\RHd\RHp>8
    \headsOff
    <a e' a cis e\RHu\RHx>
    <a e' a cis e\RHu\RHi>
    \headsOn
  }
  \tupletsOff
  \override Beam.positions = #'(2 . 2)
  \tuplet 3/2 {
    a8\RHp\alzapua
    <e' a\RHu\RHg>
    <e a\RHd>
  }
  \tuplet 3/2 {
    a,8\RHp
    <e' a\RHu\RHg>
    <e a\RHd>
  }
  \tuplet 3/2 {
    a,8\RHp
    <e' a\RHu\RHg>
    <e a\RHd>
  }
  \tuplet 3/2 {
    a,8\RHp
    <e' a\RHu\RHg>
    <e a\RHd>
  }
  \tupletsOn
  <g, b f'\RHu\RHm>1
  \bar "|."
}

\score {
  \new StaffGroup <<
    \context Staff = "part" <<
      \clef "G_8"
      {
        \part
      }
    >>
    \context TabStaff {
      \part
    }
  >>
  \layout {
    ragged-right = ##t
  }
}
