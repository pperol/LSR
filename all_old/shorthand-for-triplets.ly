%% http://lsr.di.unimi.it/LSR/Item?id=328
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-rhythms#tuplets

% Many many thanks to Mats for this useful snippet!

% First version, with a single argument, i.e. the 
% syntax is \triplet{ c d e }
triplet = #(define-music-function (parser location music) (ly:music?)
  #{ \tuplet 3/2 $music #})


% Second version, with three arguments, i.e. the 
% syntax is \trip c d e 
trip = #(define-music-function (parser location m1 m2 m3) 
  (ly:music? ly:music? ly:music?)
  #{ \tuplet 3/2 { $m1 $m2 $m3 } #})

\score{
  \relative c'{
    % Using \triplet
    c4 \triplet { d8 e f } g4 \triplet { f8 e d16 e } |
    % Using \trip. Note the last beat, where you have to 
    % add curly braces to get exactly three arguments to \trip
    c4 \trip d8 e f g4 \trip f8 e { d16 e } |
  }
}
