harbor-minio-ingress:
  file.managed:
    - require:
      - file: /srv/kubernetes/manifests/harbor
    - name: /srv/kubernetes/manifests/harbor/ingress.yaml
    - source: salt://{{ tpldir }}/templates/ingress.yaml.j2
    - template: jinja
    - user: root
    - group: root
    - mode: "0644"
    - context:
      tpldir: {{ tpldir }}
  cmd.run:
    - watch:
      - file: /srv/kubernetes/manifests/harbor/ingress.yaml
    - runas: root
    - name: kubectl apply -f /srv/kubernetes/manifests/harbor/ingress.yaml