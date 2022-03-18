%% http://lsr.di.unimi.it/LSR/Item?id=155
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides


\relative c' {
  cis cis cis! cis?

  cis'4
  \override Staff.AccidentalCautionary.font-size = #-5
  cis?4
  \override Staff.AccidentalCautionary.parenthesized = ##f
  cis?4
  \revert Staff.AccidentalCautionary.font-size
  \revert Staff.AccidentalCautionary.parenthesized
  cis?4

  \set suggestAccidentals = ##t
  cis,4
  \override Staff.AccidentalSuggestion.font-size = #-5
  cis!4
  \override Staff.AccidentalSuggestion.parenthesized = ##t
  cis!4
  \revert Staff.AccidentalSuggestion.font-size
  \revert Staff.AccidentalSuggestion.parenthesized
  cis!4
  \set suggestAccidentals = ##f
  cis!4
}

