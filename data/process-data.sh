#!/bin/bash

PGURI="postgres://covidviz:$POSTGRES_PASSWORD@db:5432/database"
TMPDIR=tmp

shopt -s expand_aliases
alias psqlc="psql $PGURI -c"

if cd /data; then
  # Create & enter temp directory
  rm -rf $TMPDIR
  mkdir -p $TMPDIR
  cd $TMPDIR

  # Download csv.gz files
  echo "Cloning data files..."
  degit --force ambientpointcorp/covid19-philadelphia/cases_by_zipcode
  
  # Unzip
  echo "Unzipping..."
  gunzip ./*.gz
  echo "Done."

  # Create tables if not already created
  psqlc "CREATE TABLE IF NOT EXISTS tests(zip integer not null, timestamp date not null, negative integer, positive integer);"
  psqlc "CREATE TABLE IF NOT EXISTS processed(file varchar(255) not null);"

  # Copy into database
  for file in *.csv; do
    echo "Processing $file..."

    if psqlc "SELECT file FROM processed WHERE file='$file';" | grep "(0 rows)"; then
      # Fix csv column issues
      firstcol=$(awk -F, "NR==1{print \$3}" $file)
      [[ $firstcol == "POS" ]] && colorder="negative, positive" || colorder="positive, negative"

      # Do the copying and let the db know which files we processed.
      cat $file | psqlc "COPY tests(zip, timestamp, $colorder) FROM STDIN WITH DELIMITER ',' NULL AS 'NA' CSV HEADER;" \
      && psqlc "INSERT INTO processed(file) VALUES('$file')"

    else 
      echo "Already processed $file."

    fi
  done

  # Clean up
  # (This won't run if anything above errors :/ )
  rm -rf $TMPDIR

else 
  echo "Could not enter data directory /data."

fi