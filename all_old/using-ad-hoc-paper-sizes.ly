%% http://lsr.di.unimi.it/LSR/Item?id=762
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/paper-size-and-automatic-scaling

% define the new format with a unique name and width and height
#(set! paper-alist (cons '("square" . (cons (* 10 cm) (* 10 cm))) paper-alist))

\paper {
% utilize the new format
  #(set-paper-size "square" 'landscape)

  oddHeaderMarkup = \markup {
    \fill-line { "***" "***" }
  }
  oddFooterMarkup = \markup {
    \fill-line { "***" "***" }
  }
}
#(set-global-staff-size 16)

\relative c'' {
  bes a c b
}
