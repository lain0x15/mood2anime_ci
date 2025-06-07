FROM python:3.12-slim

ENV DJANGO_DEBUG=True

ENV DJANGO_CSRF_TRUSTED_ORIGINS=""

ENV DJANGO_WEBSITE_DNS_NAME="localhost"

ENV DJANGO_IMPORT_PATH="/mood2anime_DB"

RUN groupadd --gid 101 mood2anime && \
    useradd --uid 101 -g mood2anime -M -d /nonexistent -s /bin/false mood2anime

COPY --chown=mood2anime:mood2anime --chmod=750 ./entrypoint.sh /entrypoint.sh

COPY --chown=mood2anime:mood2anime --chmod=750 ./mood2anime /mood2anime

WORKDIR /mood2anime

RUN PYTHONPATH=/mood2anime/pythonPackage pip install --target /mood2anime/pythonPackage -r ./requirements.txt

USER mood2anime

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]