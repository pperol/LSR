%% http://lsr.dsi.unimi.it/LSR/Item?id=274
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-generating-random-notes

\score {
  {
    $(let ((random-state (seed->random-state (current-time))))
       (make-sequential-music
         (map (lambda (x)
                (let ((idx (random 12 random-state)))
                  (make-event-chord
                   (list
                    (make-music 'NoteEvent
                                'duration (ly:make-duration 2 0 1/1)
                                'pitch (ly:make-pitch
                                        (quotient idx 7)
                                        (remainder idx 7)
                                        0))))))
              (make-list 24))))
  }
}
