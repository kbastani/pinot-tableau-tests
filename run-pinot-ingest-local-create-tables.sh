#!/bin/bash

bin/pinot-admin.sh AddTable -tableConfigFile /tmp/batters/batters-table-config.json -schemaFile /tmp/batters/batters-schema.json -exec
bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/batters/batters-ingestion-spec.yml

bin/pinot-admin.sh AddTable -tableConfigFile /tmp/calcs/calcs-table-config.json -schemaFile /tmp/calcs/calcs-schema.json -exec
bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/calcs/calcs-ingestion-spec.yml

bin/pinot-admin.sh AddTable -tableConfigFile /tmp/staples/staples-table-config.json -schemaFile /tmp/staples/staples-schema.json -exec
bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/staples/staples-ingestion-spec.yml
