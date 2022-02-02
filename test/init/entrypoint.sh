#!/bin/sh

set -e

# display software versions
mc --version

# configure connection to the S3 bucket
mc alias set s3endpoint "${S3_ENDPOINT}" "${S3_ACCESS_KEY}" "${S3_SECRET_KEY}"

# create a bucket
mc mb s3endpoint/bucket

# add an image
mc cp image.tif s3endpoint/bucket
mc cp image.tif s3endpoint/bucket/subdir/other.tif

# list files
mc tree -f s3endpoint/bucket

exit 0
