%% http://lsr.di.unimi.it/LSR/Item?id=732

%LSR Contributed by Valentin Villenave http://lists.gnu.org/archive/html/lilypond-user-fr/2010-12/msg00047.html

stemDownRestsUp =
\override Stem.direction =
  #(lambda (grob)
     (let* ((cause (ly:grob-property grob 'cause))
            (parent-cause (ly:grob-property cause 'cause))
            (parent-props (ly:prob-immutable-properties parent-cause))
            (parent-class (assoc-get 'class parent-props)))
       (if (eq? parent-class 'rest-event)
           UP
           DOWN)))

\layout { ragged-right = ##f }
  
\new Staff = "example" {
<<
  \context Voice = "up" { \voiceOne r4 c''4 r2 }
  \context Voice = "down" { \voiceTwo c'1^"normal" }
>>
<<
  \context Voice = "up" { \voiceOne \stemDown r4 c''4 r2 }
  \context Voice = "down" { \voiceTwo c'1^"stemDown" }
>>
<<
  \context Voice = "up" { \voiceOne \stemDownRestsUp r4 c''4 r2 }
  \context Voice = "down" { \voiceTwo c'1^"stemDown, rests Up" }
>>
}
