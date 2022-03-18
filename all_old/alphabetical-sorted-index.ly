%% http://lsr.di.unimi.it/LSR/Item?id=763
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/table-of-contents


% Usage:
% - define and index item with \indexItem $sortstring $markup
% - use \indexSection $sortstring $markup to divide the index into several sections
% - display the alphabetical index with \markuplist \index

% code ist mostly taken from ./ly/toc-init.ly and just renamed and slightly modfied

%% defined later, in a closure
#(define-public (add-index-item! markup-symbol text sorttext) #f)
#(define-public (index-items) #f)

#(let ((index-item-list (list)))
   (set! add-index-item!
   (lambda (markup-symbol text sorttext)
     (let ((label (gensym "index")))
       (set! index-item-list
       ;; We insert index items sorted from the beginning on and do
       ;; not sort them later - this saves pretty much computing time
       (insert-alphabetical-sorted! (list label markup-symbol text sorttext)
       index-item-list))
       (make-music 'EventChord
         'page-marker #t
         'page-label label
         'elements (list (make-music 'LabelEvent
         'page-label label))))))
   (set! index-items (lambda ()
         index-item-list)))

#(define (insert-alphabetical-sorted! iitem ilist)
  (if
    (null? ilist) (list iitem)
    (if
      (string-ci<? (cadddr iitem) (cadddr (car ilist))) (cons iitem ilist)
      (cons (car ilist) (insert-alphabetical-sorted! iitem (cdr ilist)))
    )
  )
)

\paper {
  indexTitleMarkup = \markup \column {
    \fontsize #5 \sans \bold \fill-line { \null "Alphabetical Index" \null }
    \hspace #1
  }
  indexItemMarkup = \markup \large \fill-line {
    \fromproperty #'index:text
    \fromproperty #'index:page
  }
  indexSectionMarkup = \markup \column {
    \hspace #1
    \fill-line { \sans \bold \fontsize #3 \fromproperty #'index:text }
    \hspace #1
  }

}

#(define-markup-list-command (index layout props) ()
  ( _i "Outputs an alphabetical sorted index, using the paper
  variable @code{indexTitleMarkup} for its title, then the list of
  lines built using the @code{indexItem} music function
  Usage: @code{\\markuplist \\index}" )
  (cons (interpret-markup layout props
        (ly:output-def-lookup layout 'indexTitleMarkup))
  (space-lines (chain-assoc-get 'baseline-skip props)
        (map (lambda (index-item)
         (let ((label (car index-item))
         (index-markup (cadr index-item))
         (text (caddr index-item)))
           (interpret-markup
             layout
             (cons (list (cons 'index:page
              (markup #:page-ref label "XXX" "?"))
             (cons 'index:text text))
             props)
             (ly:output-def-lookup layout index-markup))))
       (index-items)))))

indexItem =
#(define-music-function (parser location sorttext text) (string? markup?)
   "Add a line to the alphabetical index, using the @code{indexItemMarkup} paper variable markup."
   (add-index-item! 'indexItemMarkup text sorttext))

indexSection =
#(define-music-function (parser location sorttext text) (string? markup?)
   "Add a section line to the alphabetical index, using @code{indexSectionMarkup} paper variable markup. This can be used to divide the alphabetical index into different sections, for example one section for each first letter."
   (add-index-item! 'indexSectionMarkup text sorttext))


% ---------------------------------------------------------------
% Example

\markuplist \index

\indexSection #"B" \markup { "B" }
\indexSection #"K" \markup { "K" }
\indexSection #"Z" \markup { "Z" }


  \score {
    \relative c' {
      \repeat unfold 10 { c d e f }
      \indexItem #"Karola" \markup{ "Karola" }
      \repeat unfold 10 { c d e f }
      \bar "|."
    }
    \header {
      piece = "first piece"
    }
  }
  \score {
    <<
      \new Staff \new Voice = "voc" {
        \relative c' {
          \indexItem #"Zora" \markup { \italic "Zora" }
          \repeat unfold 10 { c d e f }
          \indexItem #"Bettina" \markup { \larger "Bettina" }
          \indexItem #"Barbara" \markup { \smallCaps "Barbara" }
          \repeat unfold 10 { c d e f }
          \bar "|."
        }
      }
      \new Lyrics \lyricsto "voc" \lyricmode {
        \repeat unfold 10 { la la la la }
        \repeat unfold 10 { mi mi mi mi }
    } >>
    \header {
      piece = "second piece"
    }
  }
