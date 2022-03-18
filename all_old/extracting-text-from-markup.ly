%% http://lsr.dsi.unimi.it/LSR/Item?id=747
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/text

% mup = markup argument
% conc = boolean whether to concat or not
#(define (markup->string mup conc)
        (let ((result ""))
             (map (lambda (x)
                          (begin
                            ;; if this is a concat-markup, do not insert blanks between string
                            (if (eq? x concat-markup)(set! conc #t))
                            (if (list? x)
                                (set! result 
                                  ;; if we are concatenating or we start with an empty result, don't add a blank
                                  (if (or conc (string=? result ""))
                                      (string-append result (markup->string x conc))
                                      (string-append result " " (markup->string x conc)))))
                            (if (string? x)
                                (set! result 
                                  ;; if we are concatenating or we start with an empty result, don't add a blank
                                  (if (or conc (string=? result ""))
                                      (string-append result x)
                                      (string-append result " " x))))
                            result))
                  mup)
             result)
)
#(define-markup-command (plain-text layout props arg)(markup?)
                        (interpret-markup layout props (markup (markup->string arg #f))))

ttt = \markup {
  \normal-text { good day and \concat { hello \bold { world } } \italic { and moon }  }
}

\header {
  title = \ttt
  subtitle = \markup { \normal-text { \italic { \plain-text \ttt } } }
}
\relative c' {
  c
}
