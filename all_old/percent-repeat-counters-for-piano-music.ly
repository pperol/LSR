%% http://lsr.dsi.unimi.it/LSR/Item?id=883
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/short-repeats

\relative c' {
  \new PianoStaff <<
    \new Staff {
      \repeat percent 2 { e4 e e e } |
      \repeat percent 2 { 
        f4 f f f |
        d4 d d d 
      }
    }

    \new Dynamics {
      \set countPercentRepeats = ##t
      \repeat percent 2 { s1 } |
      \repeat percent 2 { s1*2 }
    }

    \new Staff {
      \repeat percent 2 { e4 e e e } |
      \repeat percent 2 { 
        f4 f f f |
        d4 d d d 
      } |
    }
  >>
}

\layout {
  \context {
    \Dynamics

    % Add percent repeat engravers.
    \consists "Percent_repeat_engraver"
    \consists "Double_percent_repeat_engraver"

    % Don't display the repeat glyphs.
    \override PercentRepeat.transparent = ##t
    \override DoublePercentRepeat.transparent = ##t

    % Center the counter numbers -- this is easy,
    % since the used feta digits are exactly two staff spaces high.
    \override PercentRepeatCounter.Y-offset = #-1
    \override DoublePercentRepeatCounter.Y-offset = #-1

    % Simply setting the `whiteout' property avoids a clash between
    % the counter and the barline, however, there is no vertical
    % padding which makes the result unsatisfactory.
    %
    % We thus use a hand-made stencil instead to white out 0.5 units
    % above and below the digit.  The code is based on the
    % `stencil-whiteout' function (in file `scm/stencil.scm').
    \override DoublePercentRepeatCounter.stencil =
      #(lambda (grob)
         (let* ((stencil (ly:text-interface::print grob))
                (x-ext (ly:stencil-extent stencil X))
                (y-ext (ly:stencil-extent stencil Y))
                (y-ext (interval-widen y-ext 0.5)))
           (ly:stencil-add
             (stencil-with-color (ly:round-filled-box x-ext y-ext 0.0)
                                 white)
             stencil)))
  }
}
