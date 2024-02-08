# 🍕 To be written ... but note:

Setup:
```
source bootstrap.sh  --force
```

Setup PHP
```
sudo add-apt-repository ppa:ondrej/php

sudo apt install php8.3-cli php8.3-intl php8.3-bcmath php8.3-curl php8.3-zip
sudo apt install php8.3-mbstring php8.3-bcmath php8.3-gd php8.3-xml php8.3-zip

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/bin/composer
sudo chmod +x /usr/bin/composer
```

Extend Sudoers File to not require password in daily work
```
sudo -i bash -c 'echo "WSL_USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'
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

Install Chromium
```
sudo add-apt-repository ppa:canonical-chromium-builds/stage
sudo apt-get install chromium-browser
sudo apt-get install software-properties-common
apt --fix-broken install
sudo apt-get install software-properties-common
sudo apt-get install chromium-browser
apt autoremove
apt autoclean
sudo apt-get -y install dbus-x11 xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic xfonts-scalable
```

Manually write the windows hosts file to wsl hosts file
```
cat /mnt/c/Windows/System32/drivers/etc/hosts | grep 192.* | sudo tee -a /etc/hosts
```

Globales Git Ignore
```
nano ~/.gitignore_global
# Einträge eintragen

git config --global core.excludesfile ~/.gitignore_global
```

```
git config --global credential.helper 'cache --timeout=3600'
```
