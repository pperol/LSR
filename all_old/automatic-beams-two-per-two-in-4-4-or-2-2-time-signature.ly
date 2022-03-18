%% http://lsr.di.unimi.it/LSR/Item?id=605
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms


% Automatic beams two per two in 4/4 or 2/2 time signature
%              _____
% Default     | | | |
%              _   _
% Required    | | | |

% LSR: The good way adapted from David Bobroff

% macro for beamed two per two in 2/2 and 4/4 time signature
qBeam = {
        \set beamExceptions =
  	#'(                      
  	   (end .                
  	    (                    
  	     ((1 . 8) . (2 2 2 2))   
  	   )))
}

\score {
  <<
    \new Staff {
      \relative c'' {
        \time 4/4
        g8-"without the macro" g g g g g g g
        g8 g g g4 g8 g g
      }
    }
    %Use the macro
    \new Staff {
      \relative c'' {
        \time 4/4
        \qBeam 
        g8-"with the macro" g g g g g g g
        g8 g g g4 g8 g g
      }
    }
  >>
  \layout {
    \context {
      \Staff
      \numericTimeSignature
    }
  }
}
