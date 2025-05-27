#!/bin/bash

# Filter the coverage data to include only relevant files
lcov --extract coverage/lcov.info '**/*_viewmodel*.dart' 'lib/services/*' -o coverage/lcov_filtered.info
lcov --extract coverage/lcov.info 'lib/services/*' -o coverage/lcov_filtered_services.info
lcov --extract coverage/lcov.info '**/*_viewmodel*.dart' -o coverage/lcov_filtered_viewmodel.info

# Check coverage for specific files and directories
ACTUAL_VIEWMODEL_COVERAGE=$(genhtml coverage/lcov_filtered_viewmodel.info -o coverage/report | grep "lines......: " | awk '{gsub("%","",$2); print int($2)}')
ACTUAL_SERVICES_COVERAGE=$(genhtml coverage/lcov_filtered_services.info -o coverage/report | grep "lines......: " | awk '{gsub("%","",$2); print int($2)}')

# Check the overall coverage
ACTUAL_OVERALL_COVERAGE=$(genhtml coverage/lcov_filtered.info -o coverage/report | grep "lines......: " | awk '{gsub("%","",$2); print int($2)}')

echo "Overall coverage ($ACTUAL_OVERALL_COVERAGE)"

# Set coverage thresholds
# THRESHOLD_VIEWMODEL=65
# THRESHOLD_SERVICES=62
# THRESHOLD_OVERALL=64

# Set thresholds to highest once we have a feature ready
THRESHOLD_VIEWMODEL=0
THRESHOLD_SERVICES=0
THRESHOLD_OVERALL=0

exitExecution=false

# Check overall coverage
if [ "$ACTUAL_OVERALL_COVERAGE" -lt "$THRESHOLD_OVERALL" ]; then
  echo "Overall coverage ($ACTUAL_OVERALL_COVERAGE) is less than $THRESHOLD_OVERALL%, failing the build."
  exitExecution=true
fi

# Check coverage for specific files and directories
if [ "$ACTUAL_VIEWMODEL_COVERAGE" -lt "$THRESHOLD_VIEWMODEL" ]; then
  echo "ViewModel coverage ($ACTUAL_VIEWMODEL_COVERAGE) is less than $THRESHOLD_VIEWMODEL%, failing the build."
  exitExecution=true
fi

if [ "$ACTUAL_SERVICES_COVERAGE" -lt "$THRESHOLD_SERVICES" ]; then
  echo "Services coverage ($ACTUAL_SERVICES_COVERAGE) is less than $THRESHOLD_SERVICES%, failing the build."
  exitExecution=true
fi

if [ "$exitExecution" = true ]; then
  exit 1
fi
