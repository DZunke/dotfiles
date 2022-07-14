# Running PHPStorm Inside Windows WSL2 Environment

VS Code can run natively on a WSL2 environment. PHPStorm currently cannot. To archive a perfomance boost with PHPStorm one could setup WSL2 to use a XServer, running on Windows, to start on the native WSL2 filesystem instead of working on the shared filesystem, which is, even on WSL2, a slow one. 

## Windows Preparations (With Windows Admin Permissions)

* [Setup Windows to use WSL2 environment](https://docs.microsoft.com/en-us/windows/wsl/wsl2-install)
* [Install XServer](https://sourceforge.net/projects/vcxsrv/)
* Configure `vcxsrv.exe` like documented below
* Use [`config.xlaunch`](./config.xlaunch) to start XServer, the config extension should be automatically linked to XServer
  * The `config.xlaunch` could be added to windows autostart if needed

## Windows Preparations (Without Windows Admin Permissions)

* [Setup Windows to use WSL2 environment](https://docs.microsoft.com/en-us/windows/wsl/wsl2-install)
* Download [XServer](https://sourceforge.net/projects/vcxsrv/) setup file without exeuting it
* Extract dowloaded XServer setup file with, for example, [7Zip](https://7-zip.de/download.html) 
* Remove `$PLUGINSDIR` from extracted folder
* Configure `vcxsrv.exe` like documented below
* Create a shortcut for starting XServer (could also be added to autostart)
  * `C:\YOUR_XSERVER_PORTABLE_PATH\vcxsrv.exe :0 -multiwindow -clipboard -wgl -ac`
* Start the XServer Shortcut
* Install [Git Bash](https://gitforwindows.org/)
* Configure Git Bash to use your private key (if password protected setup a key agent)

## Configure XServer

At the folder `%PROGRAMFILES%\VcXsrv` (Admin Setup) or `C:\YOUR_XSERVER_PORTABLE_PATH\vcxsrv.exe` (Non-Admin-Setup)

* Right click on `vcxsrv.exe`
* Properties > Compatibility > Change high DPI settings
* Check _Override high DPI scaling behavior_
* Select _Application_
* Apply Settings

## WSL2 Preparation (With Windows Admin Permissions)

Add the following line to `~/.bashrc` or `~/.profile` for letting the bash know which display server to use. 

```sh
export DISPLAY=${DISPLAY:-$(grep -Po '(?<=nameserver ).*' /etc/resolv.conf):0}
```

## WSL2 Preparation (Without Windows Admin Permissions)

* Setup SSH Server if not installed yet (Mostly there)
* Change the `/etc/ssh/sshd_config` to use port 2222 instead of port 22
* Execute `sudo ssh-keygen -A` to ensure the ssh server is runnable
* Install your public key at `~/.ssh/authorized_keys` to enable password less login to WSL2 ssh server
* Start the ssh server `sudo service ssh start`

## WSL2 Setup PHPStorm

Some packages need to be installed at the wsl2 environment to enable phpstorm running

```bash
sudo apt update
sudo apt install libcups2 libpangocairo-1.0-0 libatk-adaptor libxss1 libnss3 libxcb-keysyms1 x11-apps libgbm1 libxdamage1 libxkbcommon0
```

Download the [`tar.gz` file for Linux](https://www.jetbrains.com/idea/download/#section=linux) and extract to `/opt/intellij/`

```bash
wget DOWNLOAD_PATH
tar -xzvf DOWNLOADED_FILE -C /opt/intellij/
```

## Start PHPStorm

To test the setup try the following:

* With Admin-Setup
  * Execute `/opt/intellij/bin/phpstorm.sh` at a wsl2 shell
* Without Admin-Setup
  * Execute `DISPLAY=127.0.0.1:0 ssh -p2222 -C -Y YOUR_USER@127.0.0.1` at git bash
  * A SSH connection should be established
  * Execute `/opt/intellij/bin/phpstorm.sh` at the opened ssh session

All should be fine and you should see phpstorm starting at your windows environment 👍

Windows shortcut for executing PHPStorm without Admin-Setup: 

`"C:\Program Files\Git\git-bash.exe" -c "DISPLAY=127.0.0.1:0 ssh -p2222 -Y -C -f YOUR_USER@127.0.0.1 'bash -l -c /opt/intellij/bin/phpstorm.sh >/dev/null 2>&1'"`

## Setup Service Autostart at WSL2 Environment

Create `~/init-wsl.sh` and make it executable

```sh
#!/bin/sh
echo booting
sudo service ssh start
sudo service docker start

// Add Services you need our other stuff that should be run automatically on system startup
```

Add a task scheduler job which should be exeuted on windows startup

`wsl -u root /home/YOUR_USER/init-wsl.sh`
