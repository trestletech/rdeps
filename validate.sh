#!/bin/bash

set -e

./node_modules/.bin/ajv compile -s schema.json
if ! diff -q schema.json <(./node_modules/.bin/jsonlint schema.json); then
  echo "JSON lint errors in schema.json. Run 'npm run lint' to clean up."
  diff schema.json <(./node_modules/.bin/jsonlint schema.json)
  exit 1
fi

for file in deps/*
do 
  ./node_modules/.bin/ajv validate -s schema.json -d $file
  if ! diff -q $file <(./node_modules/.bin/jsonlint $file); then
    echo "JSON lint errors in $file. Run 'npm run lint' to clean up."
    diff $file <(./node_modules/.bin/jsonlint $file)
    exit 1
  fi
done
