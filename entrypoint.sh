#!/bin/bash

export PYTHONPATH=/mood2anime/pythonPackage

python3 manage.py migrate && \
  python3 manage.py collectstatic --clear --noinput && \
  python3 manage.py import --path "$DJANGO_IMPORT_PATH"

python3 -m gunicorn --bind "127.0.0.1:8080" mood2anime.wsgi