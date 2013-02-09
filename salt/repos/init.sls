/etc/apt/sources.list.d/neurodebian.list:
    file.managed:
        - source: http://neuro.debian.net/lists/wheezy.au
        - source_hash: md5=d3a8fdf20a5a937fae309deca87fb87a

neuro-debian-update:
    cmd.run:
        - name: apt-key adv --recv-keys --keyserver pgp.mit.edu 2649A5A9 && apt-get update
        - unless: apt-key list | grep Neuro
        - require:
            - file: /etc/apt/sources.list.d/neurodebian.list

/etc/apt/sources.list.d/google-chrome.list:
    file.managed:
        - source: salt://repos/google-chrome.list

google-chrome-update:
    cmd.run:
        - name: wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && apt-get update
        - unless: apt-key list | grep Google
        - require:
            - file: /etc/apt/sources.list.d/google-chrome.list

/etc/apt/sources.list.d/spotify.list:
    file.managed:
        - source: salt://repos/spotify.list

spotify-update:
    cmd.run:
        - name: apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59 && apt-get update
        - unless: apt-key list | grep Spotify
        - require:
            - file: /etc/apt/sources.list.d/spotify.list
        

/etc/apt/sources.list.d/dropbox.list:
    file.managed:
        - source: salt://repos/dropbox.list

dropbox-update:
    cmd.run:
        - name: apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E && apt-get update
        - unless: apt-key list | grep Dropbox
        - require:
            - file: /etc/apt/sources.list.d/dropbox.list
