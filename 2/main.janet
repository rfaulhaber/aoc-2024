(import spork/argparse :as argparse)
(import ./solution)

(def args
  [ "Day 2 solver"
   "input" { :kind :option
             :short "i"
             :required true
             :help "Input file"}
   "part" {
           :kind :option
           :short "p"
           :required true
           :help "Part"
           :map scan-number
           }
   ])


(defn main [& argv]
     (let [{"input" input "part" part} (argparse/argparse ;args)]
          (unless (or input part)
               (os/exit 1))
          (pp (string/format "input: %s part: %i" input part))
          (match part
            1 (solution/part1 input)
            2 (solution/part2 input)
            _ (do
                (print "--part should be either 1 or 2")
                (os/exit 1)))

       ))
