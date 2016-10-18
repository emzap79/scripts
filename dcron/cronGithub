#!/bin/bash
# vim: fdm=syntax

# Defining Variables
prog="github"
LOGDIR="$HOME/.logfiles"

gitdir="$HOME/dotfiles"                                           # dotfiles directory
git_old_dir="$HOME/dotfiles_old"                                  # old dotfiles backup directory
folders="w3m bash cmus devilspie newsbeuter \
dictionaries podget sane vim vimperator xournal mutt"  # list of files/folders to symlink in homedir
files="gitconfig inputrc Rprofile tmux.conf vimrc vimperatorrc bashrc dingrc gvimrc muttrc"
scripts="$HOME/bin/gitDotfiles"


# Storing.dotfiles
chk_if_already_exec ()
{

    if [ -f "$LOGDIR/`date +%Y-%W`-$prog.lock" ]; then
        # Skript beenden
        echo "You've already run this script this week!"
        echo "CU next time buddy!"
        exit 1
    else
        rm "$LOGDIR/*$prog.lock"; touch "$LOGDIR/`date +%Y-%W`-$prog.lock"
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

    while read target
    do
        if
            # folders
            test -d "$HOME/.$target"
        then
            # # Prepare Gitdir for folderremoval
            if [[ ! -e $gitdir/$target ]]; then
                mkdir -p $gitdir/$target
            fi
            # # Copy dotfolders to directory
            rsync -rvau --delete --delete-excluded --exclude-from "$gitdir/.gitignore" "$HOME/.$target/" "$gitdir/$target/"
        elif
            #files
            test -f "$HOME/.$target"
        then
            # # Copy dotfiles to directory
            cp -auv "$HOME/.$target" "$gitdir/$target"
        fi
    done < <(printf "%s\n" $folders $files)

    # copy github script to dotfiles
    cp -v "$0" $gitdir/save_and_restore_dotfiles_from_github.sh

}
commit_changes() {

    # stage changes in dotfiles
    echo ""
    cd "$gitdir" && git add -A .
    read -p "git commit -m " message
    git commit -m "$message"

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
    echo "moving any existing dotfiles from ~ to $git_old_dir"
    echo "and creating hardlinks from $gitdir to folder in home directory..."

    for file in $files;
    do
        mv -v ~/.$file $git_old_dir
        cp -avlu $gitdir/$file ~/.$file
    done
    for folder in $folders;
    do
        mv -v ~/.$file $git_old_dir
        cp -ravlu $gitdir/$folder ~/.$folder
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
        commit_changes
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
