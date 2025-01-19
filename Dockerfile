FROM python:3.12-slim

RUN groupadd --gid 10101 mood2anime && useradd --uid 10101 -g mood2anime -ms /bin/bash mood2anime

USER mood2anime

ENV DJANGO_DEBUG=True

ENV DJANGO_CSRF_TRUSTED_ORIGINS=""

COPY --chown=mood2anime:mood2anime --chmod=750 ./mood2anime /mood2anime

WORKDIR /mood2anime

RUN pip install -r ./requirements.txt && python3 manage.py migrate && python3 manage.py collectstatic --clear --noinput

USER root

RUN chown root -R /mood2anime && chmod 750 -R /mood2anime

USER mood2anime

EXPOSE 8080

ENTRYPOINT ["bash", "-c"]

CMD ["python3 manage.py runserver 0.0.0.0:8080"]