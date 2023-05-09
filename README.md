# ssh-agent-loader
Script to load the ssh-agent when the terminal starts. Usefull for WSL or if you have multiple SSH Keys.

# How to use it:
Run the next command:

``
wget https://raw.githubusercontent.com/osaizar/ssh-agent-loader/master/ssh-agent-loader.sh && mv ssh-agent-loader.sh ~/.ssh-agent-loader.sh && chmod +x ~/.ssh-agent-loader.sh
``

Add the next line to your .bashrc or .zshrc:

``
source ~/.ssh-agent-loader.sh
``
