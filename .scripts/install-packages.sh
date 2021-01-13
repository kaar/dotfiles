# Install all packates in ~/.packages
sudo apt update
sudo apt upgrade
sudo apt install $(awk -f ~/.awk/skip_hash.awk ~/.packages)
