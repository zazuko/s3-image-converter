# S3 Image Converter

## Use case

This work is meant if you need to convert one file format to another one in a S3 bucket.
Once the conversion finish, the container will stop.

You can imagine running this as a cronjob.

You can pull the Docker image like this:

```sh
docker pull ghcr.io/zazuko/s3-image-converter:latest
```

## Configuration

Configuration can be done using the following environment variables:

- `S3_ENDPOINT`: S3 endpoint (default value: `http://s3:8080`)
- `S3_ACCESS_KEY`: access key for the S3 endpoint (default value: `admin`)
- `S3_SECRET_KEY`: secret key for the S3 endpoint (default value: `thisisasecret`)
- `S3_BUCKET`: name of the S3 bucket (default value: `bucket`)
- `IMAGE_FROM`: extension of the images to convert from (default value: `tif`)
- `IMAGE_TO`: extension of the images to convert to (default value: `jp2`)
- `REMOVE_SOURCE_IMAGE`: remove the source image from the bucket (default value: `false`)
