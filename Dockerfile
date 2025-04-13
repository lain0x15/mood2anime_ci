FROM python:3.12-slim

ENV DJANGO_DEBUG=True

ENV DJANGO_CSRF_TRUSTED_ORIGINS=""

ENV DJANGO_WEBSITE_DNS_NAME="localhost"

ENV PYTHONPATH=/mood2anime/pythonPackage

RUN groupadd --gid 10101 mood2anime && useradd --uid 10101 -g mood2anime -M -d /nonexistent -s /bin/false mood2anime

COPY --chown=root:mood2anime --chmod=750 ./mood2anime /mood2anime

WORKDIR /mood2anime

RUN export PYTHONPATH=/mood2anime/pythonPackage; pip install --target /mood2anime/pythonPackage -r ./requirements.txt && python3 manage.py migrate && python3 manage.py collectstatic --clear --noinput

RUN chown root:mood2anime -R /mood2anime && chmod 750 -R /mood2anime

USER mood2anime

EXPOSE 8080

ENTRYPOINT ["bash", "-c"]

CMD ["python3 manage.py runserver 0.0.0.0:8080"]