%% http://lsr.dsi.unimi.it/LSR/Item?id=659
%% see also http://lilypond.1069038.n5.nabble.com/LSR-v-218-quot-Forcing-measure-width-to-adapt-to-MetronomeMark-s-width-quot-does-not-work-anymore-tc159350.html

%LSR modified by P.P.Schneider on Feb 15, 2014;

tempoWidth =
#(define-music-function (parser location rest text) (ly:music? string?)
    (let ((text-event
                (make-music
                    'MultiMeasureTextEvent                    
                    'text    
                    (markup #:column (#:bold #:left-align text))))
            (result (ly:music-deep-copy rest)))
        (set! (ly:music-property result 'articulations)
            (cons text-event (ly:music-property rest 'articulations)))
        #{
          \once\override MultiMeasureRestText.springs-and-rods =
            #ly:multi-measure-rest::set-text-rods
            $result
        #} ))

{
  \compressFullBarRests
  \tempo "Allegro"
  R1*6
  \tempo "Rall."
  R1*2
  \tempo "A tempo"
  R1*8
  R1
  %\metroWidth R1 #"Allegro"
  %\tempo "Allegro"
  \tempoWidth R1*6 #"Allegro"
  \tempoWidth R1*2 #"Rall."
  \tempoWidth R1*8 #"A tempo"
}
