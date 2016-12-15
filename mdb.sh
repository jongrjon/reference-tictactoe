#!/bin/bash
set -e

sleep 10
npm run migratedbprod
node run.js

exit 0