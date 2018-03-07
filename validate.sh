set -e

./node_modules/.bin/ajv compile -s schema.json
if ! diff -B -q schema.json <(./node_modules/.bin/jsonlint schema.json); then
  echo "JSON lint errors in schema.json. Run 'npm run lint' to clean up."
  diff -B schema.json <(./node_modules/.bin/jsonlint schema.json)
  exit 1
fi

for file in deps/*
do 
  ./node_modules/.bin/ajv validate -s schema.json -d $file
done
