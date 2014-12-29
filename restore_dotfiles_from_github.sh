#!/bin/bash
# vim: fdm=syntax

# Defining Variables
prog="github"
LOG="$HOME/.logfiles"
lockfile_old="$(basename $HOME/.logfiles/*.$prog.lock)"
lockfile_glob="$(ls $LOG | egrep [[:digit:]]{8}.lock)"

gitdir=$HOME/dotfiles                                           # dotfiles directory
git_old_dir=$HOME/dotfiles_old                                  # old dotfiles backup directory
files="vimrc bash bashrc cmus devilspie dingrc gvimrc newsbeuter \
dictionaries podget sane spamassassin vim xournal muttrc mutt"  # list of files/folders to symlink in homedir
scripts="$HOME/bin/gitDotfiles"


# Storing.dotfiles
chk_if_already_exec ()
{

    # Lockfile löschen falls älter als ein tag
    if [[ -f "$LOG/$lockfile_old" ]]; then
        if [[ "$LOG/$lockfile_old" -ot "$LOG/$lockfile_glob" ]]; then
            rm -v $LOG/*.$prog.lock
        else
            # Skript beenden
            echo "Du hast das Skript bereits gestartet, $prog wird nicht ausgeführt!"
            exit 1
        fi
    else
        # Neue Lockfile anlegen
        touch "$LOG/20140425.$prog.lock"
    fi
}
github_pull_dotfiles ()
{
    # Cloning Dotfolder to $HOME/
    if [[ ! -d $gitdir ]]; then
        cd $HOME
        git clone https://github.com/emzap79/dotfiles.git
    fi
}
dotfiles_store ()
{

    for file in $files; do
        # optionally put --ling-dest for symlinks
        # rsync -rvau --delete --progress "$HOME/.$file" "$gitdir/"

        # Prepare Gitdir for fileremoval
        chmod -R 0777 $gitdir/$file

        # Copy dotfiles to directory
        rm -rv $gitdir/$file
        cp -rvau "$HOME/.$file" "$gitdir/$file"
    done

    cp -v $HOME/bin/cronGithub ./restore_dotfiles_from_github.sh
}
github_push ()
{

    # changedir to git-dotfiles-repository
    cd $gitdir

    # Clear staging-area
    git add -A .
    git commit -m "weekly update"
    git push origin master
    # git clean -df

}

# Restore.Dotfiles
reinstall_config_files ()
{
    # create dotfiles_old in homedir
    echo -n "Creating $git_old_dir for backup of any existing dotfiles in ~ ..."
    mkdir -p $git_old_dir
    echo "done"

    # change to the dotfiles directory
    echo -n "Changing to the $gitdir directory ..."
    cd $gitdir
    echo "done"

    # copy any existing dotfiles in homedir to dotfiles_old directory, then create
    # symlinks from the homedir to any files in the ~/dotfiles directory specified
    # in $files
    for file in $files;
    do

        echo "moving any existing dotfiles from ~ to $git_old_dir"
        mv -r ~/.$file $git_old_dir

        echo "Creating hardlinks from $gitdir to $file in home directory."
        cp -ravlu $gitdir/$file ~/.$file

        #echo "Creating symlink to $file in home directory."
        #ln -s $gitdir/$file ~/.$file

    done
}

# Options.Prompt
case $1 in
    weeklybackup|weekly|w)
        chk_if_already_exec
        github_pull_dotfiles
        dotfiles_store
        github_push
        ;;
    backup|bck|bkp|b)
        github_pull_dotfiles
        dotfiles_store
        ;;
    restore|res|re|r)
        reinstall_config_files
        ;;
    *)
        echo "usage: $0 ( [b]ackup | [r]estore )"
        echo "please run one of those options!"
        exit 1
        ;;
esac

exit 0
#.###########################
#.###########################
#.#.Next.Steps.are:
#.###########################
#.###########################
#git init
#git add -A
#git commit -m 'Add your comment'
#git remote add origin git@github.com:emzap79/dotfiles.git
#git push/pull origin master        # Pushing or pulling local files to or from github vice versa
