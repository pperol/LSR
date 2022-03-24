%% Remark: with 2.22 warnings are emitted:
%% warning: unterminated slur
%% This is issue 5389
%% https://gitlab.com/lilypond/lilypond/-/issues/5389

% Warnings may be suppressed using 'ly:expect-warning'
% Or use the here defined 'suppressWarning'-function, working since 2.20.
%
%   suppressWarning =
%   #(define-void-function (amount message)(number? string?)
%     (for-each
%       (lambda (warning)
%         (ly:expect-warning message))
%       (iota amount 1 1)))
%
%   \suppressWarning 2 "unterminated slur"

musicUp = \relative c'' {
  \time 4/4
  a4 c4.( g8) a4 |
  g4 e' g,( a8 b) |
  c b a2.
}

musicDown = \relative c'' {
  g4 e4.( d8) c4 |
  r2 g'4( f8 e) |
  d2 \stemDown a
}

\score {
  <<
    <<
    \new Staff {
      \set Staff.instrumentName = #"Standard polyphony"
      << \musicUp \\ \musicDown >>
    }
    \new Staff \with { printPartCombineTexts = ##f } {
      \set Staff.instrumentName = #"PartCombine without texts"
      \partcombine \musicUp \musicDown
    }
    \new Staff {
      \set Staff.instrumentName = #"PartCombine with texts"
      \partcombine \musicUp \musicDown
    }
    >>
  >>
  \layout {
    indent = 6.0\cm
    \context {
      \Score
      \override SystemStartBar.collapse-height = #30
    }
  }
}
