%% http://lsr.di.unimi.it/LSR/Item?id=190
%% see also http://lsr.di.unimi.it/LSR/Item?id=198
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats#repeats-positioning-segno-and-coda-_0028with-line-break_0029

{
  \clef treble
  \key g \major
  \time 4/4
  \relative c'' {
    \repeat unfold 4 {
      c4 c c c
    }

    % Set segno sign as rehearsal mark and adjust size if needed
    % \once \override Score.RehearsalMark.font-size = #3
    \mark \markup { \musicglyph #"scripts.segno" }
    \repeat unfold 2 {
      c4 c c c
    }

    % Set coda sign as rehearsal mark and adjust size if needed
    \once \override Score.RehearsalMark.font-size = #4
    \mark \markup { \musicglyph #"scripts.coda" }
    \repeat unfold 2 {
      c4 c c c
    }

    % Should Coda be on anew line?
    % Coda NOT on new line: use \nobreak
    % Coda on new line: DON'T use \nobreak
    % \noBreak

    \bar "||"

    % Set segno sign as rehearsal mark and adjust size if needed
    \once \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
    % \once \override Score.RehearsalMark.font-size = #3
    \mark \markup { \musicglyph #"scripts.segno" }

    % Here begins the trickery!
    % \cadenzaOn will suppress the bar count and \stopStaff removes the staff lines.
    \cadenzaOn
    \stopStaff
        % Some examples of possible text-displays

        % text line-aligned
        % ==================
        % Move text to the desired position
        % \once \override TextScript.extra-offset = #'( 2 . -3.5 )
        % | <>^\markup { D.S. al Coda } }

        % text center-aligned
        % ====================
        % Move text to the desired position
        % \once \override TextScript.extra-offset = #'( 6 . -5.0 )
        % | <>^\markup { \center-column { D.S. "al Coda" } }

        % text and symbols center-aligned
        % ===============================
        % Move text to the desired position and tweak spacing for optimum text alignment
        \repeat unfold 1 {
          s1
          \bar ""
        }
        \once \override TextScript.extra-offset = #'( 0 . -3.0 )
        \once \override TextScript.word-space = #1.5
        <>^\markup { \center-column { "D.S. al Coda" \line { \musicglyph #"scripts.coda" \musicglyph #"scripts.tenuto" \musicglyph #"scripts.coda"} } }

        % Increasing the unfold counter will expand the staff-free space
        \repeat unfold 3 {
          s1 
          \bar ""
        }
        % Resume bar count and show staff lines again
   \startStaff
   \cadenzaOff

   % Should Coda be on new line?
   % Coda NOT on new line: DON'T use \break
   % Coda on new line: use \break
   \break

   % Show up, you clef and key!
   \once \override Staff.KeySignature.break-visibility = #end-of-line-invisible
   \once \override Staff.Clef.break-visibility = #end-of-line-invisible

   % Set coda sign as rehearsal mark and adjust size and position

   % Put the coda sign ontop of the (treble-)clef dependend on coda's line-position

   % Coda NOT on new line, use this:
   % \once \override Score.RehearsalMark.extra-offset = #'( -2 . 1.75 )

   % Coda on new line, use this:
   \once \override Score.RehearsalMark.extra-offset = #'( -5 . .5 )
   
   \once \override Score.RehearsalMark.font-size = #5
   \mark \markup { \musicglyph #"scripts.coda" }

   % The coda
   \repeat unfold 6 {
      c4 c c c
    }
    \bar"|."
  }
}
