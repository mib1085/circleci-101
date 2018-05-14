#!/bin/sh
#
CIRCLE_COMPARE_URL="https://github.com/mib1085/circleci-101/compare/fcb8cde83ec5...09e9bcf7ae77"
git diff ${CIRCLE_COMPARE_URL##*/} | while read LN; do
  echo $LN
done
