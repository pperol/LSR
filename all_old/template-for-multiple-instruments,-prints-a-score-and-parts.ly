%% http://lsr.di.unimi.it/LSR/Item?id=603
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/templates

\include "english.ly"
\header {
  title = "Song Title"
  composer = "As Recorded By: "
  arranger = "Transcribed by: "
}
global = {
  \key c \major
  \time 4/4
  \set Timing.beamExceptions =      
  	#'(                    
  	   (end .              
  	    (                  
  	     ((1 . 8) . (2 2 2 2))   
  	    ))) 
  %\override Score.BarNumber.break-visibility = #'#(#t #t #t)
  %\override Score.BarNumber.break-visibility = #end-of-line-invisible
  %\override Score.BarNumber.self-alignment-X = #LEFT
  \override Glissando.thickness = #3
  \override Glissando.style = #'zigzag
  \override Glissando.minimum-length = #6
  \override Glissando.springs-and-rods = #ly:spanner::set-spacing-rods
  \override MultiMeasureRest.expand-limit = #1
  \set Score.skipBars = ##t
  \numericTimeSignature
}
%%%%% This setup should give me the maximum usable staves per page %%%%%
\paper {
  top-margin = 0.1\cm 
  top-system-spacing #'basic-distance = #0
  ragged-bottom = ##t
  left-margin = 20\mm
  line-width = 175\mm
}

%%%%% This script sets the 'footer' of the last page to show the current date %%%%%
tagline = \markup {
  \simple #(strftime "%b %d, %Y" (localtime (current-time)))
  \with-url #"http://lilypond.org/web/"
  { LilyPond \simple #(lilypond-version) (http://lilypond.org/) }
}

% ------ Trumpet 1------
trpta = {
  a b c d 
}
trumpeta = %{\transpose c d%} \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet 1"
  \set Staff.shortInstrumentName = #"Trpt 1"
  \clef treble
  << \trpta >>
}

% ------ Trumpet 2------
trptb = {
  a4 b c d
}
trumpetb = %{\transpose c d%} \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet 2"
  \set Staff.shortInstrumentName = #"Trpt 2"
  \clef treble
  << \trptb >>
}

% ------ Alto Sax 1 ------
altoa = {
  a4 b c d
}
altosaxa = %{\transpose c a%} \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \set Staff.shortInstrumentName = #"Alto"
  \clef treble
  << \altoa >>
}

% ------ Tenor------
tenor = {
  a4 b c d
}
tenorsax = %{\transpose c d%} \relative c'' {
  \global
  \set Staff.instrumentName = #"Tenor Sax"
  \set Staff.shortInstrumentName = #"Tenor"
  \clef treble
  << \tenor >>
}

% ------ Bari------
bari = {
  a4 b c d
}
barisax = %{\transpose c a%} \relative c'' {
  \global
  \set Staff.instrumentName = #"Bari Sax"
  \set Staff.shortInstrumentName = #"Bari"
  \clef treble
  << \bari >>
}

% ------ Trombone 1------
tbonea = {
  a4 b c d
}
trombonea = \relative c {
  \global
  \set Staff.instrumentName = #"Trombone"
  \set Staff.shortInstrumentName = #"Tbn"
  \clef bass
  << \tbonea >>
}

% ------ Bass Trombone------
tboneb= {
  a4 b c d
}
tromboneb = \relative c {
  \global
  \set Staff.instrumentName = #"Bass Trombone"
  \set Staff.shortInstrumentName = #"Bass Tbn"
  \clef bass
  << \tboneb >>
}
%%%%% This section creates the separate pdf files for each horn %%%%%
\book {
  \score {
    <<
      \new StaffGroup = "trumpets" <<
        \new Staff = "trpta" \trumpeta
        \new Staff = "trptb" \trumpetb
       >>
      \new StaffGroup = "saxes" <<
        \new Staff = "altoa" \altosaxa
        \new Staff = "tenor" \tenorsax
        \new Staff = "bari" \barisax
      >>
      \new StaffGroup = "trombones" <<
        \new Staff = "tbonea" \trombonea
        \new Staff = "tboneb" \tromboneb
      >>
    >>
  }
}
%{
%%%%% comment all these \book lines if no score is needed %%%%%%
\book { \score { << \new Staff = "trumpeta" \with { \remove Instrument_name_engraver } \trumpeta >> \header { piece = "Trumpet 1" } \layout { indent = 0\mm } } }
\book { \score { << \new Staff = "trumpetb" \with { \remove Instrument_name_engraver } \trumpetb >> \header { piece = "Trumpet 2" } \layout { indent = 0\mm } } }
\book { \score { << \new Staff = "altosaxa" \with { \remove Instrument_name_engraver } \altosaxa >> \header { piece = "Alto Sax" } \layout { indent = 0\mm } } }
\book { \score { << \new Staff = "tenorsax" \with { \remove Instrument_name_engraver } \tenorsax >> \header { piece = "Tenor Sax" } \layout { indent = 0\mm } } }
\book { \score { << \new Staff = "barisax" \with { \remove Instrument_name_engraver } \barisax >> \header { piece = "Baritone Sax" } \layout { indent = 0\mm } } }
\book { \score { << \new Staff = "trombonea" \with { \remove Instrument_name_engraver } \trombonea >> \header { piece = "Trombone" } \layout { indent = 0\mm } } }
\book { \score { << \new Staff = "tromboneb" \with { \remove Instrument_name_engraver } \tromboneb >> \header { piece = "Bass Trombone" } \layout { indent = 0\mm } } }
%}
\layout {
  \context {
    \Score
  }
}
