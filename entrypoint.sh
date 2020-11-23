#!/bin/sh
set -e

echo "**********************fetch:"
git fetch origin main

echo "********************git branch:"
git branch


echo "*******************git log:"
git log


echo "*******************git checkout main:"
git checkout main

echo "*******************git log:"
git log


CHANGED_FILES=$(git diff --name-only --diff-filter=AM main...my-test)
CHANGED_FILES_PHP=$(find ${CHANGED_FILES} -type f -regex "^.*\(\.php\|\.phtml\)$")

PHP_FULL_VERSION=$(php -r 'echo phpversion();')	
echo "## Running PHP Syntax Checker (lint) on ${DIR_TO_SCAN}"	
echo "PHP Version : ${PHP_FULL_VERSION}"	


ERROR=0	
for file in ${CHANGED_FILES_PHP}; do	
  RESULTS=$(php -l ${file} || true)	
  if ! php -d error_reporting="E_ALL & ~E_DEPRECATED" -l "$file"; then
    echo "\n${RESULTS}\n"	
    ERROR=101
  fi
done	







exit "${ERROR}"
