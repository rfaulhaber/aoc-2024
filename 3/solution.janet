(import "../utils/janet/util")

(defn transform-match [str]
  (map scan-number (string/split "," str)))

(def grammar-part1
  ~{:mul-args (replace (capture (sequence (some :d) "," (some :d))) ,transform-match)
    :mul (sequence "mul(" :mul-args ")")
    :main (any (choice :mul 1))})

(def grammar-part2
  (peg/compile
    ~{:dont "don't()"
      :do "do()"
      :mul-args (replace (capture (sequence (some :d) "," (some :d))) ,transform-match)
      :mul (sequence "mul(" :mul-args ")")
      :enabled-section (any (if-not :dont (choice :mul 1)))
      :disabled-section (if :dont (to :do))
      :main (sequence :enabled-section (any (choice :disabled-section :enabled-section 1)))
      }))

(defn parse-input [grammar input]
  (let [file-contents (util/lines-from-file (util/read-file input))]
    (mapcat (fn [line] (peg/match grammar line)) file-contents)))

(defn calc-result [pairs]
  (reduce (fn [acc @[left right]] (+ acc (* left right))) 0 pairs))

(defn part1 [input]
  (let
    [pairs (parse-input grammar-part1 input)]
    (calc-result pairs)))

(defn part2 [input]
  (let
    [pairs (parse-input grammar-part2 input)]
    (calc-result pairs)))
