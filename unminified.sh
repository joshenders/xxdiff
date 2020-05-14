#!/usr/bin/env bash

function main() {
    if [[ "$#" -ne 2 ]]; then
        echo "${0##./}: <outfile> <payload>" >&2
        exit 1
    fi

    local outfile="$1"
    local payload="$2"
    # shellcheck disable=SC2207
    local patch=($(base64 --decode <<< "${payload}" | gunzip))
 
    for item in "${patch[@]}"; do
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
