#!/bin/bash
# your_script.sh
# This script runs a load test using Newman with 50 parallel clients for 10 minutes.

# Exit immediately if a command exits with a non-zero status.
set -e

# Total duration in seconds (10 minutes = 600 seconds)
DURATION=600

# Calculate the end time by adding the duration to the current seconds elapsed.
end_time=$((SECONDS + DURATION))

# Define the path to your Postman collection JSON file.
# Using dirname "$0" gets the directory of this script.
COLLECTION_PATH="$(dirname "$0")/../collections/collection.json"

# (Optional) If you have an environment file, uncomment and set its path.
# ENVIRONMENT_PATH="$(dirname "$0")/../collections/your_environment.json"

echo "Starting load test for 10 minutes with 50 parallel Newman instances..."

# Loop until the total duration has passed
while [ $SECONDS -lt $end_time ]; do
  # Start 50 Newman runs in parallel
  for i in {1..50}; do
    # If using an environment file, uncomment the next line and comment the line after it.
    # newman run "$COLLECTION_PATH" --environment "$ENVIRONMENT_PATH" &
    npx newman run "$COLLECTION_PATH" &
  done

  # Wait for all background Newman processes to complete before starting the next batch
  wait
done

echo "Load test completed."
