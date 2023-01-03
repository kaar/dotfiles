#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# https://www.rust-lang.org/tools/install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
