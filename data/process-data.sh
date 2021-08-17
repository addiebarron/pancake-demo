#!/bin/bash

PGURI="postgres://covidviz:$POSTGRES_PASSWORD@db:5432/database"
DONEFILE=processed.txt
TMPDIR=tmp

if cd data; then

  # Create donefile if it doesn't exist
  touch $DONEFILE
  # Create & enter temp directory
  rm -rf $TMPDIR
  mkdir -p $TMPDIR
  cd $TMPDIR
  # Download csv.gz files
  degit --force ambientpointcorp/covid19-philadelphia/cases_by_zipcode
  # Unzip
  gunzip ./*.gz

  # Create table if not already created
  psql $PGURI -c "CREATE TABLE IF NOT EXISTS tests(zip integer not null, timestamp date not null, negative integer, positive integer);"

  # Copy into database
  for file in *.csv; do
    if grep -Fxq $file $DONEFILE; then
      echo "Already processed $file"
    else 
      # Fix csv column issues
      firstcol=$(awk -F, "NR==1{print \$3}" $file)
      [[ $firstcol == "POS" ]] && colorder="negative, positive" || colorder="positive, negative"
      # Do the copying!
      cat $file | psql $PGURI -c \
      "COPY tests(zip, timestamp, $colorder) FROM STDIN WITH DELIMITER ',' NULL AS 'NA' CSV HEADER;" \
      && echo $file >> $DONEFILE
    fi
  done

  # Clean up
  # (This won't run if anything above errors)
  rm -rf $TMPDIR
fi