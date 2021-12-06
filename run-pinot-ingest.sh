#!/bin/bash

# docker run --name "PinotTableauTest" -ti -d -p 9000:9000 -p 8000:8000 apachepinot/pinot:0.9.0-SNAPSHOT-aed6adae5-20211019-jdk11 QuickStart -type BATCH
#
docker exec -ti PinotTableauTest mkdir /tmp/batters
docker exec -ti PinotTableauTest mkdir /tmp/calcs
docker exec -ti PinotTableauTest mkdir /tmp/staples

docker exec -ti PinotTableauTest mkdir /tmp/batters/rawdata
docker exec -ti PinotTableauTest mkdir /tmp/calcs/rawdata
docker exec -ti PinotTableauTest mkdir /tmp/staples/rawdata

# Batters
docker cp batters-table-config.json PinotTableauTest:/tmp/batters
docker cp batters-schema.json PinotTableauTest:/tmp/batters
docker cp batters-ingestion-spec.yml PinotTableauTest:/tmp/batters
docker cp Batters.csv PinotTableauTest:/tmp/batters/rawdata
docker exec -ti PinotTableauTest bin/pinot-admin.sh AddTable -tableConfigFile /tmp/batters/batters-table-config.json -schemaFile /tmp/batters/batters-schema.json -exec
docker exec -ti PinotTableauTest bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/batters/batters-ingestion-spec.yml

# Calcs
docker cp calcs-table-config.json PinotTableauTest:/tmp/calcs
docker cp calcs-schema.json PinotTableauTest:/tmp/calcs
docker cp calcs-ingestion-spec.yml PinotTableauTest:/tmp/calcs
docker cp Calcs.csv PinotTableauTest:/tmp/calcs/rawdata
docker exec -ti PinotTableauTest bin/pinot-admin.sh AddTable -tableConfigFile /tmp/calcs/calcs-table-config.json -schemaFile /tmp/calcs/calcs-schema.json -exec
docker exec -ti PinotTableauTest bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/calcs/calcs-ingestion-spec.yml

# Staples
docker cp staples-table-config.json PinotTableauTest:/tmp/staples
docker cp staples-schema.json PinotTableauTest:/tmp/staples
docker cp staples-ingestion-spec.yml PinotTableauTest:/tmp/staples
docker cp Staples_utf8.csv PinotTableauTest:/tmp/staples/rawdata
docker exec -ti PinotTableauTest bin/pinot-admin.sh AddTable -tableConfigFile /tmp/staples/staples-table-config.json -schemaFile /tmp/staples/staples-schema.json -exec
docker exec -ti PinotTableauTest bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/staples/staples-ingestion-spec.yml
