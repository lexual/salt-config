{% if grains['os'] == 'Debian' %}
username: lexdeb
{% elif grains['os'] == 'Ubuntu' %}
username: lexubu
{% elif grains['os'] == 'Fedora' %}
username: lexfed
{% endif %}
