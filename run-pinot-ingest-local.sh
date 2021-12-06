#!/bin/bash

mkdir /tmp/batters
mkdir /tmp/calcs
mkdir /tmp/staples

mkdir /tmp/batters/rawdata
mkdir /tmp/calcs/rawdata
mkdir /tmp/staples/rawdata

# Batters
cp batters-table-config.json /tmp/batters
cp batters-schema.json /tmp/batters
cp batters-ingestion-spec.yml /tmp/batters
cp Batters.csv /tmp/batters/rawdata
#bin/pinot-admin.sh AddTable -tableConfigFile /tmp/batters/batters-table-config.json -schemaFile /tmp/batters/batters-schema.json -exec
#bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/batters/batters-ingestion-spec.yml

# Calcs
cp calcs-table-config.json /tmp/calcs
cp calcs-schema.json /tmp/calcs
cp calcs-ingestion-spec.yml /tmp/calcs
cp Calcs.csv /tmp/calcs/rawdata
#bin/pinot-admin.sh AddTable -tableConfigFile /tmp/calcs/calcs-table-config.json -schemaFile /tmp/calcs/calcs-schema.json -exec
#bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/calcs/calcs-ingestion-spec.yml

# Staples
cp staples-table-config.json /tmp/staples
cp staples-schema.json /tmp/staples
cp staples-ingestion-spec.yml /tmp/staples
cp Staples_utf8.csv /tmp/staples/rawdata
#bin/pinot-admin.sh AddTable -tableConfigFile /tmp/staples/staples-table-config.json -schemaFile /tmp/staples/staples-schema.json -exec
#bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/staples/staples-ingestion-spec.yml
