#! /bin/bash

STR="$(echo $1 | tr '/' '\\')"
powershell.exe start "explorer ${STR}"
