%% http://lsr.dsi.unimi.it/LSR/Item?id=632

%LSR modified by P.P.Schneider on Feb.2014 for v2.18
%=> http://lilypond.1069038.n5.nabble.com/LSR-v-2-18-quot-Bar-chords-notation-for-Guitar-quot-tt159278.html


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Prefix = \markup {
  %% uncomment/comment these lines for C, C slashed, B or B slashed prefix :
  %\roman C
  \combine \roman C \translate #'(0.65 . -0.25) \override #'(thickness . 1.2) \draw-line #'(0 . 1.8)
  %\roman B
  %\combine \roman B \translate #'(0.65 . -0.25) \override #'(thickness . 1.2) \draw-line #'(0 . 1.8)
  %%%%%%%%%%%%
  \hspace #0.2
}

startBarre = 
#(define-event-function (parser location str) (string?)
  (let* ((mrkp (markup #:upright #:concat (Prefix str " "))))

    (define (width grob text-string)
      (let* ((layout (ly:grob-layout grob))
             (props (ly:grob-alist-chain 
                       grob 
                       (ly:output-def-lookup layout 'text-font-defaults))))
      (interval-length 
         (ly:stencil-extent 
           (interpret-markup layout props (markup text-string)) 
           X))))
    #{  
      \tweak TextSpanner.after-line-breaking 
        #(lambda (grob)
          (let* ((mrkp-width (width grob mrkp))
                 (line-thickness (ly:staff-symbol-line-thickness grob)))
           (ly:grob-set-nested-property! 
             grob 
             '(bound-details left padding) 
             (+ (/ mrkp-width -4) (* line-thickness 2)))))
      \tweak TextSpanner.font-size -2
      \tweak TextSpanner.style #'line
      \tweak TextSpanner.bound-details.left.text #mrkp
      \tweak TextSpanner.bound-details.left.padding 0.25
      \tweak TextSpanner.bound-details.left.attach-dir -1
      \tweak TextSpanner.bound-details.left-broken.text ##f
      \tweak TextSpanner.bound-details.left-broken.attach-dir -1
      %% adjust the numeric values to fit your needs:
      \tweak TextSpanner.bound-details.left-broken.padding 1.5
      \tweak TextSpanner.bound-details.right-broken.padding 0
      \tweak TextSpanner.bound-details.right.padding 0.25
      \tweak TextSpanner.bound-details.right.attach-dir 2
      \tweak TextSpanner.bound-details.right-broken.text ##f
      \tweak TextSpanner.bound-details.right.text
        \markup \draw-line #'(0 . -0.75)
      \startTextSpan 
    #}))

stopBarre = \stopTextSpan

%% Syntax: note \startBarre "text"  notes \stopBarre (text = any fret number)
%% Example:


{ 
  \clef "G_8" 
  \key d\minor
  << 
    {
      \stemUp 
       a'16[ \startBarre "III"  bes d' bes f'8] \stopBarre
    } 
    \\ 
    {
      \stemDown d2
    } 
  >>
}
