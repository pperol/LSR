%% http://lsr.dsi.unimi.it/LSR/Item?id=493

%%
%% Based on the ideas, work, hard slog and implementations of Nicolas Sceaux, 
%% (who also had to do the reviews.)
%%
%% current-target
%%	Target option passed on the command line. If none found, then use the
%%	target 'default
%%
#(define current-target (or (ly:get-option 'target) 'default))

%%
%% set-target!
%%	Utility routine to override the current target. Specifically used in 
%%	this snippet to simulate different passes over the input files.
%%	target	    symbol	New target (as if it had been set by -dtarget= 
%%
#(define (set-target! target)
	 (set! current-target target))

%% 
%% value-if-target-in
%%	Utility routine to set a value depending on whether the candidate 
%%	list contains the current-target.
%%	eligible    list	List of symbols
%%	value			Value to return if the eligible list contains 
%%				the current target.
%%	else-value		Value to return if the current target isn't in
%%				the list of eligible.
%%
#(define (value-if-target-in eligible value else-value)
  (if (memq current-target eligible)
      value
      else-value))
%%
%% target-names
%%	Map of target names
%%
#(define target-names 
	 '((chords ."With explicit chords") 
	   (song   ."With all lyrics")))

%%
%% Set up an instrument name for the header
%%
targetName = #(assoc-ref target-names current-target)

%%
%% ifTargetIn
%%	Render the music expression if the target is in the eligible list
%%
ifTargetIn =
#(define-music-function (parser location eligible music)
			(list? ly:music?)
  (value-if-target-in eligible music (make-music 'Music)))

%%
%% if-target-in
%%	Render the markup expression if the target is in the eligible list
%%
#(define-markup-command (if-target-in layout props eligible markp)
			(list? markup?)
  (value-if-target-in eligible
		      (interpret-markup layout props markp)
		      empty-stencil))

		      
%%% SNIPPET SPECIFIC WORKAROUND SECTION =================================
%%% THIS IS NOT PART OF THE EXAMPLE CODE -- JUST A WORKAROUND.
%%% As we fake the "-d target=xxx" command line switch by setting the 
%%% target option in the source file itself, and as when markup commands 
%%% are interpreted the whole file as been read long ago, the 
%%% \if-target-in markup command sees that the selected target option is 
%%% the last one set using set-target!
%%% In practice, the option would be set once, from the command line switch. 
%%% But here, as we fake in a single file the three possible calls, we use 
%%% this music function as a workaround.
toplevelMarkupIfTargets =
#(define-music-function (parser location eligible text)
                        (list? markup?)
   (if (memq current-target eligible)
       (collect-scores-for-book parser 
			        (if (>= (cadr (ly:version)) 11)
				    (list text)
				    text)))
       (make-music 'Music 'void #t))

%%% Redefine this as a no-op to still be able to use it in the examples
#(define-markup-command (if-target-in layout props eligible markp)
			(list? markup?)
    (interpret-markup layout props markp))

%%% END SNIPPET SPECIFIC WORKAROUND SECTION =============================

%% ======================================================================

txtChorus = \lyricmode {
  \set stanza = "Ch." This is a ve- ry me- lo- dious cho- rus.
}
txtVerseI = \lyricmode {
  \set stanza = "1." And this is the first verse of three. This
}
txtVerseII = \lyricmode {
  \set stanza = "2." And now this is the se- cond one.
}
txtVerseIII = \lyricmode {
  \set stanza = "3." And this is the end of my song.
}

mlChorus   = \markup { C. \italic { This is a very melodious chorus. } }
mlVerseI   = \markup { 1. And this is the first verse of three. }
mlVerseII  = \markup { 2. And now this is the second one. }
mlVerseIII = \markup { 3. And this is the end of my song.}

chdBoth = \chordmode { c4 g1 c g c }

treChorusI  = \relative c'' { g4 | a2 b4 c8 c16 d32 e | f2 e4 d | }
treVerseI  = \relative c'' { g4. a8 b4. c8 | g4 a8 b c b\rest g4 | }
treBothII = \relative c' { 
  s4 | e2 e2 | d8 e d e d e d e | d8 e d e d e d e | d8 e d e d s s4 | 
}
basBothI  = \relative c' { 
  c4 | b2 c2 | d2 c2 | b2 c2 | d2 c8 d,\rest c'4 | 
}
basBothII = \relative c { 
  c16 c c c | d16 e d e d e d e d e d e d e d e | 
  d16 e d e d e d e d e d e d e d e | 
  d16 e d e d e d e d e d e d e d e | 
  d16 e d e d e d e d e s8 c16 c c c | 
}

global = {
  \key c \major
  \time 4/4
  \partial 4 s4 s1*2 \bar "||"
  s1*2 \bar "|."
}



