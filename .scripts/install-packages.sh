# Install all packates in ~/.packages
sudo apt-get install $(awk -f ~/.awk/skip_hash.awk ~/.packages)
