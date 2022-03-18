%% http://lsr.di.unimi.it/LSR/Item?id=758
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/visibility-of-objects

SampleMusic = { cis cis cis! cis? }

LongMusic = {
  \SampleMusic

  \override Voice.Accidental.stencil = ##f
  \SampleMusic
  
  \override Voice.AccidentalCautionary.stencil = ##f
  \SampleMusic
  
  \revert Voice.Accidental.stencil
  \revert Voice.AccidentalCautionary.stencil
  \SampleMusic
}

<<
  \relative c'' {
    \LongMusic
  }
\\
  \relative c' {
    \SampleMusic
    \SampleMusic
    \SampleMusic
    \SampleMusic
  }
>>
