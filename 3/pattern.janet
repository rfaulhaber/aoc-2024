(defn transform-match [str]
  (map scan-number (string/split "," str)))

(def grammar
  (peg/compile
    ~{:dont "don't()"
      :do "do()"
      :mul-args (replace (capture (sequence (some :d) "," (some :d))) ,transform-match)
      :mul (sequence "mul(" :mul-args ")")
      :before-dont (any (if-not :dont (choice :mul 1)))
      :skip-dont (if :dont (to :do))
      :main (sequence :before-dont (any (choice :skip-dont :before-dont 1)))
      }))

(def input "xmul(2,4)&mul[3,7]mul(2,45)!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5)asdfmul(1,1))don't()mul(5,5)asfdo()asdfmul(2,2)")

(pp (peg/match grammar input))
