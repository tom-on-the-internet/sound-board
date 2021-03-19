#!/bin/bash

set -euf -o pipefail

REQUIREMENTS=('mpv' 'ffmpeg' 'youtube-dl')

play() {
  filepath="$HOME"/sounds/"$1".mp3

  if [[ ! -f $filepath ]]; then
    echo \""$1"\" not found
    exit 1
  fi

  mpv "$filepath"

  exit
}

list() {
  ls "$HOME"/sounds
}

download() {
  filepath="$HOME"/sounds/"$4".mp3
  # get the urls needed for ffmpeg
  # based on https://unix.stackexchange.com/a/388148
  audio_url=$(youtube-dl --youtube-skip-dash-manifest -g "$1" | awk 'NR==2')

  ffmpeg -y -ss "$2" -to "$3" -i "$audio_url" -map 0:a -c:a mp3 "$filepath"

  play "$4"
}

help() {
  cat << EOF
usage:

See this help message
$0 -h (or --help)

List sounds
$0 -l (or --list)

Play downloaded sound
$0 soundname

Download sound
$0 url start_time end_time soundname
EOF
}

check_requirements() {
  for requirement in "${REQUIREMENTS[@]}"; do
    command -v "$requirement" > /dev/null 2>&1 || {
      echo "You need to install $requirement"
      exit 1
    }
  done
}

# no args
[[ $# -eq 0 ]] && help && exit 1

# help
[[ $# -eq 1 ]] && [[ $1 == -h ]] && help && exit
[[ $# -eq 1 ]] && [[ $1 == --help ]] && help && exit

# list
[[ $# -eq 1 ]] && [[ $1 == -l ]] && list && exit
[[ $# -eq 1 ]] && [[ $1 == --list ]] && list && exit

check_requirements

# play
[[ $# -eq 1 ]] && play "$1"

# download sound
[[ $# -ne 4 ]] && help && exit 1
download "$@"
