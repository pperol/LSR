% Remark:
% Double sharp and double flat are not defined in all glyph-name-alists.
% In this case they will not be printed and a log-warning appears.
%
% Warnings may be suppressed using 'ly:expect-warning'
% Or use the here defined 'suppressWarning'-function, working since 2.20.
%   
%   suppressWarning =
%   #(define-void-function (amount message)(number? string?)
%     (for-each
%       (lambda (warning)
%         (ly:expect-warning message))
%       (iota amount 1 1)))
%       
%   \suppressWarning 8 "Could not find glyph-name"

\relative c'' {
      \time 5/4
      \override Staff.Accidental.glyph-name-alist = #standard-alteration-glyph-name-alist
      cisis^\markup { \typewriter default } cis c ces ceses 
      \override Staff.Accidental.glyph-name-alist = #alteration-hufnagel-glyph-name-alist
      cisis^\markup { \typewriter hufnagel } cis c ces ceses 
      \override Staff.Accidental.glyph-name-alist = #alteration-medicaea-glyph-name-alist
      cisis^\markup { \typewriter medicaea } cis c ces ceses 
      \override Staff.Accidental.glyph-name-alist = #alteration-vaticana-glyph-name-alist
      cisis^\markup { \typewriter vaticana } cis c ces ceses 
      \override Staff.Accidental.glyph-name-alist = #alteration-mensural-glyph-name-alist
      cisis^\markup { \typewriter mensural } cis c ces ceses 
}
