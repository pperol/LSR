%% http://lsr.di.unimi.it/LSR/Item?id=382
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks


parenF = #(make-dynamic-script 
           (markup #:line (#:normal-text #:italic
             #:fontsize 2 "(" #:hspace -0.8 #:dynamic "f" #:normal-text
             #:italic #:fontsize 2 ")")))

\relative c'' {
  c4\parenF c c \dynamicUp c\parenF
}
