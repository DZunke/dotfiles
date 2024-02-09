# Running PHPStorm / JetBrains with native WSLg implementation

The WSL does support graphical user interfaces with the WSLg directly without the need of an extra XServer installed. And
as the environment has a lot more tools there is maybe the need to utilize them. The following description shows how to
install the JetBrains Toolbox and how to utilize it directly within the WSL.

## Setup JetBrains Toolbox within WSL

```bash
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.2.1.19765.tar.gz

sudo apt install libcups2 libpangocairo-1.0-0 libatk-adaptor libxss1 libnss3 libxcb-keysyms1 x11-apps libgbm1 libxdamage1 libxkbcommon
sudo apt install libgtk-3-dev libfuse2 libxi6 libxrender1 libxtst6 mesa-utils libfontconfig libgtk-3-bin

tar -xvzf jetbrains-toolbox-2.2.1.19765.tar.gz
mv jetbrains-toolbox-2.2.1.19765 jetbrains

# Should now be executable
$ jetbrains/jetbrains-toolbox
```

To activate JetBrains licenses it is required to be logged in. The Toolbox can't really open a new browser fenster to
do the login, even there is a default browser installed in the WSL. So there is the need to click on the "troubleshoot"
button below the login button. This opens up an input box and gives a link where one can request the auth token for
themself. C&P the code to the textbox after manually getting it with the given link and the login is accomplished,

The setup of JetBrains tools should then work with the toolbox.

I also created btw. changed the PHPStorm alias in `~/.aliases`.

```bash
alias phpstorm="/home/dzunke/.local/share/JetBrains/Toolbox/apps/phpstorm/bin/phpstorm.sh > /dev/null 2>&1"
```

## Troubleshoot

### Markdown preview is empty

If the Markdown preview functionality within an installed JetBrains IDE is not working there is a specific package
missing. After it is installed the IDE should be restarted and then the preview should show the rendered markdown.

```bash
$ sudo apt-get install openjfx
```
