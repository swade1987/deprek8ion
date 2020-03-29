#!/usr/bin/env bash

set -uo errexit

CONFTEST=0.18.0
printf "\ndownloading conftest ${CONFTEST}\n"
curl -sSL https://github.com/instrumenta/conftest/releases/download/v${CONFTEST}/conftest_${CONFTEST}_Linux_x86_64.tar.gz | \
tar xz && mv conftest /usr/local/bin/conftest
conftest --version