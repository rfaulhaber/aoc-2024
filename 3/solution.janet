(import "../utils/janet/util")

(defn- transform-match [str]
  (map scan-number (string/split "," str)))

(defn- number-pairs [left right]
  @[left right])

(def- grammar-part1
  ~{:mul-args (replace (capture (sequence (some :d) "," (some :d))) ,transform-match)
    :mul (sequence "mul(" :mul-args ")")
    :main (any (choice :mul 1))})

(def- grammar-part2
  (peg/compile
    ~{:dont "don't()"
      :do "do()"
      :mul-args (replace (sequence (number (some :d)) "," (number (some :d))) ,number-pairs)
      :mul (sequence "mul(" :mul-args ")")
      :enabled-section (any (if-not :dont (choice :mul 1)))
      :disabled-section (sequence :dont (to :do))
      :main (sequence :enabled-section (any (choice :disabled-section :enabled-section 1)))
      }))

(defn- parse-input [grammar input]
  (let [file-contents (util/read-file input)]
    (peg/match grammar file-contents)))

(defn- calc-result [pairs]
  (reduce (fn [acc @[left right]]
            (+ acc (* left right))) 0 pairs))

(defn- part [grammar]
  (fn [input]
    (calc-result (parse-input grammar input))))

(def part1 (part grammar-part1))
(def part2 (part grammar-part2))
