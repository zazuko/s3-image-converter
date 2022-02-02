#!/bin/sh

echo "Test the Docker image"

# display steps with date and time
print_step() {
  CURRENT_DATE=$(date +"%m-%d-%Y %T")
  echo "\n\n[${CURRENT_DATE}] $1"
}

print_step "Build and pull images"
docker-compose pull
docker-compose build

print_step "Start the stack"
docker-compose up --remove-orphans -d

print_step "Wait that the stack is ready"
RETRIES=60
while true; do
  curl -sL http://localhost:8080/minio/health/live
  if [ "$?" -eq 0 ]; then
    break
  fi

  RETRIES=$((RETRIES-1))
  if [ "${RETRIES}" -le 0 ]; then
    echo "Stack is not ready :(" >&2
    exit 1
  fi

  sleep 1
done
echo "The stack is ready! :)"

print_step "Create bucket and put an image there"
docker-compose \
  -f docker-compose.yaml \
  -f init/docker-compose.yaml \
  up --remove-orphans --build init

print_step "Remove the stack"
docker-compose down

exit 0
