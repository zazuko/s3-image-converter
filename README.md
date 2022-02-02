# S3 Image Converter

## Configuration

Configuration can be done using the following environment variables:

- `S3_ENDPOINT`: S3 endpoint (default value: `http://s3:8080`)
- `S3_ACCESS_KEY`: access key for the S3 endpoint (default value: `admin`)
- `S3_SECRET_KEY`: secret key for the S3 endpoint (default value: `thisisasecret`)
- `IMAGE_FROM`: extension of the images to convert from (default value: `tif`)
- `IMAGE_TO`: extension of the images to convert to (default value: `jp2`)
- `REMOVE_SOURCE_IMAGE`: remove the source image from the bucket (default value: `false`)
