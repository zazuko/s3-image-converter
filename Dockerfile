FROM docker.io/minio/mc:latest AS minio

FROM docker.io/library/alpine:3.15
COPY --from=minio /bin/mc /bin
RUN apk add --no-cache imagemagick tini

# only here to test that required binaries are available
RUN convert -version
RUN mc --version

# configure entrypoint
WORKDIR /app
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
CMD [ "tini", "--", "/app/entrypoint.sh" ]
