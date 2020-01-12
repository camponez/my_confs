#!/bin/bash

echo -e "Install needed packages"

sudo apt install x11proto-dev libfreetype6-dev libfontconfig1-dev \
    libx11-dev libxft-dev make build-essential libssl-dev \
    zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    curl llvm libncurses5-dev libncursesw5-dev libevent-dev bison \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git \
    libc-ares2 libcrypto++6 libmediainfo0v5 libpcrecpp0v5 libzen0v5 \
    libmms0 libtinyxml2-6a zsh i3 tmux wget

echo -e "Check if basic tools are installed...\n"

check_tools() {
    if [ ! -f "/usr/bin/$1" ]; then
        echo "$1 is not installed!"
        exit 1
    else
        echo "$1 is installed! Yay!"
    echo "Install git zsh curl tmux gcc make "
    fi
}

check_tools "git"
check_tools "zsh"
check_tools "curl"
check_tools "tmux"
check_tools "gcc"
check_tools "make"

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
if [ ! -d "${SIMPLE_TERMINAL}" ]; then
    git submodule init
    git submodule update
fi
cd "${SIMPLE_TERMINAL}"
make

mkdir -p "$HOME/bin/"
if [ -z "$USER" -o "$USER" == "root" ]; then
    cp -v "${SIMPLE_TERMINAL}/st" $HOME/bin/
else
    sudo cp -v "${SIMPLE_TERMINAL}/st" /usr/bin/
fi

if [ ! -f /usr/bin/st ]; then
    echo 'Could install Simple Terminal'
    exit 1
fi

git clone https://github.com/pyenv/pyenv.git ~/.pyenv

echo -e "Get diff-so-fancy"
wget -c -P "$HOME/bin" https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy

echo -e "Installng ack..."
curl https://beyondgrep.com/ack-2.24-single-file > ~/bin/ack && chmod 0755 ~/bin/ack

echo -e "Installing oh-my-zsh...\n"
export SHELL="zsh"
export ZSH="$HOME/.oh-my-zsh"
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

NVIM_FILES=(local_init.vim \
           local_bundles.vim \
           init.vim)

mkdir -p "$HOME/.config/nvim"
for i in ${NVIM_FILES[*]}; do
    cp -v $i "$HOME/.config/nvim/$i"
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
git clone https://github.com/starcraftman/zsh-git-prompt.git

chmod +x ~/bin/*

# TODO - How to make install not stop at ENTER
# echo -e "Install vim plugins in 3s\n"
# sleep 3
# vim +PlugInstall +qall

printf "\nConfiguring i3\n"
mkdir -p "$HOME/.i3"

cp -v "$CONF_DIR/my_confs/i3/"* "$HOME/.i3/"

echo 'Final manual step:'
echo "Still need to be installed:"
echo "Palemoon"
echo "xkeybinds"
echo "xscreensaver"
echo ''
echo 'set API key from https://home.openweathermap.org/api_keys'
