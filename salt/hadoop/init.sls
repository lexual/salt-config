java:
  pkg.installed:
    - name: openjdk-7-jdk

{% set hadoop_version = '1.0.4' %}
{% set hadoop_sha1 = '1ab6f3271289ff83ba7b44a090ec1a3e6b77d1dd' %}
{% set pig_version = '0.11.0' %}
{% set pig_sha1 = 'becdb938e0e76218650c16b55958a04460370181' %}

software_directory:
  file.directory:
    #- name: /home/{{ pillar['username'] }}/software
    - name: /home/{{ pillar['username'] }}/software
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}

### HADOOP ###

hadoop_software:
  file.managed:
    - name: /home/{{ pillar['username'] }}/software/hadoop-{{ hadoop_version }}.tar.gz
    - source: http://mirror.mel.bkb.net.au/pub/apache/hadoop/common/hadoop-{{ hadoop_version }}/hadoop-{{ hadoop_version }}.tar.gz
    - source_hash: sha1={{ hadoop_sha1 }}
    - require:
      - file: software_directory

extract_hadoop:
  cmd.run:
    - name: tar zxvf hadoop-{{ hadoop_version }}.tar.gz
    - unless: test -d /home/{{ pillar['username'] }}/software/hadoop-{{ hadoop_version }}/
    - user: {{ pillar['username'] }}
    - cwd: /home/{{ pillar['username'] }}/software/
    - require:
      - file: hadoop_software

### PIG ###

pig_software:
  file.managed:
    - name: /home/{{ pillar['username'] }}/software/pig-{{ pig_version }}.tar.gz
    - source: http://mirror.mel.bkb.net.au/pub/apache/pig/pig-{{ pig_version }}/pig-{{ pig_version }}.tar.gz
    - source_hash: sha1={{ pig_sha1 }}
    - require:
      - file: software_directory

extract_pig:
  cmd.run:
    - name: tar zxvf pig-{{ pig_version }}.tar.gz
    - unless: test -d /home/{{ pillar['username'] }}/software/pig-{{ pig_version }}/
    - user: {{ pillar['username'] }}
    - cwd: /home/{{ pillar['username'] }}/software/
    - require:
      - file: pig_software

#### SET BASH PATH ###

hadoop_environment_variables:
  file.append:
    - name: /home/{{ pillar['username'] }}/.profile
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - text:
      - export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
      - export HADOOP_INSTALL=/home/{{ pillar['username'] }}/software/hadoop-{{ hadoop_version }}
      - export PIG_INSTALL=/home/{{ pillar['username'] }}/software/pig-{{ pig_version }}
      - export PATH=$PATH:$HADOOP_INSTALL/sbin:$HADOOP_INSTALL/bin:$PIG_INSTALL/bin
