%% http://lsr.di.unimi.it/LSR/Item?id=464
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/align.fr.html

\header{ title= "Aligning columns from different markups" }

#(define-markup-command (columns layout props args) (markup-list?)
   (let ((line-width (/ (chain-assoc-get 'line-width props
                         (ly:output-def-lookup layout 'line-width))
                        (max (length args) 1))))
     (interpret-markup layout props
       (make-line-markup (map (lambda (line)
                                (markup #:pad-to-box `(0 . ,line-width) '(0 . 0)
                                  #:override `(line-width . ,line-width)
                                  line))
                               args)))))

\markup \justify {
  The default "\fill-line" uses columns, where the width is
  calculated from the contents. This means that two markups
  don't align their columns:
}

\markup \fill-line {
  \column { "default column 1" "line 2" }
  \column { "column 2, wider than the rest" "line 2" }
  \column { "c 3" "line 2" }
}
\markup \fill-line {
  \column { "col 1" "line 2" }
  \column{ "col 2" "line 2" }
  \column{ "Here, column 3 is wider." "line 2" }
}

\markup \fill-line {
  \column { "short" "line 2" }
  \column { "Long text, long text" "line 2" }
  \column { "another very long column text" "line 2" }
}

\markup \justify {
  However, one can write a "\columns" macro, which makes each column
  exactly 1/n of the line-width, thus aligning even columns of different
  markups:
}

\markup \columns {
  \column { "default column 1" "line 2" }
  \column { "column 2, wider than the rest" "line 2" }
  \column { "c 3" "line 2" }
}
\markup \columns {
  \column { "col 1" "line 2" }
  \column { "col 2" "line 2" }
  \column { "Here, column 3 is wider" "line 2" }
}
\markup \columns {
  \column { "short" "line 2"}
  \column { "Long text, long text" "line 2" }
  \column {"another very long column text" "line 2" }
}
