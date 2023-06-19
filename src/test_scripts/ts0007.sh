#!/bin/bash

# Replace with your Application Insights instrumentation key
INSTRUMENTATION_KEY="$APP_INSIGHT_INSTRUMENTATION_KEY"

# Replace with your build ID
BUILD_ID="$APP_INSIGHT_BUILD_ID"

# Event name and BuildID property
EVENT_NAME="LoadTest:Start"
PROPERTY_KEY="BuildID"

# Endpoint URL for Application Insights
ENDPOINT_URL="https://dc.services.visualstudio.com/v2/track"

# Create a JSON payload for the custom event
JSON_PAYLOAD=$(cat << EOF
{
  "name": "Microsoft.ApplicationInsights.Event",
  "time": "$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")",
  "iKey": "$INSTRUMENTATION_KEY",
  "data": {
    "baseType": "EventData",
    "baseData": {
      "ver": 2,
      "name": "$EVENT_NAME",
      "properties": {
        "$PROPERTY_KEY": "$BUILD_ID"
      }
    }
  }
}
EOF
)

# Use curl to send the POST request
curl -X POST -H "Content-Type: application/json" -d "$JSON_PAYLOAD" $ENDPOINT_URL
