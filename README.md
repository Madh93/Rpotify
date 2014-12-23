#Rpotify

Rpotify is a tool for managing Spotify remotely without GUI, only by CLI.

![Alt text](http://oi58.tinypic.com/296hlqq.jpg "Sample of Rpotify")

##Features

**Current features:**

- Play/Pause/Stop
- Next/Previous
- Shuffle/Repeat
- Volume up/down
- Now Playing
- Information track
- Search song/album/artist

**Future features:**

- Order searches
- Access to personal lists
- Download track/cover
- ...

##How to install

###Dependencies

For Volume up/down and Shuffle/Repeat is necessary xdotool:

    sudo apt-get install xdotool

To search music is necessary:

- [Ruby](https://github.com/ruby/ruby)
- [rspotify gem](https://github.com/guilhermesad/rspotify)
- [terminal-table gem](https://github.com/tj/terminal-table)

###Install

Download, extract and launch:

    wget -O rpotify.zip https://github.com/Madh93/Rpotify/archive/master.zip
    unzip rpotify.zip && cd Rpotify-master
    ./rpotify.sh

##How to use

To list all commands:

    ./rpotify.sh help

To search music:

    ./rpotify.sh search [[-s|--song]|[--album]|[-a|--artist]] text_search
