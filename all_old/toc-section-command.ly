%% http://lsr.di.unimi.it/LSR/Item?id=738
%% see also http://lsr.dsi.unimi.it/LSR/Item?id=368
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/table-of-contents

% taken from LSR 368 (http://lsr.dsi.unimi.it/LSR/Item?id=368)
#(define-markup-command (vspace layout props amount) (number?)
  "This produces a invisible object taking vertical space."
  (let ((amount (* amount 3.0)))
       (if (> amount 0)
           (ly:make-stencil "" (cons -1 1) (cons 0 amount))
           (ly:make-stencil "" (cons -1 1) (cons amount amount)))))

% define toc-section commands
#(begin 
  (define-public (set-toc-section! text) #f)
  (define-public (get-toc-section text) #f)
  (let ((toc-section #f))
       (set! set-toc-section! (lambda (text)(set! toc-section text)))
       (set! get-toc-section (lambda ()(begin toc-section)))
  )
)

% define section-aware piece-toc-item-command
piece = #(define-music-function (parser location text) (markup?)
  (begin 
    (if (get-toc-section) (add-toc-item! 'tocCollMarkup (get-toc-section)))
    (set-toc-section! #f)
    (add-toc-item! 'tocPartMarkup text))
)

\paper {
  #(set-paper-size "a5" 'landscape)
  % this will not know the page number!
  tocCollMarkup = \markup { \fill-line { \bold \fromproperty #'toc:text \vspace #1 \null } }
  tocPartMarkup = \markup { \fill-line { \concat { \hspace #2 \fromproperty #'toc:text } \vspace #0 \fromproperty #'toc:page } }
}


% some music pieces ...
\bookpart {
  \markuplist {
    \override-lines #'(baseline-skip . 2.3)
    \table-of-contents
  }
}
#(set-toc-section! "section 1")
\bookpart {
  \piece \markup { "piece 1" }
  \score {
    \relative c' {      
      c d e f g
    }
  }
}
\bookpart {
  \piece \markup { "piece 2" }
  \score {
    \relative c' {
      c d e f
    }
  }
}
#(set-toc-section! "section 2")
\bookpart {
  \piece \markup { "piece 1" }
  \score {
    \relative c' {
      c d e f
    }
  }
}
\bookpart {
  \piece \markup { "piece 2" }
  \score {
    \relative c' {
      c d e f
    }
  }
}
