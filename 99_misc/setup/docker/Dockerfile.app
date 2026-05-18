FROM python:3.11-alpine AS base
COPY ./example_app/pyproject.toml ./
RUN apk add --no-cache --update build-base git python3-dev
RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install --no-root

FROM python:3.11-alpine
ARG APP_VERSION
ENV APP_VERSION=${APP_VERSION}
LABEL MAINTAINER=Silent-Mobius VERSION=${APP_VERSION}
WORKDIR /home/app
RUN apk add --no-cache git openssh sudo python3 vim nano uptimed bash shadow libuser 
COPY --from=base /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages 
COPY --from=base /usr/local/bin /usr/local/bin
COPY id_rsa.pub  /root/.ssh/authorized_keys
COPY ./example_app /home/docker/
COPY node.sh /entrypoint.sh
EXPOSE 8000
EXPOSE 5000
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "gunicorn", "--config", "/home/docker/gunicorn_conf.py", "src.example:app" ]
