packages:
    pkg.installed:
        - pkgs:
            - ipython
            - ipython-notebook
            - virtualenvwrapper

pandas:
    pkg.installed:
        - name: python-pandas
{% if grains['os_family'] == 'Debian' and grains['oscodename'] != 'raring' %}
        - require:
            - file: neuro-debian-repo

neuro-debian-repo:
    pkgrepo.managed:
        - name: deb http://repository.spotify.com stable non-free
        - file: /etc/apt/sources.list.d/spotify.list
        - keyserver: keyserver.ubuntu.com
        - keyid: 94558F59
    file.managed:
        - name: /etc/apt/sources.list.d/neurodebian.list
        - source: salt://python-dev/neuro-debian.list
        - template: jinja
        - context:
            release: {{ grains['lsb_codename'] }}
        - require:
            - cmd: neuro-debian-key

neuro-debian-key:
    cmd.run:
        - name: apt-key adv --recv-keys --keyserver pgp.mit.edu 2649A5A9 #&& apt-get update
        - unless: apt-key list | grep Neuro
{% endif %}
