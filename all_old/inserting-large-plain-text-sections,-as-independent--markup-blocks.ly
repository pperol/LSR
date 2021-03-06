%% http://lsr.dsi.unimi.it/LSR/Item?id=300
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/text

%LSR updated/modified by P.P.Schneider on Feb.2014

\paper {
  ragged-bottom = ##f
}

upper = \relative c'' {
  \clef treble
  \key c \major
  \time 4/4
  a b c d
}

lower = \relative c {
  \clef bass
  \key c \major
  \time 4/4
  a2 c
}

\book {
  \markuplist {
    % put some space here
    \vspace#2
    \justify { 
      Lorem ipsum dolor sit amet consectetuer adipiscing elit,
      sed diam nonummy nibh euismod tincidunt ut laoreet dolore
      magna aliquam erat volutpat. Ut wisi enim ad minim veniam, 
      quis nostrud exerci tation ullamcorper suscipit lobortis
      nisl ut aliquip ex ea commodo consequat. 
    }
    % put some space here
    \vspace#1
    \fill-line {
      \score {
        \new PianoStaff <<
          \set PianoStaff.instrumentName = "Piano  "
          \new Staff = "upper" \upper
          \new Staff = "lower" \lower
        >>
        \layout {}
      }
    }
    % put some space here
    \vspace#1
    \wordwrap { 
      Nam liber tempor cum soluta nobis
      eleifend option congue nihil imperdiet doming id quod mazim
      placerat facer possim assum. Typi non habent claritatem insitam; 
      est usus legentis in iis qui facit eorum claritatem.
      Investigationes demonstraverunt lectores legere me lius quod
      ii legunt saepius. Claritas est etiam processus dynamicus, qui 
      sequitur mutationem consuetudium lectorum. Mirum est notare 
      quam littera gothica, quam nunc putamus parum claram, 
      anteposuerit litterarum formas humanitatis per seacula quarta 
      decima et quinta decima. Eodem modo typi, qui nunc nobis
      videntur parum clari, fiant sollemnes in futurum.
    }
    % put some space here
    \vspace#1
    \score {
      \new PianoStaff <<
        \set PianoStaff.instrumentName = "Piano  "
        \new Staff = "upper" \upper
        \new Staff = "lower" \lower
      >>
      \layout {
        ragged-right = ##f
      }
    }
    % put some space here
    \vspace#1
    \fill-line {
      \override #'(line-width . 60)
      \justify {
        Lorem ipsum dolor sit amet consectetuer adipiscing elit,
        sed diam nonummy nibh euismod tincidunt ut laoreet dolore
        magna aliquam erat volutpat. Ut wisi enim ad minim veniam, 
        quis nostrud exerci tation ullamcorper suscipit lobortis
        nisl ut aliquip ex ea commodo consequat. Duis autem vel eum
        iriure dolor in hendrerit in vulputate velit esse molestie 
        consequat, vel illum dolore eu feugiat nulla facilisis
        at vero eros et accumsan et iusto odio dignissim qui blandit
        praesent luptatum zzril delenit augue duis dolore te feugait 
        nulla facilisi. 
      }
    }
    % put some space here
    \vspace#1
    \fill-line {
      \column {
        \score {
          \new PianoStaff <<
            \set PianoStaff.instrumentName = "Piano  "
            \new Staff = "upper" \upper
            \new Staff = "lower" \lower
          >>
          \layout {}
        }
        % put some space here
        \vspace#1
        \override #'(line-width . 50)
        \justify {
          Nam liber tempor cum soluta nobis
          eleifend option congue nihil imperdiet doming id quod mazim
          placerat facer possim assum. Typi non habent claritatem insitam; 
          est usus legentis in iis qui facit eorum claritatem.
          Investigationes demonstraverunt lectores legere me lius quod
          ii legunt saepius. Claritas est etiam processus dynamicus, qui
        }
      }
      \column {
        \score {
          \new PianoStaff <<
            \set PianoStaff.instrumentName = "Piano  "
            \new Staff = "upper" \upper
            \new Staff = "lower" \lower
          >>
          \layout {}
        }
        % put some space here
        \vspace#1
        \override #'(line-width . 50)
        \justify {
          sequitur mutationem consuetudium lectorum. Mirum est notare 
          quam littera gothica, quam nunc putamus parum claram, 
          anteposuerit litterarum formas humanitatis per seacula quarta 
          decima et quinta decima. Eodem modo typi, qui nunc nobis
          videntur parum clari, fiant sollemnes in futurum.
        }
      }
    }
  }
  \header {
    title = "Lorem ipsum dolor"
  }
}
