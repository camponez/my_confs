#!/bin/bash

echo -e "Check if basic tools are installed...\n"

check_tools() {
    if [ ! -f "/usr/bin/$1" ]; then
        echo "$1 is not installed!"
        exit 1
    else
        echo "$1 is installed! Yay!"
    fi
}

check_tools "git"
check_tools "zsh"
check_tools "curl"
check_tools "tmux"
if [ -f /etc/redhat-release ]; then
    check_tools "urxvt256c"
else
    check_tools "urxvt"
fi

echo -e "\nAll good!\n"

echo -e "----------------------------\n"

CONF_DIR="$HOME/devel"

mkdir -pv "${CONF_DIR}"
cd "${CONF_DIR}"

if [ ! -d "${CONF_DIR}/my_confs" ]; then
    echo -e "Cloning my confs from github\n"
    git clone https://github.com/camponez/my_confs.git
fi

echo -e "Installing oh-my-zsh...\n"
export SHELL="zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/junegunn/fzf.git "${ZSH}/custom/plugins/fzf"
${ZSH}/custom/plugins/fzf/install --bin
git clone https://github.com/Treri/fzf-zsh.git ${ZSH}/custom/plugins/fzf-zsh

cd $CONF_DIR/my_confs

cp -v .vimperatorrc $HOME
cp -v .pentadactylrc $HOME
cp -v dircolors.colors $HOME
ln -svf $HOME/dircolors.colors $HOME/.dir_colors
cp -v .zshrc $HOME
cp -v *.zsh-theme $HOME/.oh-my-zsh/themes/
cp -v .Xmodmap $HOME/
cp -v .Xresources $HOME/
cp -v .XCompose $HOME/
cp -v .tmux.conf $HOME/
cp -v .vimrc $HOME
cp -v .vimrc.local $HOME
cp -v .vimrc.local.bundles $HOME

echo -e "Getting fonts\n"
mkdir -p $HOME/.local/share/fonts

curl -o $HOME/.local/share/fonts/Inconsolata-Regular.ttf \
    https://raw.githubusercontent.com/google/fonts/master/ofl/inconsolata/Inconsolata-Regular.ttf

if [ ! -f $HOME/.local/share/fonts/Inconsolata-Regular.ttf ]; then
    echo "Fonts not installed correctly!"
    exit 1
fi

echo "Rebuilding fonts in 3s...\n"
sleep 3

fc-cache -vf $HOME/.local/share/fonts

cd $CONF_DIR/my_confs
rm -rvf fonts

cd $CONF_DIR
echo "ZSH git prompt... \n"
git clone https://github.com/olivierverdier/zsh-git-prompt.git

# TODO - How to make install not stop at ENTER
# echo -e "Install vim plugins in 3s\n"
# sleep 3
# vim +PlugInstall +qall

echo "\nConfiguring i3\n"
mkdir -p $HOME/.i3

cp -v $CONF_DIR/my_confs/i3/* $HOME/.i3/
