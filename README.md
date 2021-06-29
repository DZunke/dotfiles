# 🍕 To be written ... but note:

Setup:
```
source bootstrap.sh  --force
```

Setup clean wsl:
```
sudo add-apt-repository ppa:ondrej/php

sudo apt-get install -y php7.3-cli php7.3-zip php7.3-pgsql php7.3-mysql php7.3-xml php7.3-tidy php7.3-mbstring php7.3-xdebug php7.3-intl php7.3-curl php7.3-gd php7.3-bcmath
sudo apt-get install -y vim
sudo apt-get install -y build-essential

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn gcc g++ make

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/bin/composer
sudo chmod +x /usr/bin/composer
```

sudo without passwort for offline systems:
```
sudo -i bash -c 'echo "de_zunke ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'
```

Grub Timeout-Fix after upgrading vagrant bento/ubtunu
```
# Edit /etc/defaults/grub
GRUB_RECORDFAIL_TIMEOUT=0

sudo update-grub
```

SSH Config Pewrmissions after Uploading Keysets
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


// Only for old tools with old ssh clients that could not be updates :/
Update SSH-Configs with very old ciphers. DANGER! Only in not reachable systems:
```
KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1
Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com,chacha20-poly1305@openssh.com,3des-cbc
```

Install Headless Chrome
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
