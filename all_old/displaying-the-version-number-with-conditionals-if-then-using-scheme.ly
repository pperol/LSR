%% http://lsr.di.unimi.it/LSR/Item?id=264


#(if (not (defined? 'pieceTagLine))
  (define pieceTagLine (string-append "You are running version " (lilypond-version))))

\header{
  title = \pieceTagLine
}

{ c'4 }
