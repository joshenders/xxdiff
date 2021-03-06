#!/usr/bin/env bash

function xxdiff() {
    local tab=$'\t'

    diff \
        --unified \
            <(xxd "$1") <(xxd "$2") \
    | sed -E "s|^([-]{3}\ )\/dev\/fd\/[0-9]+${tab}|\1${1}${tab}|g" \
    | sed -E "s|^([+]{3}\ )\/dev\/fd\/[0-9]+${tab}|\1${2}${tab}|g"
}


function exit_with_usage() {
    echo "Usage: ${0##*/} <oldfile> <newfile>" >&2
    exit 1
}


function main() {
    if [[ "$#" -ne 2 ]]; then
        exit_with_usage
    fi

    xxdiff "$1" "$2"
}

main "$@"
