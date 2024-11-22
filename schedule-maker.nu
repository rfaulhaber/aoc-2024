def main [] {
  let langs = (open languages.txt | lines)

  1..31
    | each { |i| { day: $i, language: ($langs | get random) } }
    | to nuon
}


def "get random" []: list<any> -> any {
  let count = ($in | length)

  let idx = (..($count - 1) | collect | shuffle | first)

  $in | get $idx
}
