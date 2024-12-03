def main [--part: string, --input: string] {
    with-env { JANET_PATH: ("./jpm_tree/lib" | path expand) } { janet main.janet --input $input  --part $part}
}
