#!/usr/bin/env bash

redis_delete_by_prefix() {
  redis-cli --raw keys "$1*" | xargs redis-cli del
}
