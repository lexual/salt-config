packages:
    pkg.installed:
        - pkgs:
            - ipython
            - ipython-notebook
            - virtualenvwrapper

python-pandas:
    pkg.installed:
{% if grains['os_family'] == 'Debian' %}
        - require:
            - file: neuro-debian-repo

neuro-debian-repo:
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
