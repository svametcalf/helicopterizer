FROM alpine:3.4

MAINTAINER frekele <leandro.freitas@softdevelop.com.br>

RUN apk add --update --no-cache \
       bash \
       curl \
       wget \
       git \
       python\
       py-pip \
       docker \
    && curl -sL https://get.docker.com/builds/Linux/x86_64/docker-1.11.2 > /usr/bin/docker \
    && chmod +x /usr/bin/docker \
    && pip install --upgrade pip \
    && pip install awscli \

    && curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron \
    && chmod u+x /usr/local/bin/go-cron \
    && apk del curl

ADD ./scripts /scripts

RUN chmod -R +x /scripts

ENV STORAGE_PROVIDER='' \
    BACKUP_NAME='' \
    DATA_PATH='/data/' \
    DATA_PATH_EXCLUDE='' \
    GZIP_COMPRESSION='true' \
    CLEAN_DATA_BEFORE_RESTORE='false' \
    BACKUP_VERSION='' \
    CRON_SCHEDULE='' \
    AWS_ACCESS_KEY_ID='' \
    AWS_SECRET_ACCESS_KEY='' \
    AWS_S3_BUCKET_CREATE='false' \
    AWS_S3_BUCKET_NAME='' \
    AWS_S3_PATH='/' \
    AWS_DEFAULT_REGION='us-east-1' \
    AWS_S3_OPTIONS=''

ENTRYPOINT ["/scripts/run.sh"]

CMD [""]
