(def grammar
  '{:dont "don't()"
    :do "do()"
    :mul (sequence "mul(" (capture (sequence (some :d) "," (some :d))) ")")
    :first-mul (thru :mul)
    :skip-dont (if :dont (to :do))
    :after-do (if :do (any (choice :skip-dont :mul 1)))
    :rest (any (choice :skip-dont :after-do 1))
    :main (sequence :first-mul :rest)
    })

(def input "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))don't()mul(5,5)")

(pp (peg/match grammar input))
