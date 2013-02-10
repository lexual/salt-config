desktop-packages:
    pkg.installed:
        - pkgs:
            - xorg
            - openbox
            - gnome-terminal
            - gkrellm
            - mysql-server-core-5.5  # for kde dependencies issues.
            - gmrun
            - nautilus
            - alsa-utils
            - pavucontrol
            - libreoffice
            - task-kde-desktop
            #- task-gnome-desktop
            #- task-xfce-desktop
            - pm-utils
            - evince

kde:
    pkg.installed:
{% if grains['os'] == 'Ubuntu' %}
        - name: kubuntu-desktop
{% elif grains['os'] == 'Debian' %}
        - name: task-kde-desktop
        - require:
            - pkg: mysql-server-core-5.5

mysql-server-core-5.5:
    pkg.installed
{% endif %}

python-gpgme:
    pkg.installed

google-chrome-stable:
    pkg.installed:
        - require:
            - file: google-chrome-repo

google-chrome-repo:
    file.managed:
        - name: /etc/apt/sources.list.d/google-chrome.list
        - source: salt://desktop/google-chrome.list
        - require:
            - cmd: google-chrome-key

google-chrome-key:
    cmd.run:
        - name: wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - #&& apt-get update
        - unless: apt-key list | grep Google


spotify-client:
    pkg.installed:
        - require:
            - file: spotify-repo

spotify-repo:
    file.managed:
        - name: /etc/apt/sources.list.d/spotify.list
        - source: salt://desktop/spotify.list
        - require:
            - cmd: spotify-key

spotify-key:
    cmd.run:
        - name: apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59 #&& apt-get update
        - unless: apt-key list | grep Spotify
        - require:
            - file: /etc/apt/sources.list.d/spotify.list

dropbox:
    pkg.installed:
        - require:
            - cmd: dropbox-key
            - pkg: python-gpgme
            - file: dropbox-repo

        

dropbox-repo:
    file.managed:
        - name: /etc/apt/sources.list.d/dropbox.list
        - source: salt://desktop/dropbox.list
        - require:
            - cmd: dropbox-key

dropbox-key:
    cmd.run:
        - name: apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E #&& apt-get update
        - unless: apt-key list | grep Dropbox
        - require:
            - file: /etc/apt/sources.list.d/dropbox.list
