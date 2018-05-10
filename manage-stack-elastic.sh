#!/bin/bash

build() {
  echo "Building docker-elastic stack..."
  echo ""
  docker-compose -f ~/docker-stacks/docker-elastic/elastic-stack.yml build
  echo ""
  echo "Done!"
}

start() {
  echo "Starting docker-elastic stack..."
  echo ""
  docker-compose -f ~/docker-stacks/docker-elastic/elastic-stack.yml up $1
  echo ""
  echo "Done!"
}

stop() {
  echo "Stopping docker-elastic stack..."
  echo ""
  docker-compose -f ~/docker-stacks/docker-elastic/elastic-stack.yml stop
  echo ""
  echo "Done!"
}

cluster-status() {
  echo "Elastic cluster status"
  echo ""
  curl http://127.0.0.1:9200/_cat/health
}

case "$1" in
  build)   build ;;
  start)   start $2 ;;
  stop)    stop ;;
  restart) stop; start $2 ;;
  cluster-status)  cluster-status ;;
  *)  echo ""
      echo "Usage:  $0 COMMAND [option]" >&2
      echo ""
      echo "Utility script to manage Docker stacks"
      echo ""
      echo "Commands:"
      echo ""
      echo "  build: Build Docker stack"
      echo "  start [-d]: Starts Docker stack, [-d for demonize it]"
      echo "  stop: Stops Docker stack"
      echo "  restart [-d]: Restarts Docker stack,  [-d for demonize start]"
      echo "  destroy: Destroys Docker resources in entire projecy or only for this stack"
      echo "  cluster-status: Elastic cluster status"
      echo ""
      exit 1
    ;;
esac
