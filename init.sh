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
