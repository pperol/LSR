%% http://lsr.dsi.unimi.it/LSR/Item?id=728
%% http://www.lilypond.org/doc/v2.18/Documentation/notation/creating-footnotes


% Trying to get small(!) footnotes with excerpts from define-markup-commands.scm and toc-init.ly
% TODO parameter for markup styles in paper{} (like 'tocItemMarkup)
% TODO * items, not numbers
% PROBLEM if there are X pages and Y footnotes, the footer-items markup has to loop X*Y through the list of notes!
% TODO collect notes in props ('pageN) on first page, then assoc get -> O( X + Y ) ??

% define the footnote counter
#(define footnr 0)
% to be defined in a closure later (see toc-init.ly)
#(define-public (add-foot-item! dir text) #f)
#(define-public (foot-items) #f)

% define add item and get list functions (taken from toc-init.ly - add-toc-item!)
#(let ((foot-item-list (list)))
     (set! add-foot-item!
       (lambda (dir text)
               (let ((label (gensym "foot")))
                    (set! footnr (+ footnr 1))
                    (set! foot-item-list
                      (cons (list label text footnr)
                            foot-item-list))
                    (make-music 'EventChord
                      'page-marker #t
                      'page-label label
                      'elements (list 
                        (make-music 'LabelEvent 'page-label label)
                        (make-music 'TextScriptEvent 'direction dir 'text (markup #:super #:italic (number->string footnr)))
     )))))
     (set! foot-items (lambda ()
               (reverse foot-item-list))))

% conditionally add text markup, if we are on the right page - helper function for the markup command
#(define (runfi pagelist cur-page table label text fnnr)
        (let ((label-page (and (list? table) (assoc label table))))
             (if (and label-page (= cur-page (cdr label-page)))
                 (markup pagelist #:super #:italic (number->string fnnr) text)
                 pagelist
             )
        )
)

% define markup command to be used in footerMarkup
% delayed stencil-evaluation like in page-ref - so we know the pagenumber of the label and the current page
% needs 'gauge'-stencil --- is calculated from <code>'line-width - <i>reserve</i></code>
#(define-markup-command (footer-items layout props reserve)(number?)
  "markup footer items"
  (let* ((line-width (- (ly:output-def-lookup layout 'line-width) reserve))
         (gauge-stencil (interpret-markup layout props (markup #:super "1" "X" #:draw-line (cons line-width 0) )))
         (x-ext (ly:stencil-extent gauge-stencil X))
         (y-ext (ly:stencil-extent gauge-stencil Y))) 
        (ly:make-stencil
          `(delay-stencil-evaluation
            ,(delay (ly:stencil-expr
                     
                     (let* ((table (ly:output-def-lookup layout 'label-page-table))
                            (cur-page (inexact->exact (string->number (chain-assoc-get 'page:page-number-string props))))
                            (pagelist (markup))
                            (page-number -1))
                           (map (lambda (fn)
                                        (let ((label (car fn))
                                              (text (cadr fn))
                                              (fnnr (caddr fn)))
                                             (set! pagelist (runfi pagelist cur-page table label text fnnr))
                                        )
                                ) (foot-items))
                           (interpret-markup layout props (markup pagelist))
                     )
                     
                   )
          )) x-ext y-ext)))

% the footnote function
% takes direction (UP/DOWN) and markup
% other layout properties can be set via [\once] \override TextScript #'... = ...
addfoot = #(define-music-function (parser location dir text)(integer? markup?)
  (begin (add-foot-item! dir text)
))


\paper {
  #(set-paper-size "a5" 'landscape)
  oddHeaderMarkup = ""
  evenHeaderMarkup = ""
  oddFooterMarkup = \markup { \fill-line {
      % fill in footer-items, reserve 6mm for page-number
      \footer-items #(* (magstep mm) 6)
      \fromproperty #'page:page-number-string
    }
  }
  evenFooterMarkup = \markup { \fill-line {
      \fromproperty #'page:page-number-string
      % fill in footer-items, reserve 6mm for page-number
      \footer-items #(* (magstep mm) 6)
    }
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% some really boaring music with \addfoot

notenA = \relative c' {
  \addfoot #UP \markup { "The C in the beginning is not confirmed!" }
  \repeat unfold 24 { c d e f }
  \addfoot #UP \markup { "This is started on G" }
  { g( f e d) } 
  \repeat unfold 23 { c d e f }
  \bar "|."
}

\bookpart {
  \score {
    \new Staff \new Voice { \notenA }
  }
  \score {
    \relative c' {
      \repeat unfold 10 { c d e f }
      \addfoot #0 \markup { "Test3" }
      \repeat unfold 10 { c d e f }
      \bar "|."
    }
  }
}
\bookpart {
  \score {
    <<
      \new Staff \new Voice = "voc" {
        \relative c' {
          \repeat unfold 10 { c d e f }
          % override TextScript properties to move the number
          \once \override TextScript.self-alignment-X = #RIGHT
          \once \override TextScript.X-offset = #2
          \once \override TextScript.extra-offset = #'(0 . -1)
          \addfoot #DOWN \markup { \italic "mi = \"la\" in ancient ork" }
          \repeat unfold 10 { c d e f }
          \bar "|."
        }
      }
      \new Lyrics \lyricsto "voc" \lyricmode {
        \repeat unfold 10 { la la la la }
        \repeat unfold 10 { mi mi mi mi }
    } >>
    \header {
      piece = "third"
    }
  }
}