%% ======================================================================
%% FIRST PASS : Score with default target
%% Simulate the command > lilypond <filename>
\markup \box \line \typewriter { > lilypond <filename> }
targetName = #(assoc-ref target-names current-target)
%% ======================================================================
\score {
  \context ChoirStaff <<
    \ifTargetIn #'(orgue default) \new ChordNames { \chdBoth }
    \new Staff <<
      \global \clef treble
      {
	\new Voice = "chorus" {
	  \ifTargetIn #'(default) \voiceOne
	  \treChorusI
	}
	\break
	\new Voice = "verse" {
	  \ifTargetIn #'(default) \voiceOne
	  \treVerseI
	}
      }
      \\ \ifTargetIn #'(default) { \voiceTwo \treBothII }
    >>
    \lyricsto "chorus" \new Lyrics \txtChorus
    \lyricsto "verse" \new Lyrics \txtVerseI
    % The following dummy line has been added to the original snippet for compatibility
    % with 2.14 and 2.15.  You may be able to remove it in other versions.
    #(begin)
    \ifTargetIn #'(song) <<
      \lyricsto "verse" \new Lyrics \txtVerseII
      \lyricsto "verse" \new Lyrics \txtVerseIII
    >>
    \ifTargetIn #'(default) \new Staff <<
      \global \clef bass
      \basBothI \\ \basBothII
    >>
    \ifTargetIn #'(chords) \new Staff <<
      \global \clef bass
      \transpose c c, \chdBoth
    >>
  >>
  \header { piece = \targetName }
  \layout { 
    \context { \Lyrics
      \override LyricText.font-shape = #(value-if-target-in '(chords) 'italic 'upright)
    }
  }
}
\toplevelMarkupIfTargets #'(default)	% WORKAROUND - ignore this line
\markup \if-target-in #'(default) \fill-line {
  \column{
    \line{\pad-around #1.5 {\mlChorus}}
    \line{\pad-around #1.5 {\mlVerseI}}
    \line{\pad-around #1.5 {\mlVerseII}}
    \line{\pad-around #1.5 {\mlVerseIII}}
  }
}

%% ======================================================================
%% SECOND PASS : Score with `chords' target
%% Simulate the command > lilypond -dtarget=chords -o chords <filename>
#(set-target! 'chords)
\markup \box \line \typewriter { > lilypond -dtarget=chords -o chords <filename> }
targetName = #(assoc-ref target-names current-target)
%% ======================================================================

%\noPageBreak
\score {
  \context ChoirStaff <<
    \ifTargetIn #'(chords default) \new ChordNames { \chdBoth  }
    \new Staff <<
      \global \clef treble
      {
        \new Voice = "chorus" {
          \ifTargetIn #'(default) \voiceOne
          \treChorusI
        }
        \break
        \new Voice = "verse" {
          \ifTargetIn #'(default) \voiceOne
          \treVerseI
        }
      }
      \\ \ifTargetIn #'(default) { \voiceTwo \treBothII }
    >>
    \lyricsto "chorus" \new Lyrics \txtChorus
    \lyricsto "verse" \new Lyrics \txtVerseI
    #(begin) % see comment above
    \ifTargetIn #'(song) <<
      \lyricsto "verse" \new Lyrics \txtVerseII
      \lyricsto "verse" \new Lyrics \txtVerseIII
    >>
    \ifTargetIn #'(default) \new Staff <<
      \global \clef bass
      \basBothI \\ \basBothII 
    >>
    \ifTargetIn #'(chords) \new Staff <<
      \global \clef bass
      \transpose c c, \chdBoth
    >>
  >>
  \header { piece = \targetName }
  \layout { 
    \context { \Lyrics
      \override LyricText.font-shape = #(value-if-target-in '(chords) 'italic 'upright)
    }
  }
}
\toplevelMarkupIfTargets #'(default) 	% WORKAROUND - ignore this line
\markup \if-target-in #'(default) \fill-line {
  \column{
    \line{\pad-around #1.5 {\mlChorus}}
    \line{\pad-around #1.5 {\mlVerseI}}
    \line{\pad-around #1.5 {\mlVerseII}}
    \line{\pad-around #1.5 {\mlVerseIII}}
  }
}

%% ======================================================================
%% THIRD PASS : Score with `song' target
%% Simulate the command > lilypond -dtarget=song -o song <filename>
#(set-target! 'song)
\markup \box \line \typewriter { > lilypond -dtarget=song -o song <filename> }
targetName = #(assoc-ref target-names current-target)
%% ======================================================================

%\noPageBreak
\score {
  \context ChoirStaff <<
    \ifTargetIn #'(chords default) \new ChordNames { \chdBoth }
    \new Staff <<
      \global \clef treble
      {
        \new Voice = "chorus" {
          \ifTargetIn #'(default) \voiceOne
          \treChorusI
        }
        \break
        \new Voice = "verse" {
          \ifTargetIn #'(default) \voiceOne
          \treVerseI
        }
      }
      \\ \ifTargetIn #'(default) { \voiceTwo \treBothII }
    >>
    \lyricsto "chorus" \new Lyrics \txtChorus
    \lyricsto "verse" \new Lyrics \txtVerseI
    #(begin) % see comment above
    \ifTargetIn #'(song) <<
      \lyricsto "verse" \new Lyrics \txtVerseII
      \lyricsto "verse" \new Lyrics \txtVerseIII
    >>
    \ifTargetIn #'(default) \new Staff <<
      \global \clef bass
      \basBothI \\ \basBothII 
    >>
    \ifTargetIn #'(chords) \new Staff <<
      \global \clef bass
      \transpose c c, \chdBoth
    >>
  >>
  \header { piece = \targetName }
  \layout { 
    \context { \Lyrics
      \override LyricText.font-shape = #(value-if-target-in '(chords) 'italic 'upright)
    }
  }
}
\toplevelMarkupIfTargets #'(default) 	% WORKAROUND - ignore this line
\markup \if-target-in #'(default) \fill-line {
  \column{
    \line{\pad-around #1.5 {\mlChorus}}
    \line{\pad-around #1.5 {\mlVerseI}}
    \line{\pad-around #1.5 {\mlVerseII}}
    \line{\pad-around #1.5 {\mlVerseIII}}
  }
}
