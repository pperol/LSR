%% http://lsr.dsi.unimi.it/LSR/Item?id=701

\markup {
  \fill-line {
    \score {
      \relative c' {
	c4 d e f \break
      }
      \layout {}
    }
  }
}

\markup {
  \fill-line {
    \score {
      \new Staff \with {
	\remove Time_signature_engraver
      }
      \relative c' {
	g2 f
      }
      \layout {}
    }
  }
}

\markup {
  \fill-line {
    \score {
      \new Staff \with {
	\remove Time_signature_engraver
      }
      \relative c' {
	c4 d e f g a b a
      }
      \layout {}
    }
  }
}

\markup {
  \fill-line {
    \score {
      \new Staff \with {
	\remove Time_signature_engraver
      }
      \relative c' {
	g4 f e g b a g
      }
      \layout {}
    }
  }
}
