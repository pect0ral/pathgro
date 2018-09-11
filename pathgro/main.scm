;;
;; pathgro - combinatoric pathname wordlist expander
;;
;; v1.0 coded by Derek Callaway [derek.callaway (AT) ioactive {D0T} com]
;;

(define-module (pathgro main)
               #:export (main)
               #:use-module (ice-9 common-list)
               #:use-module (ice-9 getopt-long)
               #:use-module (srfi srfi-1))

(use-modules ((pathgro base combine-paths)))
(use-modules ((pathgro base read-pathsfiles)))
(use-modules ((pathgro base path-combos)))
(use-modules ((pathgro base path-kperms)))
(use-modules ((pathgro base path-powerset)))
(use-modules ((pathgro base path-slashes)))
(use-modules ((pathgro base path-strings)))
(use-modules ((pathgro util ansi-color)))
(use-modules ((pathgro util clean-list)))
(use-modules ((pathgro util splitter) #:select (max-depth)))
(use-modules ((pathgro util stdio)))

(define (display-help)
  (newline)
  (display (colorize-string "usage" 'YELLOW 'ON-BLUE 'BOLD 'UNDERLINE))
  (display (colorize-string ": " 'BOLD))
  (display (colorize-string "pathgro" 'WHITE 'ON-GREEN 'BOLD))
  (display " ")
  (display (colorize-string "[<OPTIONS>]" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display " ")
  (display (colorize-string "[<FILES>]" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (newlines 2)
  (display "  ")
  (display (colorize-string "<OPTIONS>" 'BLACK 'ON-GREEN 'UNDERLINE))
  (display "              ")
  (display (colorize-string "one or more of the command line flags below" 'YELLOW))
  (newlines 2)
  (display "  ")
  (display (colorize-string "-v, --version" 'BLACK 'ON-YELLOW 'BOLD 'UNDERLINE))
  (display "          ")
  (display (colorize-string "displays the current software version banner string" 'CYAN))
  (newline)
  (display "  ")
  (display (colorize-string "-h, --help" 'BLACK 'ON-YELLOW  'BOLD 'UNDERLINE))
  (display "             ")
  (display (colorize-string "prints the usage information you're reading now" 'CYAN))
  (newline)
  (display "  ")
  (display (colorize-string "-b, --basename" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "         ")
  (display (colorize-string "show base file names" 'MAGENTA))
  (newline)
  (display "  ")
  (display (colorize-string "-d, --dirname" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "          ")
  (display (colorize-string "display directory names" 'MAGENTA))
  (newline)
  (display "  ")
  (display (colorize-string "-e, --extname" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "          ")
  (display (colorize-string "output file extensions" 'MAGENTA))
  (newline)
  (display "  ")
  (display (colorize-string "-f, --filename" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "         ")
  (display (colorize-string "print full filenames as base with extension" 'MAGENTA))
  (display " ")
  (display (colorize-string "[" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "basename" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD 'UNDERLINE))
  (display (colorize-string "extname" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "]" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-x, --extdirname" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "       ")
  (display (colorize-string "append file extensions to directory names" 'MAGENTA))
  (display "   ")
  (display (colorize-string "[" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "dirname" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD 'UNDERLINE))
  (display (colorize-string "extname" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "]" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-n, --noslash" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "          ")
  (display (colorize-string "remove a forward slash from the start of each path name" 'MAGENTA))
  (newline)
  (display "  ")
  (display (colorize-string "-c, --combos" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "   ")
  (display (colorize-string "CDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "  ")
  (display (colorize-string "generate path names at provided directory depth only" 'MAGENTA))
  (display "       ")
  (display (colorize-string "{" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "n" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "-" 'BLACK 'ON-RED 'BOLD 'UNDERLINE))
  (display (colorize-string "choose" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "-" 'BLACK 'ON-RED 'BOLD 'UNDERLINE))
  (display (colorize-string "r" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "}" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-k, --kperms" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "   ")
  (display (colorize-string "KDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "  ")
  (display (colorize-string "enumerate all directory orderings of specified depth" 'MAGENTA))
  (display "       ")
  (display (colorize-string "{" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "k" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "-" 'BLACK 'ON-RED 'BOLD 'UNDERLINE))
  (display (colorize-string "permutations" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "}" 'WIHTE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-p, --powerset" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display " ")
  (display (colorize-string "PDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "  ")
  (display (colorize-string "compute paths for directory combinations up to given level" 'MAGENTA))
  (display " ")
  (display (colorize-string "{" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "power" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "-" 'BLACK 'ON-RED 'BOLD 'UNDERLINE))
  (display (colorize-string "set" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "}" 'WHITE 'ON-BLACK 'BOLD))
  ;(newline)
  ;(display "  ")
  ;(display (colorize-string "-i, --infix" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  ;(display "  ")
  ;(display (colorize-string "STRING" 'BLACK 'ON-BLUE 'REVERSE 'UNDERLINE))
  ;(display "  ")
  ;(display (colorize-string "infix a string after the last directory slash and before the filename" 'GREEN))
  ;(newline)
  ;(display "  ")
  ;(display (colorize-string "-p, --prefix" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  ;(display " ")
  ;(display (colorize-string "STRING" 'BLACK 'ON-BLUE 'REVERSE 'UNDERLINE))
  ;(display "  ")
  ;(display (colorize-string "prefix each path name with the provided string" 'GREEN))
  ;(newline)
  ;(display "  ")
  ;(display (colorize-string "-s, --suffix" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  ;(display " ")
  ;(display (colorize-string "STRING" 'BLACK 'ON-BLUE 'REVERSE 'UNDERLINE))
  ;(display "  ")
  ;(display (colorize-string "suffix each path name with the provided string" 'GREEN))
  ;(newline)
  ;(display "  ")
  ;(display (colorize-string "-t, --trail" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  ;(display "     ")
  ;(display (colorize-string "append a trailing forward slash character to the end of each path" 'GREEN))
  ;(newline)
  (newlines 2)
  (display "  ")
  (display (colorize-string "<FILES>" 'BLACK 'ON-GREEN 'UNDERLINE))
  (display "                ")
  (display (colorize-string "path names to wordlist files for parsing and expansion" 'YELLOW))
  (newline)
  ;(display "  ")
  ;(display (colorize-string "STRING" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  ;(display "               ")
  ;(display (colorize-string "string to include with created path names by way of prefix, infix and/or suffix" 'BLUE))
  ;(newline)
  (display "  ")
  (display (colorize-string "CDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "                 ")
  (display (colorize-string "maximum number of slashes to allow in computed paths" 'GREEN))
  (display "  ")
  (display (colorize-string "(" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "small" 'BLACK 'ON-BLUE 'UNDERLINE))
  (display (colorize-string ")" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "KDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "                 ")
  (display (colorize-string "how many directories deep to calculate path orderings" 'GREEN))
  (display " ")
  (display (colorize-string "(" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "large" 'BLACK 'ON-BLUE 'UNDERLINE))
  (display (colorize-string ")" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "PDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "                 ")
  (display (colorize-string "generate path subsets up to this level of directories" 'GREEN))
  (display " ")
  (display (colorize-string "(" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "medium" 'BLACK 'ON-BLUE 'UNDERLINE))
  (display (colorize-string ")" 'WHITE 'ON-BLACK 'BOLD))
  (newlines 2)
  (exit 0))

(define (display-version)
  (newline)
  (display (colorize-string "pathgro" 'BLACK 'ON-GREEN 'BOLD))
  (display " ")
  (display (colorize-string "v1.0" 'BLACK 'ON-YELLOW 'UNDERLINE))
  (display " ")
  (display (colorize-string "Copyright (C) 2018" 'BLACK 'ON-CYAN))
  (display " ")
  (display (colorize-string "Derek" 'BLACK 'ON-BLUE)) 
  (display " ")
  (display (colorize-string "Callaway" 'BLACK 'ON-BLUE))
  (display " ")
  (display (colorize-string "[" 'YELLOW 'BOLD))
  (display (colorize-string "derek" 'WHITE 'ON-BLUE 'REVERSE 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-MAGENTA 'REVERSE 'UNDERLINE)) 
  (display (colorize-string "callaway" 'WHITE 'ON-BLUE 'REVERSE 'UNDERLINE))
  (display " ")
  (display (colorize-string "(" 'BLACK 'ON-WHITE)) 
  (display (colorize-string "AT" 'WHITE 'ON-BLACK)) 
  (display (colorize-string ")" 'BLACK 'ON-WHITE))
  (display " ")
  (display (colorize-string "ioactive" 'WHITE 'ON-RED 'BOLD 'REVERSE 'UNDERLINE))
  (display " ")
  (display (colorize-string "{" 'BLACK 'ON-WHITE)) 
  (display (colorize-string "D0T" 'WHITE 'ON-BLACK))
  (display (colorize-string "}" 'BLACK 'ON-WHITE))
  (display " ")
  (display (colorize-string "com" 'WHITE 'ON-RED 'BOLD 'REVERSE 'UNDERLINE))
  (display (colorize-string "]" 'YELLOW 'BOLD))
  (newlines 2)
  (display (colorize-string "This program comes with ABSOLUTELY NO WARRANTY. It is free software and you are welcome to redistribute it" 'RED))
  (newline)
  (display (colorize-string "under certain conditions. See the COPYING.txt file in the root directory of the source repository for details." 'RED))
  (newlines 2)
  (display (colorize-string "https://github.com/decal/pathgro" 'BOLD 'REVERSE 'UNDERLINE))
  (newlines 2)
  (exit 0))

;(define (handle-indexes-helper dirns xinds)
;    (if (null? xinds)
;      '()
;      (map (lambda (z) (list-ref dirns z)) xinds)))

(define (handle-indexes-helper dirns ainds)
  (if (null? ainds)
    '()
    (cons (list-ref dirns (car ainds)) (handle-indexes-helper dirns (cdr ainds)))))

(define (handle-indexes dirns ainds)
  (if (null? ainds)
    '()
    (cons (string-join (handle-indexes-helper dirns (car ainds)) "/") (handle-indexes dirns (cdr ainds)))))

(define (main args) 
  (let* 
    ((option-spec '((help       (single-char #\h))
                    (basename   (single-char #\b))
                    (dirname    (single-char #\d))
                    (extname    (single-char #\e))
                    (filename   (single-char #\f))
                    ;(infix      (single-char #\i))
                    ;(suffix     (single-char #\s))
                    ;(prefix     (single-char #\p))
                    ;(trail      (single-char #\t))
                    (powerset   (single-char #\p) (value #t))
                    (combos     (single-char #\c) (value #t))
                    (kperms     (single-char #\k) (value #t))
                    (extdirname (single-char #\x))
                    (noslash    (single-char #\n))
                    (rmtrail    (single-char #\r))
                    (version    (single-char #\v))))
     (options          (getopt-long args option-spec #:stop-at-first-non-option #t))
     (help-wanted      (option-ref options 'help #f))
     (version-wanted   (option-ref options 'version #f))
     (opt-basename     (option-ref options 'basename #f))
     (opt-dirname      (option-ref options 'dirname #f))
     (opt-extname      (option-ref options 'extname #f))
     (opt-filename     (option-ref options 'filename #f))
     (opt-powerset     (string->number (option-ref options 'powerset "0")))
     (opt-combos       (string->number (option-ref options 'combos "0")))
     (opt-kperms       (string->number (option-ref options 'kperms "0")))
     ;(opt-infix       (option-ref options 'infix ""))
     ;(opt-prefix      (option-ref options 'prefix ""))
     ;(opt-suffix      (option-ref options 'suffix ""))
     (opt-extdirname   (option-ref options 'extdirname #f))
     (opt-noslash      (option-ref options 'noslash #f))
     (opt-rmtrail      (option-ref options 'rmtrail #f)))
    (cond
      (help-wanted
        (display-help))
      (version-wanted
        (display-version))
      (else
        (let ((stripped-args (option-ref options '() '()))
              (pathgro-debug (getenv "PATHGRO_DEBUG")))
          (when (zero? (length stripped-args)) (display-help))
          (read-pathsfiles stripped-args)
          (let ((cfiles (clean (combine-files-helper bases extns)))
                (edirs (clean (combine-files-helper dirns extns))))
                (when opt-noslash (set! prepend-slashes unprepend-slashes))
                (if opt-rmtrail (begin (set! dirns (unappend-slashes dirns))
                                       (set! edirs (unappend-slashes edirs)))
                  (set! unappend-slashes append-slashes))
                (when (and opt-filename (zero? opt-powerset)) (output-list (prepend-slashes cfiles)))
                (when opt-basename   (output-list (prepend-slashes bases)))
                (when (and opt-dirname (zero? opt-powerset)) (output-list (prepend-slashes dirns)))
                (when opt-extname    (output-list (prepend-slashes extns)))
                (when opt-extdirname (output-list (prepend-slashes edirs)))
                (when (< 0 opt-combos) 
                  (let ((cps (path-combos opt-combos cfiles dirns)))
                    (output-list (prepend-slashes (flatten cps)))))
                (when (< 0 opt-kperms)
                  (let ((kps (path-kperms (length dirns) opt-kperms)))
                    (let ((kpx (prepend-slashes (flatten (handle-indexes dirns (list-ref kps (- opt-kperms 1)))))))
                      (output-list (append kpx (combine-paths-helper (append-strings "/" kpx) cfiles))))))
                (when (< 0 opt-powerset)
                  (let ((aps (path-powerset opt-powerset cfiles dirns)))
                    (output-list (prepend-slashes (flatten aps)))))))))
  (when (and (zero? opt-combos) (zero? opt-kperms) (zero? opt-powerset)) (display-help))
  (exit 0)))
