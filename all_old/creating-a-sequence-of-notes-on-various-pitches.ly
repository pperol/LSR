%% http://lsr.di.unimi.it/LSR/Item?id=302
%% see http://www.lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-creating-a-sequence-of-notes-on-various-pitches

%LSR rewritten on Feb.2014

rhythm =
  #(define-music-function (parser location p) (ly:pitch?)
     "Make the rhythm in Mars (the Planets) at the given pitch"
    #{ \tuplet 3/2 { $p 8 $p $p } $p 4 $p $p 8 $p $p 4 #})

\new Staff {
  \time 5/4
  \rhythm c'
  \rhythm c''
  \rhythm g
}
