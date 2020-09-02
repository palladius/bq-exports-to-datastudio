This repo will help you set up GCP billing on Datastudio, alongside
forecasts and stuff.



# Instructions

1. Copy Data Studio template: https://datastudio.google.com/c/u/0/reporting/0B7GT7ZlyzUmCZHFhNDlKVENHYmc/page/tLtE

2. Follow instructions on "How to Copy". Alternative you can use `make install`

3. TODO(ricc): use Dtastudio APIs to automate the rest.

# Original instructions by Mike

## 1. Create the Billing Export Data Source

​1) Navigate to the Billing -> Billing Export section in the cloud console.

2) Select the BigQuery export, project, and dataset which data will be exported to (See docs [1] for additional help).

3) Navigate to DataStudio and create [2] a Data Source over the new billing table.

## 2. Create the Spending Trends Data Source

1) Navigate to DataStudio and create a Data Source using the BigQuery "Custom Query" source. Paste in the contents of the query at https://bit.ly/2KXHk2G. You'll need to change the dataset and table names to match your datasets and tables.

## 3. Create the BigQuery Audit Data Source

​1) Click here [3] to navigate to the Stackdriver Logging pane in the cloud console.

2) Select BigQuery from the dropdown of resources and click the Create Export button at the top of the screen.

3) Name the export, select BigQuery as the destination, choose the dataset you would like the logs output to and click create. You'll need to create the dataset first.

4) Once, audit data is flowing to your dataset (normally a few mins, you may want to run a few test queries to generate some data) , create a view on top of the audit table using the saved query at https://goo.gl/PSFzNN. You'll need to replace the dataset with your own for the query to work over your dataset.

5) Navigate to DataStudio and create [4] a Data Source over the BigQuery view. Be sure to change the TotalCost field to a currency data type.

## 4. Copy the report

​1) In the top right-hand of this report, click the copy button

2) Map the Data Source of the copied report to your own and you're done!

# Thanks

* Mike Zinni for starting this all


[1] https://cloud.google.com/logging/docs/export/configure_export_v2
[2] https://support.google.com/datastudio/answer/6295968?hl=en&ref_topic=6295893
[3] https://console.cloud.google.com/logs/viewer?resource=bigquery_resource
[4] https://support.google.com/datastudio/answer/6295968?hl=en&ref_topic=6295893