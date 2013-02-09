include:
    - repos


packages:
    pkg.installed:
        - pkgs:
            - git
            - tmux
            - vim
            - xorg
            - openbox
            - gnome-terminal
            - virtualbox
            - build-essential
            - ipython
            - ipython-notebook
            - gkrellm
            - vagrant
            - ntp
            - command-not-found
            - mysql-client-5.5
            - mysql-server-core-5.5  # for kde dependencies issues.
            - virtualenvwrapper
            - gmrun
            - python-gpgme  # for dropbox.
            - nautilus
            - alsa-utils
            - pavucontrol
            - libreoffice
            - task-kde-desktop
            #- task-gnome-desktop
            #- task-xfce-desktop
            - pm-utils
            - evince

python-pandas:
    pkg.installed:
        - require:
            - cmd: neuro-debian-update

google-chrome-stable:
    pkg.installed:
        - require:
            - cmd: google-chrome-update

spotify-client:
    pkg.installed:
        - require:
            - cmd: spotify-update

dropbox:
    pkg.installed:
        - require:
            - cmd: dropbox-update

sudo group:
    user.present:
        - name: lexdeb
        - groups:
            - sudo
            - lexdeb
            - audio
            - cdrom

/home/lexdeb/.vimrc:
    file.managed:
        - source: salt://lexdeb/vimrc
        - user: lexdeb
        - group: lexdeb

/root/.vimrc:
    file.managed:
        - source: salt://lexdeb/vimrc

/home/lexdeb/.vim:
    file.recurse:
        - source: salt://lexdeb/vim
        - user: lexdeb
        - group: lexdeb

/root/.vim:
    file.recurse:
        - source: salt://lexdeb/vim
