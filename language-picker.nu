def main [] {
  open languages.txt | lines | get random
}


def "get random" []: list<any> -> any {
  let count = ($in | length)

  let idx = (..($count - 1) | collect | shuffle | first)

  $in | get $idx
}
