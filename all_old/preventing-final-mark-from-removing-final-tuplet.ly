%% http://lsr.di.unimi.it/LSR/Item?id=705
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-preventing-final-mark-from-removing-final-tuplet

\new Staff {
   \set tupletFullLength = ##t
   \time 1/8
   \tuplet 3/2 { c'16 c'16 c'16 }
   \tuplet 3/2 { c'16 c'16 c'16 }
   \tuplet 3/2 { c'16 c'16 c'16 }
   \override Score.RehearsalMark.break-visibility = ##(#t #t #t)
   \override Score.RehearsalMark.direction = #DOWN
   \override Score.RehearsalMark.self-alignment-X = #RIGHT
% due to issue 2362 the following line is commented
%   \mark "Composed Feb 2007 - Feb 2008"
% and a shorter mark is used.
   \mark "1234"
}

\new Staff {
  \set tupletFullLength = ##t

  \override TupletBracket.full-length-to-extent = ##f

  \time 1/8
  \tuplet 3/2 { c'16 c'16 c'16 }
  \tuplet 3/2 { c'16 c'16 c'16 }
  \tuplet 3/2 { c'16 c'16 c'16 }
  \override Score.RehearsalMark.break-visibility = ##(#t #t #t)
  \override Score.RehearsalMark.direction = #DOWN
  \override Score.RehearsalMark.self-alignment-X = #RIGHT
% due to issue 2362 the following line is commented
%   \mark "Composed Feb 2007 - Feb 2008"
% and a shorter mark is used.
   \mark "1234"
}
