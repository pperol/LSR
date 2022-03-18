%% http://lsr.di.unimi.it/LSR/Item?id=614

%LSR modified by P.P.Schneider on Feb.2014 for v2.18

% "\No" markup: create stylized movement number for the instrumentName field.
% syntax example:  instrumentName = \markup \No #"14a"
#(define-markup-command (No layout props n) (string?)
  (define (format-char c)
    (let ((s (string c)))
      (if (number? (string->number s))
          (markup #:hspace 0.125 #:number s #:hspace 0.125)
          (markup #:hspace 0 #:fontsize 2 s))))
  (define (format-string s i)
    (let ((n (string-length s)))
      (if (= n 0)
          (markup #:null)
          (markup (format-char (string-ref s i))
                  (if (= (1+ i) n)
                      (markup #:null)
                      (format-string s (1+ i)))))))
  (let ((i (string-length n)))
    (interpret-markup layout props
     (markup
      #:concat
       (#:concat
        (#:fontsize 2
         "N"
         #:hspace 0
         #:override '(baseline-skip . 0.825)
         #:override '(direction . 1)
         #:dir-column (#:fontsize 2 #:center-align "."
                       #:fontsize 1 #:center-align "o"))
         #:hspace 0.5
         #:concat ((format-string n 0)
                   #:hspace -.8
                   #:fontsize 2 "."))
         #:hspace -2))))

%\markup \No #"7"

%\markup \No #"14a"

\relative c' {
  \set Staff.instrumentName = \markup { \No #"8" }
  % or:
  %\set Staff.instrumentName = \markup\magnify #1.3 \concat { № \hspace#.4 8. \hspace#-2 }
	\time 6/8
	c8 e g c g e 
	c2.
}


