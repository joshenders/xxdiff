#!/usr/bin/env bash

function main() {
    if [[ "$#" -ne 2 ]]; then
        echo "${0##./}: <outfile> <patch_map>" >&2
        exit 1
    fi

    local outfile="$1"
    local patch_map=("$2")

    for item in "${patch_map[@]}"; do
        local offset=$((16#${item%:*}))
        local value="${item#*:}"

        dd \
            bs=1 \
            count=1 \
            conv=notrunc \
            seek="${offset}" \
            if=<(printf %b "\x${value}") \
            of="${outfile}"
    done
}

main "$@"
