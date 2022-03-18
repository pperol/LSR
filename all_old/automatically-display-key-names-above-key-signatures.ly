%% http://lsr.di.unimi.it/LSR/Item?id=856
%% see also lists.gnu.org/archive/html/lilypond-user/2013-12/msg00828.html

% by Paul Morris

% tonic-num: number of the tonic note 0-6, C=0, B=6
% acc-count: the number of accidentals in the key signature
% acc-type: the accidental sign type, 1/2=sharp, -1/2=flat
% tonic-acc: #f if the tonic note is not sharp or flat, otherwise a pair
% maj-num: number of the tonic note 0-6, if the key sig were major
% mode-num: number of the mode 0-6
% txt-size: size of key name text
% padd: padding between key signature and key name
% mult: for correct resizing when the staff is resized
% C Major, F Major, A Minor, and D Minor each get extra padding 
%   so the name is above the staff

\markup \vspace #1  % needed for proper display in the LSR, remove for use elsewhere

#(define Custom_key_engraver
  (lambda (context)
    `((acknowledgers
      (key-signature-interface . 
       ,(lambda (engraver grob source-engraver)
        (let* (
          (grob-name (lambda (x) (assq-ref (ly:grob-property x 'meta) 'name)))
          (context (ly:translator-context engraver))
          (tonic-pitch (ly:context-property context 'tonic))
          (tonic-num (ly:pitch-notename tonic-pitch))
          (acc-list (ly:grob-property grob 'alteration-alist))
          (acc-type (if (null? acc-list) 0 (cdr (list-ref acc-list 0))))
          (acc-count (length acc-list))
          (tonic-acc (assq tonic-num acc-list))
          (maj-num 0)
          (mode-num 0)          
          (key-name (markup #:null))
          (txt-size 0.7)
          (padd 0.5)
          (mult (magstep (ly:grob-property grob 'font-size 0.0))))
      
          (cond 
            ((= tonic-num 0) (set! key-name (markup "C")))
            ((= tonic-num 1) (set! key-name (markup "D")))
            ((= tonic-num 2) (set! key-name (markup "E")))
            ((= tonic-num 3) (set! key-name (markup "F")))
            ((= tonic-num 4) (set! key-name (markup "G")))
            ((= tonic-num 5) (set! key-name (markup "A")))
            ((= tonic-num 6) (set! key-name (markup "B"))))
            
          (if (pair? tonic-acc) 
            (set! key-name (markup key-name (if (= acc-type 0.5 ) 
              (markup #:translate (cons (* mult -0.3) (* mult 0.8)) #:magnify (* mult 0.9) #:sharp) 
              (markup #:translate (cons (* mult -0.2) (* mult 0.4)) #:magnify (* mult 0.9) #:flat)))))

          (cond 
          ((= acc-type 0) 
            (set! maj-num 0) (set! padd (+ padd (* mult 2.7 ))))
          ((= acc-type 1/2) 
            (cond
            ((= acc-count 1) (set! maj-num 4))
            ((= acc-count 2) (set! maj-num 1))
            ((= acc-count 3) (set! maj-num 5))
            ((= acc-count 4) (set! maj-num 2))
            ((= acc-count 5) (set! maj-num 6))
            ((= acc-count 6) (set! maj-num 3))
            ((= acc-count 7) (set! maj-num 0))
          ))
          ((= acc-type -1/2)
            (cond
            ((= acc-count 1) (set! maj-num 3) (set! padd (+ padd (* mult 1.2 ))))
            ((= acc-count 2) (set! maj-num 6))
            ((= acc-count 3) (set! maj-num 2))
            ((= acc-count 4) (set! maj-num 5))
            ((= acc-count 5) (set! maj-num 1))
            ((= acc-count 6) (set! maj-num 4))
            ((= acc-count 7) (set! maj-num 0))
          )))
          (set! mode-num (modulo (- tonic-num maj-num) 7))
          (cond 
            ((= mode-num 0) (set! key-name (markup key-name "Major")))
            ((= mode-num 1) (set! key-name (markup key-name "Dorian")))
            ((= mode-num 2) (set! key-name (markup key-name "Phrygian")))
            ((= mode-num 3) (set! key-name (markup key-name "Lydian")))
            ((= mode-num 4) (set! key-name (markup key-name "Mixolydian")))
            ((= mode-num 5) (set! key-name (markup key-name "Minor")))
            ((= mode-num 6) (set! key-name (markup key-name "Locrian"))))
          
          (if (eq? 'KeyCancellation (grob-name grob))
            (ly:grob-set-property! grob 'stencil (ly:key-signature-interface::print grob))
            (ly:grob-set-property! grob 'stencil 
            
              (ly:stencil-combine-at-edge 
                (ly:key-signature-interface::print grob) 
                1 1 
                (ly:stencil-scale (grob-interpret-markup grob key-name) 
                txt-size txt-size)
                padd ))))))))))
\layout {
  \context {
    \Staff
    \consists \Custom_key_engraver
  }
}

\new Staff \relative c'' {

  \key c \major
  c1
  \key a \minor
  a1
  \key a \major 
  a1
  \key fis \minor
  fis1 
  \key ees \major 
  ees1
  \key c \minor
  c'1
  \key c \dorian
  c1
  \key c \phrygian
  c1
  \key c \lydian
  c1
  \key c \mixolydian
  c1
  \key c \locrian
  c1
}

% 2.16.0 code
%{
#(define Custom_key_engraver
  (make-engraver
    (acknowledgers
      ((key-signature-interface engraver grob source-engraver)
        (let* (
          (grob-name (lambda (x) (assq-ref (ly:grob-property x 'meta) 'name)))
          (context (ly:translator-context engraver))
          (tonic-pitch (ly:context-property context 'tonic))
          (tonic-num (ly:pitch-notename tonic-pitch))
          (acc-list (ly:grob-property grob 'alteration-alist))
          (acc-type (if (null? acc-list) 0 (cdr (list-ref acc-list 0))))
          (acc-count (length acc-list))
          (tonic-acc (assq tonic-num acc-list))
          (maj-num 0)
          (mode-num 0)          
          (key-name #{ \markup {} #})
          (txt-size 0.7)
          (padd 0.5)
          (mult (magstep (ly:grob-property grob 'font-size 0.0)))
          (txt-sharp #{ \markup { \translate #(cons (* mult -0.3) (* mult 0.8)) \magnify #(* mult 0.9) \sharp } #})
          (txt-flat  #{ \markup { \translate #(cons (* mult -0.2) (* mult 0.4)) \magnify #(* mult 0.9) \flat  } #}))
      
          (cond 
            ((= tonic-num 0) (set! key-name #{ \markup {C} #} ))
            ((= tonic-num 1) (set! key-name #{ \markup {D} #} ))
            ((= tonic-num 2) (set! key-name #{ \markup {E} #} ))
            ((= tonic-num 3) (set! key-name #{ \markup {F} #} ))
            ((= tonic-num 4) (set! key-name #{ \markup {G} #} ))
            ((= tonic-num 5) (set! key-name #{ \markup {A} #} ))
            ((= tonic-num 6) (set! key-name #{ \markup {B} #} )))
            
          (if (pair? tonic-acc) 
            (set! key-name #{ \markup { #key-name #(if (= acc-type 0.5 ) txt-sharp txt-flat ) } #} ))

          (cond 
          ((= acc-type 0) 
            (set! maj-num 0) (set! padd (+ padd (* mult 2.7 ))))
          ((= acc-type 1/2) 
            (cond
            ((= acc-count 1) (set! maj-num 4))
            ((= acc-count 2) (set! maj-num 1))
            ((= acc-count 3) (set! maj-num 5))
            ((= acc-count 4) (set! maj-num 2))
            ((= acc-count 5) (set! maj-num 6))
            ((= acc-count 6) (set! maj-num 3))
            ((= acc-count 7) (set! maj-num 0))
          ))
          ((= acc-type -1/2)
            (cond
            ((= acc-count 1) (set! maj-num 3) (set! padd (+ padd (* mult 1.2 ))))
            ((= acc-count 2) (set! maj-num 6))
            ((= acc-count 3) (set! maj-num 2))
            ((= acc-count 4) (set! maj-num 5))
            ((= acc-count 5) (set! maj-num 1))
            ((= acc-count 6) (set! maj-num 4))
            ((= acc-count 7) (set! maj-num 0))
          )))
          (set! mode-num (modulo (- tonic-num maj-num) 7))
          (cond 
            ((= mode-num 0) (set! key-name #{ \markup { #key-name Major} #} ))
            ((= mode-num 1) (set! key-name #{ \markup { #key-name Dorian} #} ))
            ((= mode-num 2) (set! key-name #{ \markup { #key-name Phrygian} #} ))
            ((= mode-num 3) (set! key-name #{ \markup { #key-name Lydian} #} ))
            ((= mode-num 4) (set! key-name #{ \markup { #key-name Mixolydian} #} ))
            ((= mode-num 5) (set! key-name #{ \markup { #key-name Minor} #} ))
            ((= mode-num 6) (set! key-name #{ \markup { #key-name Locrian} #} )))
          
          (if (eq? 'KeyCancellation (grob-name grob))
            (ly:grob-set-property! grob 'stencil (ly:key-signature-interface::print grob))
            (ly:grob-set-property! grob 'stencil 
            
              (ly:stencil-combine-at-edge 
                (ly:key-signature-interface::print grob) 
                1 1 
                (ly:stencil-scale (grob-interpret-markup grob key-name) 
                txt-size txt-size)
                padd ))))))))
\layout {
  \context {
    \Staff
    \consists \Custom_key_engraver
  }
}
%}
% end of 2.16.0 code
