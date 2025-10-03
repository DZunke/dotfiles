# 🍕 To be written ... but note:

Setup:
```
source bootstrap.sh  --force
```


SSH Connections not possible in VPN
```
# lower the networking mtu if it leads into timeouts
ip link set mtu 1100 eth0
```

SSH Config Permissions
```
.ssh directory: 700 (drwx------)
public key (.pub file): 644 (-rw-r--r--)
private key (id_rsa): 600 (-rw-------)
```

Install GPG-Keys:
```
gpg --import PATH_TO_GPG_FILE;
gpg --edit-key {KEYID_FROM_IMPORT} trust quit; # Select first 5 and then Y in Dialog
gpg --list-secret-keys --keyid-format LONG; # Check key has state "ultimate" instead of "unknown"
```

Git Configuration
```
git config --global user.name "Denis Zunke"
git config --global user.email denis.zunke@gmail.com


git config --global user.signingkey KEY_ID_FROM_GPG_LIST
git config --global commit.gpgsign true
git config --global tag.forceSignAnnotated true
```

Manually write the windows hosts file to wsl hosts file
```
cat /mnt/c/Windows/System32/drivers/etc/hosts | grep 192.* | sudo tee -a /etc/hosts
```

Globales Git Ignore
```bash
nano ~/.gitignore_global
# Einträge eintragen

git config --global core.excludesfile ~/.gitignore_global
```

```
git config --global credential.helper 'cache --timeout=3600'
```


## Updated Setup - 2025

```bash
# Disable sudo password prompt
sudo -i bash -c "echo \"$USER ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers"

# Install Basics and Updates
sudo apt upgrade
sudo apt install make htop unzip

# Install PHP
sudo add-apt-repository ppa:ondrej/php
export PHP_VERSION=8.4
sudo apt install php${PHP_VERSION}-cli php${PHP_VERSION}-intl php${PHP_VERSION}-bcmath php${PHP_VERSION}-curl php${PHP_VERSION}-zip php${PHP_VERSION}-mbstring php${PHP_VERSION}-gd php${PHP_VERSION}-xml php${PHP_VERSION}-amqp

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/bin/composer
sudo chmod +x /usr/bin/composer

# Install Docker
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
newgrp docker
rm get-docker.sh
docker --version

# Chrome, for Jetbrains IDEA Activation
cd ~
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install
google-chrome --ozone-platform=wayland

# Jetbrains
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash

# Copy Application Files of JetBrains & PHPStorm
sudo ln -s ~/.local/share/applications/jetbrains-toolbox.desktop /usr/share/applications/jetbrains-toolbox.desktop
sudo ln -s ~/.local/share/applications/jetbrains-phpstorm-f2485a63-7ade-499c-afc6-566ed0b6f576.desktop /usr/share/applications/jetbrains-phpstorm.desktop

# Setup NVM, needed to run local mcp servers utilizing npx
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
reload
nvm install --lts
nvm use --lts
```

## Setup Minimal MCP Server

With VS Code running in WSL open `> MCP: Open Remote User Configuration`. When NVM installation and MCP configuration were in the same session it is needed to restart the WSL and Visual Studio because otherwise there will be errors with not finding `npx`, so Visual Studio must be forced to reload it's own internal shell session.

```json
{
  "servers": {
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "@playwright/mcp@latest",
        "--ignore-https-errors"
      ]
    },
    "context7": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@upstash/context7-mcp"
      ]
    },
    "git-mcp-server": {
      "command": "npx",
      "args": [
        "@cyanheads/git-mcp-server"
      ],
      "env": {
        "MCP_LOG_LEVEL": "info",
        "GIT_SIGN_COMMITS": "true"
      }
    }
  }
}
```
