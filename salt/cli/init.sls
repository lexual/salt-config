cli-packages:
    pkg.installed:
        - pkgs:
            - git
            - tmux
            - vim
            - build-essential
            - ntp
            - command-not-found
            - mysql-client-5.5


#sudo group:
#    user.present:
#        - name: {{ pillar['username'] }}
#        - groups:
#            - sudo
#            - {{ pillar['username'] }}
#            - audio
#            - cdrom
#
#/home/{{ pillar['username'] }}/.vimrc:
#    file.managed:
#        - source: salt://cli/vimrc
#        - user: {{ pillar['username'] }}
#        - group: {{ pillar['username'] }}
#
#
#/home/{{ pillar['username'] }}/.vim:
#    file.recurse:
#        - source: salt://cli/vim
#        - user: {{ pillar['username'] }}
#        - group: {{ pillar['username'] }}
#
##/root/.vimrc:
##    file.managed:
##        - source: salt://cli/vimrc
##
##/root/.vim:
##    file.recurse:
##        - source: salt://cli/vim
