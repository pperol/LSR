%% http://lsr.dsi.unimi.it/LSR/Item?id=657

% Will not work in 2.13 or later since define-public-toplevel has been removed

% Updating-remark: reinserted the relevant files from 2.12.3

% Updaring-remark: works now for 2.18 (Feb. 2014)

% Include a file unless it has already been included.  This executes
% in a cloned parser, so all definitions in the included file need to
% be made global with define-public-toplevel.  Include seems to be
% implemented in the lexical analyzer, and I don't see how to do it
% properly at a higher level.  Executing in the main parser appears to
% have the right effect, and produce all desired output, but LilyPond
% ends with a segmentation fault.

%
% In the included file, do lilypond variable defintion
%
%      var = <stuff>
% as
%      #(define-public-toplevel var #{ <stuff> #} )
%
% music function definition
%
%      fname = #(define-music-function <stuff>)
% as
%      #(define-public-toplevel fname (define-music-function <stuff>))
%
% markup definition
%
%      var = \markup { <stuff> }
% as
%      #(define-public-toplevel var (markup <translated-stuff>))
%
% Using the translation described in the LilyPond Notation Manual
% section Markup-construction-in-Scheme
%

#(define-public toplevel-module-define-public! #f)
#(define-public toplevel-module-ref #f)
#(let ((toplevel-module (current-module)))
   (set! toplevel-module-define-public!
         (lambda (symbol value)
           (module-define! toplevel-module symbol value)
           (module-export! toplevel-module (list symbol))))
   (set! toplevel-module-ref
         (lambda (symbol)
           (module-ref toplevel-module symbol))))

#(defmacro-public define-public-toplevel
   (first-arg . rest)
  "Define a public variable or function in the toplevel module:
  (define-public-toplevel variable-name value)
or:
  (define-public-toplevel (function-name . args)
    ..body..)"
  (if (symbol? first-arg)
      ;; (define-public-toplevel symbol value)
      (let ((symbol first-arg)
            (value (car rest)))
        `(toplevel-module-define-public! ',symbol ,value))
      ;; (define-public-toplevel (function-name . args) . body)
      (let ((function-name (car first-arg))
            (arg-list (cdr first-arg))
            (body rest))
        `(toplevel-module-define-public!
          ',function-name
          (let ((proc (lambda ,arg-list
                        ,@body)))
            (set-procedure-property! proc
                                     'name
                                     ',function-name)
            proc)))))

#(if (not (defined? 'includeIfAbsent))
          (define-public-toplevel includeIfAbsent(define-music-function (parser location fileName) (string?)

    (let ((guardName (string-append "Already Got " fileName)))

      (if (not (defined? (string->symbol guardName)))
        (begin

          (primitive-eval (list 'define (string->symbol guardName) #t))

          (ly:parser-parse-string (ly:parser-clone parser) (string-concatenate (list "\\include \"" fileName "\"")))

          (make-music 'SequentialMusic 'void #t))

        (make-music 'SequentialMusic 'void #t))))))

\markup {
  Pointless markup to avoid LSR rejecting the snippet for lack of output
}
