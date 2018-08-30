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

#TODO remove check of urxvt if all goes well with Simple Terminal
if [ -f /etc/redhat-release ]; then
    check_tools "urxvt256c-ml"
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
    cd my_confs
    git submodule init
    git submodule update
fi

SIMPLE_TERMINAL="${CONF_DIR}/my_confs/simple-terminal"

echo -e "Building simple-teminal"
cd "${SIMPLE_TERMINAL}"
make

mkdir -p "$HOME/bin/"
if [ -z "$USER" -o "$USER" == "root" ]; then
    cp -v "${SIMPLE_TERMINAL}/st" /usr/bin/
else
    sudo cp -v "${SIMPLE_TERMINAL}/st" /usr/bin/
fi

if [ ! -f /usr/bin/st ]; then
    echo 'Could install Simple Terminal'
    exit 1
fi

echo -e "Get diff-so-fancy"
wget -P "$HOME/bin" https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy

echo -e "Installing oh-my-zsh...\n"
export SHELL="zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/junegunn/fzf.git "${ZSH}/custom/plugins/fzf"

"${ZSH}/custom/plugins/fzf/install" --bin
git clone https://github.com/Treri/fzf-zsh.git "${ZSH}/custom/plugins/fzf-zsh"
git clone https://github.com/zdharma/fast-syntax-highlighting.git "${ZSH}/custom/plugins/fast-syntax-highlighting"

cd "$CONF_DIR/my_confs"

cp -v ./*.zsh-theme "$HOME/.oh-my-zsh/themes/"

DOT_FILES=(Xmodmap \
    Xresources \
    XCompose \
    tmux.conf \
    vimperatorrc \
    pentadactylrc \
    zshrc \
    gitconfig \
    vimrc \
    vimrc.local \
    vimrc.local.bundles)

for i in ${DOT_FILES[*]}; do
    cp -v $i "$HOME/.$i"
done

cp -v dircolors.colors "$HOME"
ln -svf "$HOME/dircolors.colors" "$HOME/.dir_colors"

echo -e "Getting fonts\n"
mkdir -p "$HOME/.local/share/fonts"
POWERLINE_FONT="Meslo LG L DZ Regular for Powerline.otf"
POWERLINE_FONT_PATH="$HOME/.local/share/fonts/"
cp -v "${POWERLINE_FONT}" "${POWERLINE_FONT_PATH}"

printf "Rebuilding fonts in 3s...\n"
sleep 3

fc-cache -vf "$HOME/.local/share/fonts"

cd "$CONF_DIR/my_confs"
rm -rvf fonts

cd "$CONF_DIR"
printf "ZSH git prompt... \n"
git clone https://github.com/olivierverdier/zsh-git-prompt.git

# TODO - How to make install not stop at ENTER
# echo -e "Install vim plugins in 3s\n"
# sleep 3
# vim +PlugInstall +qall

printf "\nConfiguring i3\n"
mkdir -p "$HOME/.i3"

cp -v "$CONF_DIR/my_confs/i3/"* "$HOME/.i3/"
