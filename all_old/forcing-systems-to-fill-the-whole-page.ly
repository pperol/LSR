%% http://lsr.dsi.unimi.it/LSR/Item?id=371
%% see also http://lilypond.1069038.n5.nabble.com/LSR-v2-18-quot-Forcing-systems-to-fill-the-whole-page-quot-does-not-work-tc159353.html

%LSR uppgraded for v2.18 by Harm on Feb 15, 2014.

\paper { ragged-last-bottom = ##f }

\layout {
  \context {
    \StaffGroup
    \override StaffGrouper.staff-staff-spacing.stretchability = #100
  }
}

m = { c d e f }

\new StaffGroup
  <<
    \new Staff { \m \break \m \break \m }
    \new Staff { \m \m \m }
    \new Staff { \m \m \m }
    \new Staff { \m \m \m }
    \new Staff { \m \m }
    \new Staff { \m \m }
    \new Staff { \m \m }
    \new Staff { \m \m }
    \new Staff { \m }
    \new Staff { \m }
    \new Staff { \m }
    \new Staff { \m }
  >>
