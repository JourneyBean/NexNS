#!/bin/bash
# Add nexns system user

if id nexns > /dev/null 2>&1; then
  echo "nexns user already exists"
else
  adduser --system --no-create-home --group nexns --shell=/bin/false
fi
