%% http://lsr.dsi.unimi.it/LSR/Item?id=333
%% see also http://lilypond.1069038.n5.nabble.com/LSR-v2-18-quot-Free-Meter-increasing-the-barnumber-quot-does-not-work-tc159360.html

\markup\magnify #1.5 "This snippet needs v2.18 upgrade"

% many thanks to Rune Zedeler for this snippet

%{
%%% BEGIN %%%
increaseBarNumber = \applyContext
#(lambda (x)
  (let ((measurepos (ly:context-property x 'measurePosition)))
   ; Only increase bar number if not at start of measure.
   ; This way we ensure that you won't increase bar number twice
   ; if two parallel voices call increaseBarNumber simultanously:
   (if (< 0 (ly:moment-main-numerator measurepos)) ; ugh. ignore grace part
    (begin
     (ly:context-set-property!
      (ly:context-property-where-defined x 'internalBarNumber)
      'internalBarNumber
      (1+ (ly:context-property x 'internalBarNumber)))
     (ly:context-set-property!
      (ly:context-property-where-defined x 'currentBarNumber)
      'currentBarNumber
      (1+ (ly:context-property x 'currentBarNumber)))
     ; set main part of measurepos to zero, leave grace part as it is:
     (ly:context-set-property!
      (ly:context-property-where-defined x 'measurePosition)
      'measurePosition
      (ly:make-moment 0 1
       (ly:moment-grace-numerator measurepos)
       (ly:moment-grace-denominator measurepos)))))))

% Named Increasing BAR
nibar = #(define-music-function (parser location x) (string?)
#{
  \bar $x
  \increaseBarNumber
#})

% Increasing BAR
ibar = \nibar "|"

{
  \new Staff \with { \remove Time_signature_engraver } {
    \cadenzaOn
    \accidentalStyle modern-cautionary
    \key a \major
    \repeat unfold 2 {
      c'8 dis' eis'  eis' \ibar
      c'4 dis'  e' eis' \nibar "||"
      c' dis' eis'8 dis' eis' \ibar
      c'1 dis' eis' eis'2 \nibar "|."
    }
  }
}
%%% END %%% 
%}