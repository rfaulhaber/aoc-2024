(import "../utils/janet/util")

(def grammar-part1
  '{:mul (sequence "mul(" (capture (sequence (some :d) "," (some :d))) ")")
    :main (any (choice :mul 1))})

(def grammar-part2
  '{:dont "don't()"
    :do "do()"
    :mul (sequence "mul(" (capture (sequence (some :d) "," (some :d))) ")")
    :first-mul (thru :mul)
    :skip-dont (if :dont (to :do))
    :after-do (if :do (any (choice :skip-dont :mul 1)))
    :rest (any (choice :skip-dont :after-do 1))
    :main (sequence :first-mul :rest)
    })

(defn parse-input [grammar input]
  (let [file-contents (util/lines-from-file (util/read-file input))
        captures (mapcat (fn [line] (peg/match grammar line)) file-contents)
        pairs (map (fn [pair] (map (fn [s] (scan-number s)) (string/split "," pair))) captures)]
    pairs))

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
