%% http://lsr.di.unimi.it/LSR/Item?id=699
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/visibility-and-color-of-objects#the-color-property

%LSR after an idea by Trevor Daniels http://lists.gnu.org/archive/html/lilypond-user/2008-09/msg00083.html

\relative c'' {
 a1 a  a
 % place in bottom layer
 -\tweak layer #-1
 -\markup {
   \with-dimensions #'(0 . 0) #'(0 . 0)
   % specify color
   \with-color #(rgb-color 1 0.5 0.5)
   % specify size
   \filled-box #'(-1000 . 1000) #'(-1000 . 4000) #0
 }
 a
}
