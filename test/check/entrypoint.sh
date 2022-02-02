#!/bin/sh

# display software versions
mc --version

# configure connection to the S3 bucket
mc alias set s3endpoint "${S3_ENDPOINT}" "${S3_ACCESS_KEY}" "${S3_SECRET_KEY}"

# list files
TREE=$(mc tree -f s3endpoint/bucket)

echo "${TREE}" | grep "tif" 2>&1 > /dev/null
if [ "$?" -eq 0 ]; then
  echo "ERROR: sources files are still present." >&2
  exit 1
fi

echo "${TREE}" | grep "jp2" 2>&1 > /dev/null
if [ "$?" -ne 0 ]; then
  echo "ERROR: files were not converted." >&2
  exit 1
fi

echo "SUCCESS!"

exit 0
