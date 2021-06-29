# WSL2 with PHPStorm over XServer

VSCode could be run natively on a WSL2 Environment. PHPStorm cannot. So this is the setup to start PHPStorm from WSL2 in
a XServer Environment on Windows Desktop-

## WSL2 and Docker Setup

The instructions could be found at the MS Page for WSL2 - it could be needed to setup the linux kernel.

[Microsoft Installation Guide for WSL2](https://docs.microsoft.com/en-us/windows/wsl/wsl2-install).

```
wsl --set-version <distro> <version>
```

[Docker Desktop WSL 2 backend](https://docs.docker.com/docker-for-windows/wsl/)

## Setup XServer

**Setup on Windows**

- [Install XServer](https://chocolatey.org/packages/vcxsrv)

- In the folder `%PROGRAMFILES%\VcXsrv`:
	- right click on `vcxsrv.exe`
	- Properties > Compatibility > Change high DPI settings
	- Check _Override high DPI scaling behavior_
	- Select _Application_

* Use [`config.xlaunch`](./config.xlaunch) to start XServer it inherits following settings:

	- Multiple Windows
	- Display number = 0
	- Start no client
	- Disable access control

**Setup on WSL**

Soem packages are needed for phpstorm

```bash
sudo apt install libcups2 libpangocairo-1.0-0 libatk-adaptor libxss1 libnss3 libxcb-keysyms1 x11-apps libgbm1
```

This should be in `.bashrc` or `.profile`

```sh
export DISPLAY=${DISPLAY:-$(grep -Po '(?<=nameserver ).*' /etc/resolv.conf):0}
```

## Start Application

* On Windows: run _XLaunch_
* On WSL: run the command to start your GUI application.

## Install PHPStorm

### On WSL2

* Download the [`tar.gz` file for Linux](https://www.jetbrains.com/idea/download/#section=linux) and extract to `/opt/intellij/`
* Run `/opt/intellij/bin/phpstorm.sh`
