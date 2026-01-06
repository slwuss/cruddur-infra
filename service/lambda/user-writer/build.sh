#!/bin/bash
set -e

rm -rf package user-writer.zip
mkdir package

pip install -r requirements.txt -t package/
cp handler.py package/

cd package
zip -r ../user-writer.zip .