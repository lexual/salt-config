virtualbox:
    pkg.installed

salty-vagrant:
    cmd.run:
        - name: HOME=/home/{{ pillar['username'] }} vagrant gem install vagrant-salt
        - user: {{ pillar['username'] }}
        - group: {{ pillar['username'] }}
        - cwd: /home/{{ pillar['username'] }}
        - unless: ls /home/{{ pillar['username'] }}/.vagrant.d/gems/gems/vagrant-salt*
        - require:
            - pkg: vagrant
            - pkg: ruby-dev

ruby-dev:
    pkg.installed

vagrant:
    pkg.installed:
    - require:
        - pkg: virtualbox
