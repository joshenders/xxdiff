# xxdiff Project

[![Python 3.7](https://img.shields.io/badge/python-3.7-blue.svg)](https://www.python.org/downloads/release/python-370/)
[![image](https://img.shields.io/badge/pypi-pipenv-blue.svg)](https://python.org/pypi/pipenv)
[![Code style: black](https://img.shields.io/badge/code%20style-black-black.svg)](https://github.com/psf/black)
[![License: CC BY-NC 4.0](https://img.shields.io/badge/license-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)

## About

`xxdiff` and `xxdd` are simple utilities which make distributing and applying
binary patches easy and convenient.

See also [`bsdiff`](https://www.freebsd.org/cgi/man.cgi?query=bsdiff) and [`bspatch`](https://www.freebsd.org/cgi/man.cgi?query=bspatch).

## Usage

When you're ready to distribute your patch, run `xxdiff` to produce an
_xxdiff_.

```sh
$ xxdiff oldfile newfile
--- oldfile 2020-05-14 02:19:46.000000000 +0000
+++ newfile 2020-05-14 02:19:46.000000000 +0000
@@ -2159,7 +2159,7 @@
 000086e0: 1b48 3b5d d075 1544 89f0 4881 c408 0c00  .H;].u.D..H.....
 000086f0: 005b 415c 415d 415e 415f 5dc3 e81f 090f  .[A\A]A^A_].....
 00008700: 0066 6666 6666 662e 0f1f 8400 0000 0000  .ffffff.........
-00008710: 5548 89e5 8a87 0210 0000 5dc3 9090 9090  UH........].....
+00008710: 9090 9090 9090 9090 9090 90c3 9090 9090  ................
 00008720: 5548 89e5 e8a3 0b0f 0031 c05d c30f 1f00  UH.......1.]....
 00008730: 5548 89e5 4157 4156 5348 83ec 3849 89fe  UH..AWAVSH..8I..
 00008740: 48c7 45e0 0000 0000 bb01 0000 0049 837e  H.E..........I.~
@@ -11941,7 +11941,7 @@
 0002ea40: ff4c 89ff e807 46ff ff4c 89ff e89f f9fe  .L....F..L......
 0002ea50: ff4c 89ff e867 01ff ff4c 89ff e8df 16ff  .L...g...L......
 0002ea60: ff4c 89ff e847 54ff ff49 8d9f 8015 0000  .L...GT..I......
-0002ea70: 4889 dfe8 989c fdff 84c0 0f84 9e0f 0000  H...............
+0002ea70: 4889 dfe8 989c fdff 84c0 9090 9090 9090  H...............
 0002ea80: 488d 3d86 fa0c 00be 0100 0000 e8af b40b  H.=.............
 0002ea90: 0084 c00f 8464 0100 0041 c687 de62 0300  .....d...A...b..
 0002eaa0: 0141 c687 7343 0300 0048 8d3d 62fa 0c00  .A..sC...H.=b...
@@ -12382,9 +12382,9 @@
 000305d0: 0001 4180 bc24 5015 0000 0074 1d41 c684  ..A..$P....t.A..
 000305e0: 2403 6303 0001 4c89 e7e8 02d9 feff 488d  $.c...L.......H.
 000305f0: 3df3 b60c 00e8 c65f 0800 498d bc24 8015  =......_..I..$..
-00030600: 0000 e809 81fd ff84 c074 0a4c 89e7 e89d  .........t.L....
+00030600: 0000 e809 81fd ff84 c090 904c 89e7 e89d  ...........L....
 00030610: e3ff ffeb 1d41 c684 2402 6303 0001 4c89  .....A..$.c...L.
-00030620: e7e8 6ad9 feff 488d 3d13 b90c 00e8 8e5f  ..j...H.=......_
+00030620: e790 9090 9090 9090 9090 9090 90e8 8e5f  ..............._
 00030630: 0800 4180 bc24 fb62 0300 000f 84a9 0200  ..A..$.b........
 00030640: 004d 8dbc 24a8 2d00 0048 8dbd b8f7 ffff  .M..$.-..H......
 00030650: 4c89 fee8 628c 0c00 0f57 c00f 2985 a0f7  L...b....W..)...
```

You can stop here and share this file as-is or you can pipe the output to
`xxdd` which will output a compact shell script fragment capable of applying
the xxdiff on most Linux distributions (like Debian or Ubuntu) or macOS.

```sh
$ xxdiff oldfile newfile | xxdd
base64 -d <<< 'H4sIAGYAv14C/z3QSwrCMBCA4asM1tLWhSSpfWpu4qZpEwnWRGotgnh3ic509X8Qm
Bli/AR21jewDuqKs7ZhoRwrsDn2gC2wJbbC1tgG24UK3VUrFKEnDARNMAE5K1lD6BCCEwQhJxwIBaEkV
ISaQJPFOlkRwmFHGDwMA6iH5ND7p5t/dYt0fp6eroeH1le5TVNeRtt3+MG43X2yDKyRp/Q+WTcbiBVsz
q//c7RrP5sMvJGJGfVLLfuFs6LZ+8lerOvGJKx0+gvJtx2VkAEAAA==' | gunzip | bash
```

The shell script fragment is a compact version of [src/map-apply.sh](src/map-apply.sh)
which can be used for testing.

## Improvements

In the future, a `xxdiff -a|--apply <xxdiff> <outfile>` may also be
supported in addition to checksum verification.

## Installation

WIP

```sh
make install
```

## Contributing

### Dev Environment setup

WIP

#### Dependencies

```sh
pipenv \
    install \
        --dev
        --ignore-pipfile

```

#### Pre-commit hooks

```sh
pre-commit autoupdate
pre-commit install
```

### Running tests

WIP

```sh
make test
```

## License

This work is licensed under CC BY-NC version 4.0 [https://creativecommons.org/licenses/by-nc/4.0/](https://creativecommons.org/licenses/by-nc/4.0/)
© 2020, Josh Enders. Some Rights Reserved.
