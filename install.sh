#!/bin/env bash

mkdir -p $HOME/bin
cp ./dotts.sh $HOME/bin/
chmod u+x $HOME/bin/dotts.sh
ln -s $HOME/bin/dotts.sh $HOME/bin/dotts

git init --bare $HOME/.dotts

mkdir -p .dotts-backup
dotts checkout  -b master
if [ $? = 0 ]; then
  echo "Checked out dotts.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
dotts checkout -b master
dotts config status.showUntrackedFiles no

echo '.dotts' > $HOME/.gitignore
    
dotts add  $HOME/.gitignore
dotts commit -m 'initial commit'


