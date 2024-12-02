(defn read-file [file]
  (with
    [file-handle
     (file/open file)
     (fn [fd] (file/close fd))]
    (file/read file-handle :all)))

(defn parse-input [input]
    (let
        [lines (string/split "\n" (read-file input))
        number-strs (map (fn [line] (string/split " " line)) lines)]
        (map (fn [row] (map scan-number row)) number-strs)))

(defn inc-or-dec? [row]
  (var incs @[])
  (def end (- (length row) 1))
  (for i 0 end
    (array/push incs (> (get row i) (get row (+ 1 i)))))

  (var inc true)

  (loop [i :in incs]
    (set inc (and inc i)))
  inc)

(defn part1 [input]
  (let
    [rows (parse-input input)]
    (pp (inc? (get rows 0))))
  (print "part 1"))

(defn part2 [input]
  (print "part 2"))

(defn safe? [row]
  )

(defn inc-or-dec? [row]
  )
