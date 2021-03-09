## Kubectl,https://kubernetes.io/docs/tasks/tools/install-kubectl/

installed=$(kubectl version --client | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/')
latest=$(curl -L -s https://dl.k8s.io/release/stable.txt | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/')
echo "Installed: v$installed"
echo "Latest: v$latest"

# Download latest release
curl -Ls --output /tmp/kubectl "https://dl.k8s.io/release/v${latest}/bin/linux/amd64/kubectl"

# Download the kubectl checksum file
# curl -Ls --output /tmp/kubectl.sha256 "https://dl.k8s.io/v${latest}/bin/linux/amd64/kubectl.sha256"

# Validate the kubectl binary against the checksum file:
# echo "$(<kubectl.sha256) kubectl" | sha256sum --check

# Install
sudo install -o root -g root -m 0755 /tmp/kubectl /usr/local/bin/kubectl

# Test to ensure the version you installed is up-to-date
kubectl version --client

rm -rf /tmp/kubectl
