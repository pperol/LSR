%% http://lsr.di.unimi.it/LSR/Item?id=567
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/including-lilypond-files.html

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the code. Paste it into a file you can \include. It's commented out
% because it won't run in -dsafe.

%{
#(use-modules (ice-9 popen))
#(use-modules (ice-9 rdelim))
commit =
#(let* ((port (open-pipe* OPEN_READ "git" "show" "--pretty=format:%H" "--quiet"))
        (str  (read-line port)))
   (close-pipe port)
   str)
%}

% and I use that command like this:
%\header {
%  tagline = \commit
%}

% This is just to give LSR something to compile. It doesn't like empty files.

{ c''4 c'' c'' c'' }
