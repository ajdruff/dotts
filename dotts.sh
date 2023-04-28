#!/bin/env bash


: ${1?"Usage:  dotts.sh [install|uninstall]"}

action=$1;



[[ ! -v APP_NAME ]] && APP_NAME=dotts
COMMAND=$HOME/bin/${APP_NAME}


installDotts(){
mkdir -p $HOME/bin
rm $HOME/bin/dotts.sh ${COMMAND}  >/dev/null 2>&1
cat << 'EOF' > $HOME/bin/dotts.sh
#!/bin/env bash
/usr/bin/git --git-dir=$HOME/.dotts/ --work-tree=$HOME "$@"
EOF

chmod u+x $HOME/bin/dotts.sh
ln -s $HOME/bin/dotts.sh ${COMMAND}

git init --bare $HOME/.dotts
git config init.defaultBranch main
${COMMAND} checkout  >/dev/null 2>&1

${COMMAND} config status.showUntrackedFiles no
echo '.dotts' > $HOME/.gitignore
${COMMAND} add  $HOME/.gitignore
${COMMAND} commit -m 'initial commit'
echo "installed dotts"
}

uninstallDotts(){
 rm $HOME/bin/dotts.sh  ${COMMAND} >/dev/null 2>&1
if [[ $? == 0 ]]; then 
echo 'uninstalled dotts' 
else
echo 'no installation of dotts exists'
fi
}


[[ $action == "uninstall" ]] && uninstallDotts
[[ $action == "install" ]] && installDotts

