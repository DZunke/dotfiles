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

# Install PHP
sudo add-apt-repository ppa:ondrej/php
export PHP_VERSION=8.4
sudo apt install php${PHP_VERSION}-cli php${PHP_VERSION}-intl php${PHP_VERSION}-bcmath php${PHP_VERSION}-curl php${PHP_VERSION}-zip php${PHP_VERSION}-mbstring php${PHP_VERSION}-gd php${PHP_VERSION}-xml

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/bin/composer
sudo chmod +x /usr/bin/composer

# Chrome, for Jetbrains IDEA Activation
cd ~
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install
google-chrome --ozone-platform=wayland

# Jetbrains
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash
```
