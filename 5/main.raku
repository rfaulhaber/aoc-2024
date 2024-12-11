sub MAIN($input, $part) {
    say "input: %s, part: %s".sprintf($input, $part);

    my %input-map = process-input($input);

    if $part eq '1' {
        my $result = Solution::part1(%input-map);
        say "Part 1: {$result}";
    } elsif $part eq "2" {
        my $result = Solution::part2(%input-map);
        say "Part 2: {$result}";
    } else {
        say "I don't know what part you're talking about!";
    }
}

sub process-input($input) {
    my $regex-rule =  /(\d+)"|"(\d+)/;
    my $regex-page = /[(\d+)|","]+/;

    my %input-lines = $input.IO.lines.classify: -> $line {
        if $line ~~ $regex-rule {
            "rule"
        }
        elsif $line ~~ $regex-page {
            "page"
        } else {
            "misc"
        }
    };

    my @pages = %input-lines{'page'};
    my @rules = %input-lines{'rule'}.map: *.split('|').map: +*;

    return %('pages', @pages, 'rules', @rules);
}

module Solution {
    our sub part1(%input) {
        my @reg-rules = gather {
            for %input{'rules'} -> @rule {
                for @rule -> ($left, $right) {
                    my $r = rx/"$left".*"$right"/;
                    take ($left, $right), $r
                }
            }
        }

        # I don't understand why 'pages' seems to be wrapped in an arry
        my @middles = gather for %input{'pages'}[0] -> @pages {
            for @pages -> $page {
                my @relevant-rules = ($_[1] if $page.contains($_[0][0]) and $page.contains($_[0][1]) for @reg-rules);

                if @relevant-rules.elems != 0 {
                    my $result =  @relevant-rules.map: -> $rule { !!( $page ~~ $rule ) };
                    if so $result.all {
                        my @s = $page.split(",");
                        my $page-len = @s.elems;

                        take @s[$page-len/2];
                    }
                }

            }
        }

        return @middles.sum

    }

    our sub part2(%input) {
        my @rules = gather {
            for %input{'rules'} -> @rule {
                for @rule -> ($left, $right) {
                    take -> $str { $str.index($left) < $str.index($right) };
                }
            }
        }

        say "rules {@rules.perl}";

        # TODO

    }
}
