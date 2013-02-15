# vim
mv ~/.vim ~/.vim_backup
mv ~/.vimrc ~/.vimrc_backup
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.vim ~/.vim

# pentadactyl
mv ~/.pentadactyl ~/.pentadactyl_backup
mv ~/.pentadactylrc ~/.pentadactylrc_backup
ln -s $(pwd)/.pentadactyl ~/.pentadactyl
ln -s $(pwd)/.pentadactylrc ~/.pentadactylrc

# awesome WM
mv ~/.config/awesome ~/.config/awesome_backup
ln -s $(pwd)/.config/awesome ~/.config/awesome

# oh my zsh
sudo apt-get install zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

