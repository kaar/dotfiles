# To be able to run minikube in WSL
export DOCKER_CERT_PATH='/mnt/c/home/.minikube/certs'

# Use docker on windows
alias docker='docker.exe'
alias docker-compose='docker-compose.exe'
alias clip='clip.exe'
alias dotnet='dotnet.exe'

# Cint
alias rasdial='/mnt/c/Windows/System32/rasdial.exe'
alias cint-connect='rasdial "NextGen VPN2Cint-test"'
alias cint-disconnect='cint-connect /DISCONNECT'

