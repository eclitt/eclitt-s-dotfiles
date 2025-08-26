#!/bin/bash
curl -s -m 1 'wttr.in?format=1' \
  | awk '{$1=$1; print}' \
  || echo 'no connection 🌐'