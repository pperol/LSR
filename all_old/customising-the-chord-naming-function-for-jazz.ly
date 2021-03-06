%% http://lsr.di.unimi.it/LSR/Item?id=102
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-chords#customizing-chord-names


chs =  \transpose c' c' {
  <c e g>1
  <c es g>% m = minor triad
  <c e gis>
  <c es ges> \break
  <c e g bes>
  <c es g bes>
  <c e g b> 		% triangle = maj
  <c es ges beses> 
  <c es ges b> \break
  <c e gis bes>
  <c es g b>
  <c e gis b> 
  <c es ges bes>\break
  <c e g a>   % 6 = major triad with added sixth
  <c es g a>  % m6 = minor triad with added sixth
  <c e g bes d'> 
  <c es g bes d'> \break
  <c es g bes d' f' a' >
  <c es g bes d' f' >
  <c es ges bes d' > 
  <c e g bes des' > \break
  <c e g bes dis'>
  <c e g bes d' f'>
  <c e g bes d' fis'>
  <c e g bes d' f' a'>\break
  <c e g bes d' fis' as'>
  <c e gis bes dis'>
  <c e g bes dis' fis'>
  <c e g bes d' f' as'>\break
  <c e g bes des' f' as'>
  <c e g bes d' fis'>
  <c e g b d'>
  <c e g bes d' f' as'>\break
  <c e g bes des' f' as'>
  <c e g bes des' f' a'>
  <c e g b d'>
  <c e g b d' f' a'>\break
  <c e g b d' fis'>
  <c e g bes des' f ' a'>
  <c f g>
  <c f g bes>\break
  <c f g bes d'>
  <c e g d'>	% add9
  <c es g f'>
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% alternate Jazz notation

efullmusicJazzAlt = 
{
  <c e gis>1-\markup { "+" }
  <c e g b>-\markup { \normal-size-super
    %			  \override #'(font-family . math) "N" }
		      \override #'(font-family . math) "M" }
    %%c:3.5.7 = \markup { \override #'(font-family . math) "M" }
    %%c:3.5.7 = \markup { \normal-size-super "maj7" }

  <c es ges>-\markup { \super "o" } % should be $\circ$ ?
  <c es ges bes>-\markup { \super \combine "o" "/" }
  <c es ges beses>-\markup { \super  "o7" }
}

efullJazzAlt = #(sequential-music-to-chord-exceptions efullmusicJazzAlt #f)

epartialmusicJazzAlt = {
  <c d>1-\markup { \normal-size-super "2" }
  <c es>-\markup { "m" }
  <c f>-\markup { \normal-size-super "sus4" }
  <c g>-\markup { \normal-size-super "5" }
  
    %% TODO, partial exceptions
  <c es f>-\markup { "m" }-\markup { \normal-size-super "sus4" }
  <c d es>-\markup { "m" }-\markup { \normal-size-super "sus2" }
}

epartialJazzAlt = #(sequential-music-to-chord-exceptions epartialmusicJazzAlt #f)

jazzAltProperties = \sequential { 
  \set majorSevenSymbol = #whiteTriangleMarkup
  \set chordNameSeparator = #(make-simple-markup  "/")
  \set chordNameExceptionsFull = #efullJazzAlt
  \set chordNameExceptionsPartial = #epartialJazzAlt
  \set chordNameFunction = #jazz-chord-names
}

banterProperties = \sequential { 
  \set chordNameFunction = #banter-chord-names
}

\score{
  <<
    \new ChordNames {
      \set ChordNames.instrumentName = #"Ignatzek (default)"
      \set ChordNames.shortInstrumentName = #"Def"
      \chs
    }
    
    \new ChordNames {
      \jazzAltProperties
      \set ChordNames.instrumentName = #"Alternative"
      \set ChordNames.shortInstrumentName = #"Alt"
      \chs
    }

%{

	%% This is the Banter (1987) style.  It gives exceedingly
	%% verbose (wide) names, making the output file take up to 4 pages.
	%% (FIXME: how big is is now?)
	%% Turned off by default.

	%% FIXME: use smaller font for Banter (or remove some esoteric
	%% chords).
	
    \new ChordNames {
      \banterProperties
      \set ChordNames.instrumentName = #"Banter"
      \set ChordNames.shortInstrumentName = #"Ban"
      \chs
    }
%}
	
    \new Staff  \transpose c c' { \chs }
  >>
  \layout {
    indent = 3.\cm
    \context { 
      \ChordNames
      \consists Instrument_name_engraver
    }
  }
}
