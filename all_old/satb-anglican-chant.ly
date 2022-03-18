%% http://lsr.di.unimi.it/LSR/Item?id=231
%% see also http://lsr.di.unimi.it/LSR/Item?id=708
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music#vocal-music-anglican-psalm-template

%% commented out for LSR
%
% FIRST, create anglican-init.ly.  This only needs to be done once each time you upgrade LilyPond.
% The code was borrowed from gregorian-init.ly.
% For purposes of the LSR, the anglican-init.ly code is inserted directly.
% \include "anglican-init.ly"  
%
%% commented out for LSR

divisioMinima = {
  \once \override BreathingSign.stencil = #ly:breathing-sign::divisio-minima
  \once \override BreathingSign.extra-X-extent = #'(-1.0 . 0)
  \breathe
}

divisioMaior = {
  \once \override BreathingSign.stencil = #ly:breathing-sign::divisio-maior
  \once \override BreathingSign.Y-offset = #0
  \once \override BreathingSign.extra-X-extent = #'(-1.0 . 0)
  \breathe
}

divisioMaxima = {
  \once \override BreathingSign.stencil = #ly:breathing-sign::divisio-maxima
  \once \override BreathingSign.Y-offset = #0
  \once \override BreathingSign.extra-X-extent = #'(-1.0 . 0)
  \breathe
}

finalis = {
  \once \override BreathingSign.stencil = #ly:breathing-sign::finalis
  \once \override BreathingSign.Y-offset = #0
  \once \override BreathingSign.extra-X-extent = #'(-1.0 . 0)
  \breathe
}

#(set-default-paper-size "letter")
\pointAndClickOff

%**********************************%
% END of inserted anglican-init.ly %
%**********************************%

global = {
  %SECOND, enter key
  \key d \major
  %
  \set Staff.whichBar = #""
  \set Score.timing = ##f
  \accidentalStyle modern-voice
  \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
  \override Score.PaperColumn.keep-inside-line = ##t
}

% THIRD, Enter music (remember to include the leading s4 in the bassMusic sections)

trebMusicA = {
  \textLengthOn s4^"A" \noBreak
  <a' d'>2
  \divisioMinima
  <d'' d'>4 <b' e'>
  \divisioMinima
  <cis'' e'>2
  \divisioMaior
  <a' d'>2
  \divisioMinima
  <b' d'>4 <g' e'>
  \divisioMinima
  <a' cis'> <fis' d'>
  \divisioMinima
  <e' cis'>2
  \divisioMaxima
}

trebMusicB = {
  \textLengthOn s4^"B" \noBreak
  <g' b>2
  \divisioMinima
  <c'' e'>4 <a' d'>
  \divisioMinima
  <b' d'>2
  \divisioMaior
  <e' cis'>2
  \divisioMinima
  <a' cis'>4 <fis' d'>
  \divisioMinima
  <g' d'> <e' cis'>
  \divisioMinima
  d'2
  \finalis
}

bassMusicA = {
  s4 <fis d>2
  \divisioMinima
  <fis b,>4 <gis e>
  \divisioMinima
  <a a,>2
  \divisioMaior
  <fis d>2
  \divisioMinima
  g4 <b e>
  \divisioMinima
  <a fis> <a d>
  \divisioMinima
  <a a,>2
  \divisioMaxima
}

bassMusicB = {
  s4 <g e>2
  \divisioMinima
  <g c>4 <fis d>
  \divisioMinima
  <g g,>2
  \divisioMaior
  <a g>2
  \divisioMinima
  <a fis>4 <b b,>
  \divisioMinima
  <b e> <g a,>
  \divisioMinima
  <fis d>2
  \finalis
}

% FOURTH Enter Words (This allows a different dynamic for each verse.  I create a separate lyric for
% each antiphonal group.  This way, the antiphon can be changed without reprogramming the entire
% psalm.  Also, I insert an en-dash in hyphenated words and an en-dash lyric tie for tied words.)
% NOTE: LSR didn't like the en-dash so I substituted a hyphen.

