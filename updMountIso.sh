#!/bin/bash

/bin/mkdir -p $HOME/mnt
echo "#!/bin/bash
# (c) 2006 by Julian Fleischer aka Warhog
# License: GPLv2 (See http://www.gnu.org/licenses/gpl.html)
# visit http://www.warhog.info/

mountiso_version="2006-10-18"
mountiso_cfg_file="/etc/mountiso.default"
mountiso_default_mountpoint="$HOME/mnt"

do_mount()
{
    if [ ! -e "$1" ]; then
        echo "Image file not found, aborting."
    else
        if [ "$2" == "ro" ]; then
            param="-r "
        fi
        mount $param -o loop -t iso9660 "$1" "$where"
    fi
}

show_help()
{
    echo "mountiso [-w] <what> [<where>]"
    echo " mounts an iso9660-image <what> to mountpoint <where>."
    echo "If no mountpoint is specified, $default_mountpoint will be assumed."
    echo "If no arguments are given, all mounted iso9660 images will be listed."
    echo " Options:"
    echo "  -w, --writable  boot the image writable, default is readonly"
    echo " Alternatives:"
    echo "  -u <where>      unmounts the image at <where>"
    echo "  -d, --default   print the default mount point"
    echo "  -d <where>      set the default mount point to <where>"
    echo "  -c, --clean     remove the configuration-file -> if there is any"
    echo "  -v, --version   print version information"
    echo "  -h, --help      show this message"
}

read_config()
{
    default_mountpoint=$mountiso_default_mountpoint
    if [ -e "$mountiso_cfg_file" ]; then
        default_mountpoint="`cat $mountiso_cfg_file`"
    fi

    where="$1"
    if [ ! -e "$where" ]; then
        where="$default_mountpoint"
    fi
}

save_config()
{
    echo "$1" > "$mountiso_cfg_file"
}

do_execute()
{
    read_config "$2"

    case $1 in
        "")
            mount | grep iso9660
            ;;

        "--help"|"-h")
            show_help
            ;;

        "-v"|"--version")
            echo $mountiso_version
            ;;

        "-d"|"--default")
            if [ "$2" == "" ]; then
                echo $default_mountpoint
            else
                default_mountpoint="$2";
                save_config "$default_mountpoint"
            fi
            ;;

        "-u"|"--umount"|"--unmount")
            umount "$where"
            ;;

        "-c"|"--clean")
            unlink "$mountiso_cfg_file"
            ;;

        "-w"|"--writable"|"--writeable")
            read_config "$3"
            do_mount "$2" rw
            ;;

        *)
            do_mount "$1" ro
            ;;
    esac
}

do_execute "$1" "$2" "$3"" | sudo tee /usr/bin/mountiso
gksudo chmod 755 /usr/bin/mountiso
exit 0
