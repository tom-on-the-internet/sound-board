# Bash Soundboard

A soundboard written hastily in bash.
It can download sounds from the web.

See video: [https://youtu.be/8juEYavtAVg](https://youtu.be/8juEYavtAVg)

## Usage

See this help message
sound-board.bash -h (or --help)

List sounds
sound-board.bash -l (or --list)

Play downloaded sound
sound-board.bash soundname

Download sound
sound-board.bash url start_time end_time soundname

## sxhkdrc snippet example

shift + ctrl + {n,e,i,o}
  { sound=yeah;         text='yeah yeah yeah!'; \
  , sound=diesel;       text='VIM diesel';   \
  , sound=supereasy;    text='super easy! barely an inconvenience'; \
  , sound=garbage;      text='Proprietary garbage!';  \
  } \
 notify-send $text; sb $sound

