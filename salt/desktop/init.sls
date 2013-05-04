openssh-server:
  pkg.installed

#firefox-globalmenu:
#    pkg.removed

desktop-packages:
    pkg.installed:
        - pkgs:
            - xorg
            - chromium-browser
            - chromium-codecs-ffmpeg-extra
            #- firefox
            - openbox
            - gnome-terminal
            - gkrellm
            - gmrun
            - nautilus
            - alsa-utils
            - pavucontrol
            - libreoffice
            - vlc
#            #- task-gnome-desktop
            - ubuntu-gnome-desktop
#            #- task-xfce-desktop
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

#google-chrome:
#    pkg.installed:
#        - name: google-chrome-stable
#        - require:
#            - pkgrepo: google-chrome
#    pkgrepo.managed:
#        - name: deb http://dl.google.com/linux/chrome/deb/ stable main
#        - file: /etc/apt/sources.list.d/google-chrome.list
#        - key_url: https://dl-ssl.google.com/linux/linux_signing_key.pub

spotify-client:
    pkg.installed:
        - require:
            - pkgrepo: spotify-client
    pkgrepo.managed:
        - name: deb http://repository.spotify.com stable non-free
        - file: /etc/apt/sources.list.d/spotify.list
        - keyserver: keyserver.ubuntu.com
        - keyid: 94558F59

dropbox:
    pkg.installed:
        - require:
            - pkgrepo: dropbox
            - pkg: python-gpgme
    pkgrepo.managed:
        - name: deb http://linux.dropbox.com/debian wheezy main
        - file: /etc/apt/sources.list.d/dropbox.list
        - keyserver: pgp.mit.edu
        - keyid: 5044912E
