%% http://lsr.dsi.unimi.it/LSR/Item?id=543

#(define counter-alist '())

#(define-markup-command (counter layout props name) (string?)
  "Increases and prints out the value of the given counter named @var{name}.
  If the counter does not yet exist, it is initialized with 1."
  (let* ((oldval (assoc-ref counter-alist name))
         (newval (if (number? oldval) (+ oldval 1) 1)))
  (set! counter-alist (assoc-set! counter-alist name newval))
  (interpret-markup layout props
    (markup (number->string newval)))))

#(define-markup-command (setcounter layout props name value) (string? number?)
  "Set the given counter named @var{name} to the given @var{value} and prints
  out the value. The counter does not yet have to exist."
  (set! counter-alist (assoc-set! counter-alist name (- value 1)))
  (interpret-markup layout props (make-counter-markup name)))

\markup { Initial value of the counter: \counter #"mycounter". Second call: \counter #"mycounter" }
\markup { It is increasing: \counter #"mycounter" }
\markup { A second counter: \counter #"myothercounter" }
\markup { First counter is increasing: \counter #"mycounter" }
\markup { Second counter is increasing: \counter #"myothercounter" }
\markup { Setting to a specific value works, too: }
\markup { Set first counter to 15: \setcounter #"mycounter" #15 }
\markup { It is increasing: \counter #"mycounter" }
\markup { It is increasing: \counter #"mycounter" }
\markup { It is increasing: \counter #"mycounter" }
\markup { It is increasing: \counter #"mycounter" }
\markup { It is increasing: \counter #"mycounter" }
\markup { Second counter is increasing: \counter #"myothercounter" }
