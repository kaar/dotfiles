#!/bin/sh

# Use docker on windows
alias clip='clip.exe'
alias dotnet='dotnet.exe'

# Cint
alias rasdial='/mnt/c/Windows/System32/rasdial.exe'
alias cint-connect='rasdial "NextGen VPN2Cint-test"'
alias cint-disconnect='cint-connect /DISCONNECT'

vs="/mnt/c/Program Files (x86)/Microsoft Visual Studio/2019/Professional/Common7/IDE/"
rider="/mnt/c/Program Files/JetBrains/JetBrains Rider 2021.1.2/bin/"

# WSL Specific paths
export PATH="$PATH:$vs:$rider:"

## WSL-1
if grep -qE "Microsoft" /proc/version &>/dev/null; then
  ## Add wsl specific scripts
  export PATH="$PATH:${SCRIPTS}/wsl"
  # To be able to run minikube in WSL
  export DOCKER_CERT_PATH='/mnt/c/home/.minikube/certs'
  alias docker='docker.exe'
  alias docker-compose='docker-compose.exe'
fi

## WSL-2
#if grep -qE "WSL2" /proc/version &>/dev/null; then
#
#fi
