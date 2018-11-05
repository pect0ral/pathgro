;;
;; display command line usage in full technicolor
;;

(define-module (pathgro help)
  #:export (display-help))

(use-modules (pathgro util ansi-color) (pathgro util stdio))

(define (display-help)
  (display (colorize-string "usage" 'YELLOW 'ON-BLUE 'BOLD 'UNDERLINE))
  (display (colorize-string ": " 'BOLD))
  (display (colorize-string "pathgro" 'WHITE 'ON-GREEN 'BOLD))
  (display " ")
  (display (colorize-string "[" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "<OPTIONS>" 'BLACK 'ON-GREEN 'UNDERLINE))
  (display (colorize-string "]" 'WHITE 'ON-BLACK 'BOLD))
  (display " ")
  (display (colorize-string "[" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "<FILES>" 'BLACK 'ON-GREEN 'UNDERLINE))
  (display (colorize-string "]" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (newline)
  (display "  ")
  (display (colorize-string "-b, --basename" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "         ")
  (display (colorize-string "show base filenames without directories or extensions" 'MAGENTA))
  (newline)
  (display "  ")
  (display (colorize-string "-d, --dirname" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "          ")
  (display (colorize-string "display directory names separate from filenames" 'MAGENTA))
  (newline)
  (display "  ")
  (display (colorize-string "-e, --extname" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "          ")
  (display (colorize-string "output file extensions with no basenames and no directory names" 'MAGENTA))
  (newline)
  (display "  ")
  (display (colorize-string "-n, --noslash" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "          ")
  (display (colorize-string "delete slash character(s) from start of each path name" 'MAGENTA))
  (newline)
  (display "  ")
  (display (colorize-string "-r, --rmtrail" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "          ")
  (display (colorize-string "remove forward slash(es) from end of each path string" 'MAGENTA))
  (newline)
  (display "  ")
  (display (colorize-string "-t, --traverse" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "         ")
  (display (colorize-string "inject path name traversal syntaxes" 'MAGENTA))
  (newline)
  (display "  ")
  (display (colorize-string "-g, --generate" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "         ")
  (display (colorize-string "generate and test a.k.a. brute-force search" 'MAGENTA))
  (display "    ")
  (display (colorize-string "[" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "basename" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "[" 'BLACK 'ON-WHITE 'BOLD))
  (display (colorize-string "extname" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "[" 'BLACK 'ON-WHITE 'BOLD))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "]" 'BLACK 'ON-WHITE 'BOLD))
  (display (colorize-string "]" 'BLACK 'ON-WHITE 'BOLD))
  (display (colorize-string "%" 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "["  'BLACK 'ON-WHITE 'BOLD))
  (display (colorize-string "00" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "-" 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "FF" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "]" 'BLACK 'ON-WHITE 'BOLD))
  (display (colorize-string "]" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-m, --macos" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "            ")
  (display (colorize-string "format filenames as MacOS dot-underscore files" 'MAGENTA))
  (display " ")
  (display (colorize-string "[" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "._" 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "basename" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "extname" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "]" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-s, --saves" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "            ")
  (display (colorize-string "format filenames as Emacs auto-save files" 'MAGENTA))
  (display "      ")
  (display (colorize-string "[" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "#" 'BLACK 'ON-CYAN 'BOLD 'UNDERLINE))
  (display (colorize-string "basename" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "extname" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "#" 'BLACK 'ON-CYAN 'BOLD 'UNDERLINE))
  (display ", ")
  (display (colorize-string "basename" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "extname" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "~" 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "]" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-f, --filename" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "         ")
  (display (colorize-string "print full filenames as base and extension" 'MAGENTA))
  (display "     ")
  (display (colorize-string "[" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "basename" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "extname" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "]" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-x, --xtdirname" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "        ")
  (display (colorize-string "append file extensions to directory names" 'MAGENTA))
  (display "      ")
  (display (colorize-string "[" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "dirname" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "extname" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "]" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-v, --vimswap" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "          ")
  (display (colorize-string "format path names as VIM swap files" 'MAGENTA))
  (display "            ")
  (display (colorize-string "[" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "basename" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "extname" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "sw" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "["  'BLACK 'ON-WHITE 'BOLD))
  (display (colorize-string "p" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "-" 'BLACK 'ON-CYAN 'BOLD))
  (display (colorize-string "z" 'BLACK 'ON-CYAN 'UNDERLINE))
  (display (colorize-string "]" 'BLACK 'ON-WHITE 'BOLD))
  (display (colorize-string "]" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-C, --Combos" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "   ")
  (display (colorize-string "CDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "  ")
  (display (colorize-string "calculate path names at provided directory level only" 'MAGENTA))
  (display " ")
  (display (colorize-string "{" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "n" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "-" 'BLACK 'ON-RED 'BOLD))
  (display (colorize-string "choose" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "-" 'BLACK 'ON-RED 'BOLD))
  (display (colorize-string "r" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "}" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-P, --Powerset" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display " ")
  (display (colorize-string "PDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "  ")
  (display (colorize-string "compute all directory combinations up to given height" 'MAGENTA))
  (display " ")
  (display (colorize-string "{" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "n" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "-" 'BLACK 'ON-RED 'BOLD))
  (display (colorize-string "subsets" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "}" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "-K, --Kperms" 'BLACK 'ON-GREEN 'BOLD 'UNDERLINE))
  (display "   ")
  (display (colorize-string "KDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "  ")
  (display (colorize-string "enumerate all folder orderings of specified depth" 'MAGENTA))
  (display "     ")
  (display (colorize-string "{" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "k" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "-" 'BLACK 'ON-RED 'BOLD))
  (display (colorize-string "permutations" 'BLACK 'ON-RED 'UNDERLINE))
  (display (colorize-string "}" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (newline)
  (display "  ")
  (display (colorize-string "<OPTIONS>" 'BLACK 'ON-GREEN 'UNDERLINE))
  (display "              ")
  (display (colorize-string "one or more of the command line flags shown here" 'YELLOW))
  (newline)
  (display "  ")
  (display (colorize-string "<FILES>" 'BLACK 'ON-GREEN 'UNDERLINE))
  (display "                ")
  (display (colorize-string "locations of wordlist files to parse and expand upon" 'YELLOW))
  (newline)
  (display "  ")
  (display (colorize-string "CDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "                 ")
  (display (colorize-string "maximum number of slashes to allow in computed paths" 'GREEN))
  (display "  ")
  (display (colorize-string "|" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "small" 'BLACK 'ON-BLUE 'UNDERLINE))
  (display (colorize-string "|" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "PDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "                 ")
  (display (colorize-string "generate path subsets up to this level of directories" 'GREEN))
  (display " ")
  (display (colorize-string "|" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "Medium" 'BLACK 'ON-BLUE 'UNDERLINE))
  (display (colorize-string "|" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "KDEPTH" 'BLACK 'ON-YELLOW 'REVERSE 'UNDERLINE))
  (display "                 ")
  (display (colorize-string "how many directories deep to calculate path orderings" 'GREEN))
  (display " ")
  (display (colorize-string "|" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "LARGE" 'BLACK 'ON-BLUE 'UNDERLINE))
  (display (colorize-string "|" 'WHITE 'ON-BLACK 'BOLD))
  (newline)
  (display "  ")
  (display (colorize-string "|" 'WHITE 'ON-BLACK 'BOLD))
  (display (colorize-string "Note" 'BLUE))
  (display (colorize-string "|" 'WHITE 'ON-BLACK 'BOLD))
  (display "                 ")
  (display "size notations above signify amount of output created by each depth mode")
  (newline)
  (exit 0))
