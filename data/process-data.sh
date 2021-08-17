#!/bin/bash

PGURI="postgres://covidviz:$POSTGRES_PASSWORD@db:5432/database"
DONEFILE=/data/already_processed.txt

mkdir -p /data/tmp && cd /data/tmp

# Delete existing files
rm -rf ./*
# Download csv.gz files
degit --force ambientpointcorp/covid19-philadelphia/cases_by_zipcode
# Unzip
gunzip ./*

# Copy into database
for file in *; do
  if grep -Fxq "$file" $DONEFILE; then
    echo "Already processed $file"
  else 
    # Fix csv column issues
    firstcol=$(awk -F, "NR==1{print \$3}" $file)
    [[ $firstcol == "POS" ]] && colorder="negative, positive" || colorder="positive, negative"
    # Do the copying!
    cat "$file" | psql "$PGURI" -c \
    "COPY tests(zip, timestamp, $colorder) FROM STDIN WITH DELIMITER ',' NULL AS 'NA' CSV HEADER" \
    && echo "$file" >> $DONEFILE
  fi
done
