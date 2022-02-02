#!/bin/sh

set -e

# display software versions
convert -version
mc --version

# configure connection to the S3 bucket
mc alias set s3endpoint http://s3:8080 admin thisisasecret
mc tree -f s3endpoint/bucket

mc find s3endpoint/bucket -name '*.tif' --json | jq

exit 0
