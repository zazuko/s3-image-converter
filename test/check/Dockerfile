FROM docker.io/minio/mc:latest AS minio

FROM docker.io/library/alpine:3.15
COPY --from=minio /bin/mc /bin
RUN apk add --no-cache tini grep

# only here to test that required binaries are available
RUN mc --version

# add entrypoint
WORKDIR /app
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# configure default values for environment variables
ENV S3_ENDPOINT="http://s3:8080"
ENV S3_ACCESS_KEY="admin"
ENV S3_SECRET_KEY="thisisasecret"
ENV S3_BUCKET="bucket"

CMD [ "tini", "--", "/app/entrypoint.sh" ]
