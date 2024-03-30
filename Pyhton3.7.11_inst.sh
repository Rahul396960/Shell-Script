#!/bin/bash

path="/usr/src"
repo="https://www.python.org/ftp/python/3.7.11/Python-3.7.11.tgz"
file="Python-3.7.11.tgz"
file1="Python-3.7.11"

yum install -y gcc openssl-devel bzip2-devel libffi-devel zlib-devel xz-devel || exit 1

cd "$path" && wget "$repo" && tar xzf "$file" && cd "$file1" && \
    ./configure --enable-optimizations && make altinstall && \
    { printf 'Python installed successfully\n'; python3.7 -V; } || \
    printf 'Installation failed\n'
