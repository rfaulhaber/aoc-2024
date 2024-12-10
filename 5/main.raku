sub MAIN($input, $part) {
    say "input: %s, part: %s".sprintf($input, $part);

    # TODO read lines from file

    my @input-lines = $input.IO.lines;

    my $regex-rule =  /(\d+)"|"(\d+)/;
    my regex regex-page  { (\d+)|, };

    my @rules = gather {
        for $input.IO.lines -> $line {
            my $matches = $line ~~ $regex-rule;

            take $matches.map: +* if !!$matches;
        }
    }

    my @pages = gather {
        for $input.IO.lines -> $line {
            take $line if $line ~~ &regex-page;
        }
    }

    say @pages;

    if $part eq '1' {
        say "Part 1"
    } elsif $part eq "2" {
        say "Part 2"
    } else {
        say "I don't know what part you're talking about!";
    }
}

sub process-input($input) {
    my $rules = $input.split('\n\n')
}

module Solution {
    our sub part1($input) {

    }

    our sub part2($input) {

    }
}
