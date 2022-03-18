%% http://lsr.di.unimi.it/LSR/Item?id=260
%% see also http://lsr.di.unimi.it/LSR/Item?id=722
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic

%% see doc v-2.18 http://lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides#tweaks-and-overrides-drawing-circles-around-various-objects
%% see doc v-2.19 http://lilypond.org/doc/v2.19/Documentation/snippets/tweaks-and-overrides#tweaks-and-overrides-drawing-circles-around-various-objects

\relative c' {
  c1
  \set Score.markFormatter =
    #(lambda (mark context)
             (make-circle-markup (format-mark-numbers mark context)))
  \mark \default

  c2 d^\markup {
    \override #'(thickness . 3) {
      \circle \finger 2
    }
  }
  \override Score.BarNumber.break-visibility = #all-visible
  \override Score.BarNumber.stencil =
    #(make-stencil-circler 0.1 0.25 ly:text-interface::print)
}
