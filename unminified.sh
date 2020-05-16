#!/usr/bin/env bash

function main() {
    if [[ "$#" -ne 2 ]]; then
        echo "${0##./}: <outfile> <patch_map>" >&2
        exit 1
    fi

    local outfile="$1"
    declare -a patch_map
    read -ra patch_map <<< "$2"

    for item in "${patch_map[@]}"; do
        local offset=$((16#${item%:*}))
        local value="${item#*:}"

        printf "Patching offset: %s, value: %s\r" "0x${item%:*}" "0x${value}"

        dd \
            bs=1 \
            count=1 \
            conv=notrunc \
            seek="${offset}" \
            if=<(printf %b "\x${value}") \
            of="${outfile}" 2>&1 \
        | grep \
            --extended-regexp \
            --invert-match \
                'bytes transferred|records (in|out)'
        sleep .03
    done

    printf "\n"
}

main "$@"
