%% http://lsr.dsi.unimi.it/LSR/Item?id=485

har =
#(define-music-function (parser location note) (ly:music?)
  (set!
   (ly:music-property note 'tweaks)
   (acons 'style 'harmonic-mixed
   (ly:music-property note 'tweaks)))
  note) 
  
{
 <c' \har c''>2 <c' \har c''>4 <c' \har c''>8 <c' \har c''>
}
