%% http://lsr.dsi.unimi.it/LSR/Item?id=874

%by: ArnoldTheresius
%corrected 2013-03-12: make before-line-breaking procedure and engraver
%    work on pitches with '!', but not with '?'

%partial incompatible: \version "2.12.3
%tested: \version "2.22.0"
%tested: \version "2.22.0"
%tested: \version "2.22.0"

%%% Version 2.14.2 and below:
%%% Version 2.14.2 and below:
% modern = #(set-accidental-style 'modern)
% modernCautionary = #(set-accidental-style 'modern-cautionary)

%%% Version 2.16.0 and above:
modern = \accidentalStyle modern
modernCautionary = \accidentalStyle modern-cautionary

\markup { \null \translate #'( 1 . -5 ) \null } % 2.14.2 LSR problem workaroud

%%%% The LILYPOND Standard:

MusicI = {
  \key f \major
  cis''4(
  c''2) r8 \set doubleSlurs = ##t ges' <b' e'>4(
  <g' bes'>2.) \set doubleSlurs = ##f
}

\score {
  \new Staff {
    \partial 4
    s4*0^"modern:"
    \modern
    \MusicI
    \bar "||"
    s4*0^"modern-cautionary:"
    \modernCautionary
    \MusicI
    \bar "|."
  }
  \header {
    piece = "LILYPOND's default result"
  }
}

%%%% Example 1:

#(define (remove-parenthesis-from-accidental grob)
  (let ((accidental (ly:grob-object grob 'accidental-grob)))
   (if (not (null? accidental))
    (ly:grob-set-property! accidental 'parenthesized #f)
    (display " accidental-grob not found! "))))

unparenthesizeAccidental = #(define-music-function (music) (ly:music?)
  (set! (ly:music-property music 'tweaks)
   (acons 'before-line-breaking remove-parenthesis-from-accidental
    (ly:music-property music 'tweaks)))
  music)

% With 2.16.1 you can define:
%{
unparenthesizeAccidental = #(define-music-function (music) (ly:music?)
#{
        \tweak before-line-breaking #remove-parenthesis-from-accidental
        $music
#})
%}

MusicII = {
  \key f \major
  cis''4(
  <\unparenthesizeAccidental c''>2) r8 \set doubleSlurs = ##t ges' <b' e'>4(   %%% NOTE!
  <g' \unparenthesizeAccidental bes'>2.) \set doubleSlurs = ##f
}
%%% NOTE!
  % you need to put '\unparenthesizeAccidental' into a chord definition for version 2.14.2 and before,
  % e.g. '<\unparenthesizeAccidental c''>2)' to make it work with version 2.14.2 and before

\score {
  \new Staff {
    \partial 4
    s4*0^"modern:"
    \modern
    \MusicII
    \bar "||"
    s4*0^"modern-cautionary:"
    \modernCautionary
    \MusicII
    \bar "|."
  }
  \header {
    piece = \markup \column {
      "preceding the critical notes/pitches with the user defined function \\unparenthesizeAccidental"
      "(before version 2.16.0 you had to put this command inside a chord!)"
    }
  }
}

%%%% Example 2:

MusicIII = {
  \key f \major
  % \partial 4
  cis''4(
  c''!2) r8 \set doubleSlurs = ##t ges' <b' e'>4(
  <g' bes'!>2.) \set doubleSlurs = ##f
}

#(define (visit-cautionary-accidentals grob)
  (let*
   ((my-notehead-grob (ly:grob-property grob 'cause))
    (my-notehead-prob (ly:grob-property my-notehead-grob 'cause))
    (accidental-is-forced (and
      (ly:prob-property my-notehead-prob 'force-accidental #f)
      (not (ly:prob-property my-notehead-prob 'cautionary #f)))))
   (if accidental-is-forced (ly:grob-set-property! grob 'parenthesized #f))))

\score {
  \new Staff {
    \override AccidentalCautionary.before-line-breaking = #visit-cautionary-accidentals
    \partial 4
    s4*0^"modern:"
    \modern
    \MusicIII
    \bar "||"
    s4*0^"modern-cautionary:"
    \modernCautionary
    \MusicIII
    \bar "|."
  }
  \header {
    piece = \markup \column {
      "remove all parenthesis from cautionary accidentals, if a »force« flag is found"
      "(Exlamation mark »!« after the pitch, and setting the user defined before-line-breaking procedure"
      "by »\\override AccidentalCautionary.before-line-breaking = #visit-cautionary-accidentals«)"
    }
  }
}

%%%% Example 3:
% This will not run on version 2.12.3!

#(define (Parenthesis_on_cautionary_accidentals_purger ctx)
    `((acknowledgers
       (accidental-interface
        . ,(lambda (trans grob source)
            (let*
             ((grob-meta (ly:grob-property grob 'meta))
              (grob-name (ly:assoc-get 'name grob-meta)))
             (if (equal? (symbol->string grob-name) "AccidentalCautionary")
              (let*
               ((my-notehead-grob (ly:grob-property grob 'cause))
                (my-notehead-prob (ly:grob-property my-notehead-grob 'cause))
                (accidental-is-forced (and
                  (ly:prob-property my-notehead-prob 'force-accidental #f)
                  (not (ly:prob-property my-notehead-prob 'cautionary #f)))))
               (if accidental-is-forced (ly:grob-set-property! grob 'parenthesized #f))))))))))

\score {
  \new Staff \with {
    \consists #Parenthesis_on_cautionary_accidentals_purger
  } {
    \partial 4
    s4*0^"modern:"
    \modern
    \MusicIII
    \bar "||"
    s4*0^"modern-cautionary:"
    \modernCautionary
    \MusicIII
    \bar "|."
  }
  \header {
    piece = "remove all parenthesis from cautionary accidentals by an engraver, if a »force« flag is found"
  }
}


