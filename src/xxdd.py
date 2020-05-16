#!/usr/bin/env python3.7

import base64
import gzip
import logging
import sys
import re

from unidiff import PatchSet


def print_script(outfile, patch_bytes):
    patch_map = " ".join(
        ["{}:{}".format(key, value) for key, value in patch_bytes.items()]
    )

    # minified version of unminified.sh
    payload = bytearray(
        f"for item in {patch_map}; do"
        f" dd bs=1 count=1 conv=notrunc seek=$((16#${{item%:*}}))"
        f" if=<(printf %b \"\\x${{item#*:}}\") of='{outfile}'; done",
        "utf-8",
    )

    compressed = gzip.compress(payload)
    encoded = base64.b64encode(compressed).decode()

    print(f"base64 -d <<< '{encoded}' | gunzip | bash")


def main():
    diff = []
    for line in sys.stdin:
        diff.append(line)

    patch = PatchSet(diff)
    source_file = patch[0].source_file

    pattern = re.compile(r"^[+-]([0-9a-f]+):\ ([0-9a-f\ ]+)\ +.*$")
    changes = {}

    for hunk in patch[0]:
        for line in hunk.source:
            match = pattern.match(line)
            if match:
                offset = match.group(1)
                buffer = match.group(2).replace(" ", "")
                changes[offset] = {}
                changes[offset]["source"] = [
                    str(buffer[i : i + 2]) for i in range(0, len(buffer), 2)
                ]

        for line in hunk.target:
            match = pattern.match(line)
            if match:
                offset = match.group(1)
                buffer = match.group(2).replace(" ", "")
                changes[offset]["target"] = [
                    str(buffer[i : i + 2]) for i in range(0, len(buffer), 2)
                ]

    patch_bytes = {}

    for offset in changes:
        # print(f'offset: {offset}')
        for i in range(16):
            source_byte = changes[offset]["source"][i]
            target_byte = changes[offset]["target"][i]
            # print(f'i: {i}')
            if source_byte != target_byte:
                cursor = format(int(offset, base=16) + i, "x")
                patch_bytes[cursor] = target_byte
                # print(f'cursor: {cursor}, source_byte: {source_byte}, target_byte: {target_byte}')

    print_script(source_file, patch_bytes)


if __name__ == "__main__":
    main()
