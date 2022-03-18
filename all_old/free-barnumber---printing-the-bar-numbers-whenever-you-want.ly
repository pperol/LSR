%% http://lsr.dsi.unimi.it/LSR/Item?id=431

num =
#(define-music-function (parser location musique) (ly:music?)
    #{ 
      \override Score.BarNumber.break-visibility = ##(#f #t #t)
      $musique 
      \revert Score.BarNumber.break-visibility 
    #})
  
{
  a2 a a a
  \num a a a a 
  \num {a a a a} 
  a a a a
}
