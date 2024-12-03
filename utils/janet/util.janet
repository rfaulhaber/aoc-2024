(defn read-file [file]
  (with
    [file-handle
     (file/open file)
     (fn [fd] (file/close fd))]
    (file/read file-handle :all)))

(defn lines-from-file [file-contents]
  (let
    [lines (string/split "\n" file-contents)]
    (filter (fn [line] (not (= line ""))) lines)))
