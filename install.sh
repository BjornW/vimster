#!/usr/bin/env sh

# Vimster install script based upon spf13 bootstrap.sh
# https://github.com/spf13/spf13-vim

installpath="$HOME/.vimster"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

# if the file does not exist create a symbolic link, 
# otherwise if $2 is a symbolic file link force a symbolic link
create_symlink() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
    if [ -L $2 ] ; then
        ln -sf $1 $2
    fi
}

echo "Ready to install Vimster, just sit back and relax."

# Backup existing .vim stuff
echo "Backing up current vim config"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done


if [ ! -e $installpath/.git ]; then
    echo "Cloning vimster from Github"
    git clone --recursive -b master https://github.com/BjornW/vimster.git $installpath
else
    echo "Updating vimster"
    cd $installpath && git pull
fi


echo "Setting up symlinks"
create_symlink $installpath/.vimrc $HOME/.vimrc
create_symlink $installpath/.vimrc.bundles $HOME/.vimrc.bundles
create_symlink $installpath/.vim $HOME/.vim

# Create a directory for Vundle if it doesn't exist yet 
# Vundle is short for Vim bundle and is a Vim plugin manager.
if [ ! -d $installpath/.vim/bundle ]; then
    mkdir -p $installpath/.vim/bundle
fi

# Create a directory for use with Vim 7.3. persistent undo
# this prevents Vim from placing .filename.un~ all over the place
# and uses the set undodir in .vimrc to keep this all in ~/.vim/persistent-undo
if [ ! -d $installpath/.vim/persistent-undo ]; then
    mkdir -p $installpath/.vim/persistent-undo
fi    

if [ ! -e $HOME/.vim/bundle/vundle ]; then
    echo "Installing Vundle"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "Update/install plugins using Vundle"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $installpath/.vimrc.bundles +BundleInstall! +BundleClean +qall
export SHELL=$system_shell
