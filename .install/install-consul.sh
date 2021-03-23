## Consul, https://www.consul.io/

if [ -z "$(which consul)" ]; then
  # Download latest release
  curl -Ls "https://releases.hashicorp.com/consul/1.9.4/consul_1.9.4_linux_amd64.zip" \
    --output /tmp/consul.zip

  unzip /tmp/consul.zip -d ~/.local/bin/

  rm -rf /tmp/consul.zip
  echo "Consul v$(consul --version | grep -Po "(\d+\.)+\d+") installed."
else
  echo "Consul v$(consul --version | grep -Po "(\d+\.)+\d+") already installed."
fi
