erlang:
  pkg.installed

git:
  pkg.installed

make:
  pkg.installed

disco_repo:
  git.latest:
    - name: git://github.com/discoproject/disco.git
    - runas: {{ pillar['username'] }}
    - target: /home/{{ pillar['username'] }}/software/disco
    - require:
      - pkg: git

disco_install:
  cmd.run:
    - name: make
    - cwd: /home/{{ pillar['username'] }}/software/disco
    - user: {{ pillar['username'] }}
    - unless: test -f /home/{{ pillar['username'] }}/software/disco/master/ebin/disco.beam
    - require:
      - git: disco_repo
      - pkg: make

ssh_key:
  cmd.run:
    - name: ssh-keygen -N '' -f /home/{{ pillar['username'] }}/.ssh/id_rsa
    - unless: test -f /home/{{ pillar['username'] }}/.ssh/id_rsa
    - user: {{ pillar['username'] }}

ssh_auth:
  cmd.run:
    - name: cat .ssh/id_rsa.pub >> .ssh/authorized_keys
    - user: {{ pillar['username'] }}
    - cwd: /home/{{ pillar['username'] }}
    - unless: grep precise /home/{{ pillar['username'] }}/.ssh/authorized_keys

#disco_environment_variables:
#  file.append:
#    - name: /home/{{ pillar['username'] }}/.profile
#    - user: {{ pillar['username'] }}
#    - group: {{ pillar['username'] }}
#    - text:
#      - export DISCO_INSTALL=/home/{{ pillar['username'] }}/software/disco
#      - export PATH=$PATH:$DISCO_INSTALL/bin
