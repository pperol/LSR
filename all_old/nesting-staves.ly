%% http://lsr.dsi.unimi.it/LSR/Item?id=397
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/displaying-staves.html#nested-staff-groups

\new StaffGroup
\relative c'' <<
  \set StaffGroup.systemStartDelimiterHierarchy
    = #'(SystemStartSquare (SystemStartBrace (SystemStartBracket a
                             (SystemStartSquare b)  ) c ) d)
  \new Staff { c1 }
  \new Staff { c1 }
  \new Staff { c1 }
  \new Staff { c1 }
  \new Staff { c1 }
>>
