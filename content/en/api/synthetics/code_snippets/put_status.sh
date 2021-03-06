#!/bin/bash

api_key="<DATADOG_API_KEY>"
app_key="<DATADOG_APPLICATION_KEY>"
public_id=<SYNTHETICS_TEST_PUBLIC_ID>

curl -X PUT \
-H "Content-type: application/json" \
-H "DD-API-KEY: ${api_key}" \
-H "DD-APPLICATION-KEY: ${app_key}" \
-d '{"new_status":"paused"}' \
"https://api.datadoghq.com/api/v1/synthetics/tests/${public_id}/status"
