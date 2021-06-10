#!/usr/bin/env zsh

swift build
mv .build/debug/CLIUtils /usr/local/bin/shared/clu
