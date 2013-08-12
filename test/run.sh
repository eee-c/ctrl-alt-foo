#!/bin/bash

# Static type analysis
results=$(dartanalyzer test/test.dart 2>&1)
echo "$results"
if [[ "$results" == *"warnings found"* || "$results" == *"error"* ]]
then
  exit 1
fi

results=$(content_shell --dump-render-tree test/index.html 2>&1)
echo -e "$results"

if [[ "$results" == *"Some tests failed"* ]]
then
  exit 1
fi