lentAntiphon = \lyricmode {
  \markup { \box Ant. \raise #2.0 \dynamic mf The Lord if full of com-} passion and mercy:*
  \markup { \raise #2.0 \dynamic mf Come let } us a- do-~ re him.
}

onetwo = \lyricmode {
  \markup { \box 1 \raise #2.0 \dynamic mf Come, let us } sing_to the LORD;*
  \markup { \raise #2.0 \dynamic f let us shout for joy to the} Rock of our sal- vation.

  \markup { \box 2 \raise #2.0 \dynamic mf Let us come before his } presence with_thanks- giving*
  \markup { \raise #2.0 \dynamic f and raise a loud } shout to him with psalms.
}

threefive = \lyricmode {
  \markup { \box 3 \raise #2.0 \dynamic mf For the LORD is a } gre-~ at God,*
  \markup { \raise #2.0 \dynamic mf and a great } King a- bove all gods.

  \markup { \box 4 \raise #2.0 \dynamic mf In his hand are the } caverns of_the earth,*
  \markup { \raise #2.0 \dynamic mf and the heights of the } hills are hi-~ s also.

  \markup { \box 5 \raise #2.0 \dynamic mf The sea is } his, for_he made_it,*
  \markup { \raise #2.0 \dynamic mf and his hands have } molded the dr-~ y land.
}

sixseven = \lyricmode {
  \markup { \box 6 \raise #2.0 \dynamic mp Come, let us bow down, and } bend the knee,*
  \markup { \raise #2.0 \dynamic mp and } kneel_be- fore_the LORD our Maker.

  \markup { \box 7 \raise #2.0 \dynamic mf For he is our God, and we are the people of his pasture and the } sheep_of his hand.*
  \markup { \raise #2.0 \dynamic mp Oh, that to- } day you_would hearken to_his voice!
}

\score {
  \context ChoirStaff <<
    \context Staff = women <<
      \context Voice = women {
        \oneVoice
        \global
        % FIFTH sequence the trebMusic and bassMusic in the correct A B pattern.
        \trebMusicA
        \trebMusicA
        \trebMusicB
        \trebMusicA
        \trebMusicB
        \trebMusicA
        \trebMusicB
        \trebMusicA
        \trebMusicA
        \trebMusicB
      }
    >>
    \context Lyrics = women \lyricsto women {
      \override LyricText.self-alignment-X = #-0.7

      % SIXTH sequence the words with inserted Antiphon
      \onetwo
      \lentAntiphon
      \threefive
      \lentAntiphon
      \sixseven
      \lentAntiphon
    }
    \context Staff = men <<
    \clef bass
      \context Voice = basses {
        \oneVoice
        \global
        % FIFTH sequence the trebMusic and bassMusic in the correct A B pattern.
        \bassMusicA
        \bassMusicA
        \bassMusicB
        \bassMusicA
        \bassMusicB
        \bassMusicA
        \bassMusicB
        \bassMusicA
        \bassMusicA
        \bassMusicB
      }
    >>
  >>
  \layout {
    indent = 0\in
    line-width = 8\in
    oddFooterMarkup = ##f
    oddHeaderMarkup = ##f
    bookTitleMarkup = ##f
    scoreTitleMarkup = ##f
    ragged-right = ##t
    ragged-last = ##t
    \context {
      \Score
      barAlways = ##t
    }
    \context {
      \Staff
      \remove "Time_signature_engraver"
      \override Stem.transparent = ##t
    }
    \context {
      \Voice
      \override Stem.length = #0
    }
  }
}
% END OF LILYPOND CODE

%{

I use lilypond-book to print the music because I usually want to insert scanned .png files at the beginning and sometimes the end of the document.  In this case, it was not necessary, but sometimes the antiphon is already printed and there is no need reprogram it for publication.  Here is the template for the Latex file (S39.tex):

\documentclass[letterpaper]{article}
\usepackage{graphicx}
\usepackage[total={8in,10in},centering,includefoot,includehead]{geometry}
\usepackage{fancyhdr} % This should be set AFTER setting up the page geometry
\usepackage{lastpage}
\pagestyle{fancy}\fancyhead{}
\renewcommand{\headrulewidth}{0pt} % customise the layout...
\lhead{}\chead{The Hymnal 1982 \copyright 1985, by The Church Pension Fund  All rights reserved.  Used by permission.}\rhead{}
\lfoot{Daily Morning Prayer II S 39\\The Invitatory:  Venite/Psalm 95}\cfoot{Music engraving by Fred Leason with LilyPond 2.11.19}\rfoot{\thepage\ of \pageref{LastPage}}

\begin{document}

\includegraphics[width=7.5in]{../S39.png} %This is sometimes a scanned version of the antiphon.  In this case, it is the Anglican Chant from the Hymnal.

\lilypondfile{S39.ly}

\includegraphics[width=7.5in]{../VeniteText.png} %This is sometimes a repeated scan of the Antiphon.  In this case it is a sample of the pointing from the Hymnal.

\end{document}

%END OF LATEX.

SEVENTH Change the head and foot in the above .tex file.  Name the correct \lilypondfile.  Name any .png files that may be included in the final document.

I use this shell script to run lilypond-book.  Put this script somewhere that is also in your PATH.  Change the mode to execute (chmod +x lilybook.sh)

EIGHTH cd to the directory containing your .ly, .tex, and any .png files.  Then run lilybook.sh <name of tex file>

BEGIN SCRIPT

#!/bin/sh
rm -r pdflatex
lilypond-book --pdf $1.tex --output=pdflatex
cd pdflatex
pdflatex $1
pdflatex $1
open $1.pdf
cd ..

END SCRIPT

Note, I run pdflatex twice so that the number of pages are counted.

So here is what your sequence will look like:

>pwd
~/Desktop/LSR
>ls
Anglican.rtfd   S39.log         S39.ly          S39.pdf         S39.png         S39.ps          S39.tex         VeniteText.png
>lilybook.sh S39
%}
