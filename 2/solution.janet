(defn read-file [file]
  (with
    [file-handle
     (file/open file)
     (fn [fd] (file/close fd))]
    (file/read file-handle :all)))

(defn parse-input [input]
    (let
        [lines (string/split "\n" (read-file input))
        number-strs (map (fn [line] (string/split " " line)) (array/slice lines 0 (- (length lines) 1)))]
        (map (fn [row] (map scan-number row)) number-strs)))

(defn between? [min max]
  (fn [n]
    (and
      (>= n min)
      (<= n max))))

(defn inc-or-dec? [row &keys {:dir dir}]
  (or
    (deep= row (sorted-by + row))
    (deep= row (sorted-by - row))))

(defn safe-range? [row]
  (def end (- (length row) 1))
  (def between (between? 1 3))

  (var ranges @[])

  (for i 0 end
    (let [left (get row i)
          right (get row (+ 1 i))
          delta (math/abs (- right left))]
      (array/push ranges (between delta))))

  (reduce2 (fn [acc el] (and acc el)) ranges))

(defn safe? [row]
  (and
    (or
      (inc-or-dec? row :dir :inc)
      (inc-or-dec? row :dir :dec))
    (safe-range? row)))

(defn remove-index [arr n]
  (array/concat (array/slice arr 0 n) (array/slice arr (+ n 1))))

(defn or2 [& xs]
  (reduce2 (fn [acc val]
            (or acc val)) xs))

(defn safe-without-level? [row]
  (or2
    ;(map (fn [i]
           (safe? (remove-index row i)))
          (range 0 (length row)))))

(defn part1 [input]
  (let
    [rows (parse-input input)]
    (reduce (fn [acc row]
              (if (safe? row)
                (+ acc 1)
                acc))
            0 rows)))

(defn part2 [input]
  (let
    [rows (parse-input input)]
    (reduce (fn [acc row]
              (if (or
                    (safe? row)
                    (safe-without-level? row))
                (+ acc 1)
                acc))
              0 rows)))
