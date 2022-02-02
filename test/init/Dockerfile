FROM docker.io/minio/mc:latest AS minio

FROM docker.io/library/alpine:3.15
COPY --from=minio /bin/mc /bin
RUN apk add --no-cache tini

# only here to test that required binaries are available
RUN mc --version

# add required files
WORKDIR /app
COPY entrypoint.sh image.tif ./
RUN chmod +x entrypoint.sh
CMD [ "tini", "--", "/app/entrypoint.sh" ]
