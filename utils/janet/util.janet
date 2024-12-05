(defn read-file [file]
  (with
    [file-handle
     (file/open file)
     (fn [fd] (file/close fd))]
    (file/read file-handle :all)))

(defn read-lines-from-file [file]
  (with
    [file-handle
     (file/open file)
     (fn [fd] (file/close fd))]
    (var lines @[])

    (loop [line :iterate (file/read file-handle :line)]
      (array/push lines line))
    lines))

(defn lines-from-file [file-contents]
  (let
    [lines (string/split "\n" file-contents)]
    (filter (fn [line] (not (= line ""))) lines)))
