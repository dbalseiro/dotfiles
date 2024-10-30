#!/bin/bash
set -e

function extraerArchivo() {
    FILTER=
    if [ "$1" != "" ]; then
        FILTER="\$1 == \"$1\"" 
    fi
    CMD="$FILTER { print \$2 }"
    awk "$CMD"
}

function numerar() {
    N=0
    while read r; do
        let N+=1
        printf "%3s: %s\n" "$N" "$r"
    done
}

if [ "$1" == "" ]; then
    git status -s
else
    while [ "$1" != "" ]; do
        case "$1" in
            "") git status -s
                ;;
            "-n")
                git status -s | cut -c3- | numerar
                ;;
            [0-9]*) git status -s | head -$1 | tail -1 | extraerArchivo
                ;;
            *) git status -s | extraerArchivo $1
                ;;
        esac
        shift
    done
fi
