base:
    'role:hadoop':
        - match: grain
        - hadoop
        - disco
    'role:desktop':
        - match: grain
        #- vagrant
        - desktop
        - cli
        - python-dev
        - r
