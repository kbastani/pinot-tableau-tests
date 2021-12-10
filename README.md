# Tableau Connector Tests for Apache Pinot

This repository provides instructions for running [Tableau's connector tests (TDVT)](https://tableau.github.io/connector-plugin-sdk/docs/tdvt) on [Apache Pinot](https://pinot.apache.org).

## Overview

Apache Pinot provides integration support for Tableau through a JDBC client that queries Pinot over HTTP. Tableau's integration strategy for third-party database vendors is to use Java's open source JDBC specification to execute SQL queries. To provide vendors with a baseline for compliance and compatibility of a particular JDBC driver implementation, Tableau has created an open source [testing suite called TDVT](https://tableau.github.io/connector-plugin-sdk/docs/tdvt).

This repository provides customized datasets extended from the Tableau connector resources so that users can easily run the TDVT testing suite on Apache Pinot.

### What's included?

This repository provides the following resources to replicate and onboard the test data provided by Tableau.

- Test datasets
- Schema and table configuration
- Bootstrap scripts
- Instructions for replicating test results

## Usage

To get started, first, build and start Apache Pinot locally from source. Follow the instructions provided for building the Pinot JDBC client located here: [https://docs.pinot.apache.org/integrations/tableau#install-pinot-jdbc-for-tableau-desktop](https://docs.pinot.apache.org/integrations/tableau#install-pinot-jdbc-for-tableau-desktop)

Once you've installed the Pinot JDBC driver for Tableau Desktop, you'll need to replicate and onboard the test datasets required for running the test suite.

### Onboarding the TDVT Test Data

Start Pinot locally so that you have HTTP access to both the Pinot controller and broker. You will not be able to query Pinot using the JDBC client using Docker, due to the way that host networking works in the JDBC driver implementation. Once Pinot is running locally, you'll need to run two provided shell scripts that will create the required tables in Pinot.

```bash
$ sh ./run-pinot-ingest-local.sh
```

Now, navigate to the Pinot distribution directory that you used to start Pinot locally. Run the following script.

```bash
bin/pinot-admin.sh AddTable -tableConfigFile /tmp/batters/batters-table-config.json -schemaFile /tmp/batters/batters-schema.json -exec
bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/batters/batters-ingestion-spec.yml

bin/pinot-admin.sh AddTable -tableConfigFile /tmp/calcs/calcs-table-config.json -schemaFile /tmp/calcs/calcs-schema.json -exec
bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/calcs/calcs-ingestion-spec.yml

bin/pinot-admin.sh AddTable -tableConfigFile /tmp/staples/staples-table-config.json -schemaFile /tmp/staples/staples-schema.json -exec
bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /tmp/staples/staples-ingestion-spec.yml
```

After running the script, the datasets for the TDVT tests should now be created as tables that are ready to query.

### Setup Your TDVT Test Environment

Now that the datasets are loaded and you've installed the Pinot JDBC driver for Tableau Desktop, you will now need to follow the Tableau Connector SDK directions that will bootstrap your testing environment. The instructions for setting up your TDVT environment can be found here: [https://tableau.github.io/connector-plugin-sdk/docs/tdvt](https://tableau.github.io/connector-plugin-sdk/docs/tdvt)

Since the test data has been provided by this repository, you will skip the parts of the TDVT instructions that you've already done as a part of this repository.

### Configure TDVT Test Environment

As you follow the directions provided by Tableau for setting up your test environment, you will need to configure your environment specifically for Apache Pinot. Please use the following `mydb.ini` configuration that is required for you to successfully run the tests using the SQL semantics that Pinot supports.

```text
[Datasource]
Name = mydb
LogicalQueryFormat = my_logical_query
CommandLineOverride = -DLogLevel=Debug

[LogicalConfig]
Name = my_logical_query
tablename = $dsName
tablePrefix =
tablePostfix =
tablenameUpper = False
tablenameLower = True
bool_underscore = False
fieldnameDate_underscore = False
fieldnameLower = True
fieldnameUpper = False
fieldnameNoSpace = True
fieldnameLower_underscore = False
fieldnameUnderscoreNotSpace = True

[StandardTests]
ExpressionExclusions_Standard = string.isdate, date.datediff.*
LogicalExclusions_Calcs = BUGS.B26728, Filter.Date_In
LogicalExclusions_Staples = lod.17_Nesting

[LODTests]

[UnionTest]

[ConnectionTests]
StaplesTestEnabled = True
CastCalcsTestEnabled = True
```

If you've done everything correctly, you will now be able to run the test suite that will query Pinot using JDBC.
