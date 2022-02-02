#!/bin/sh

set -e

# display software versions
convert -version
mc --version

# check if input and output format will be different
if [ "${IMAGE_FROM}" = "${IMAGE_TO}" ]; then
  echo "Converting from ${IMAGE_FROM} to ${IMAGE_TO} will be the same. Exiting." >&2
  exit 1
fi

# create a temporary work directory
mkdir -p tmp-work-dir
cd tmp-work-dir

# configure connection to the S3 bucket
mc alias set s3endpoint "${S3_ENDPOINT}" "${S3_ACCESS_KEY}" "${S3_SECRET_KEY}"

# loop over each file
IMAGES_FILES=$(mc find "s3endpoint/${S3_BUCKET}" -name "*.${IMAGE_FROM}" --json | jq -r '.key | @sh')
for file in $IMAGES_FILES; do
  f=$(echo "${file}" | sed 's/^\x27\(.*\)\x27$/\1/')
  TMP_SRC_FILE="image.${IMAGE_FROM}"
  TMP_DST_FILE="image.${IMAGE_TO}"
  echo "- Processing file: ${f}"
  echo "  - Fetching file from bucket…"
  mc cp "${f}" "${TMP_SRC_FILE}"
  echo "  - Converting file from ${IMAGE_FROM} to ${IMAGE_TO}…"
  convert "${TMP_SRC_FILE}" -quality 0 "${TMP_DST_FILE}"
  rm -f "${TMP_SRC_FILE}"

  echo "  - Upload following files:"
  for generated_file in *.${IMAGE_TO}; do
    FILE_PREFIX=$(echo "${f}" | sed "s/\.${IMAGE_FROM}$//")
    FILE_SUFFIX=$(echo "${generated_file}" | sed 's/^image//')
    FINAL_FILE_NAME="${FILE_PREFIX}${FILE_SUFFIX}"
    echo "    - ${FILE_PREFIX}${FILE_SUFFIX}"
    mc cp "${generated_file}" "${FINAL_FILE_NAME}"
    rm -f "${generated_file}"

    if [ "${REMOVE_SOURCE_IMAGE}" = "true" ]; then
      mc rm --force "${f}"
    fi
  done
done

cd ..
rm -rf tmp-work-dir

exit 0
