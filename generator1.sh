#!/bin/sh
echo -ne '\033c\033]0;generator1\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/generator1.x86_64" "$@"
