set -e

./node_modules/.bin/ajv compile -s schema.json

for file in deps/*
do 
  ./node_modules/.bin/ajv validate -s schema.json -d $file
done
