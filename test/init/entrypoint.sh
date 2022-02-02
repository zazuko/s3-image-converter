#!/bin/sh

set -e

# display software versions
mc --version

# configure connection to the S3 bucket
mc alias set test http://s3:8080 admin thisisasecret

# create a bucket
mc mb s3://test/test

# add an image
mc cp image.tif s3://test/test

# list files
mc ls s3://test/test

exit 0
