# set PATH so it includes user's private bin if it exists
if [ -d "$USR/local/bin" ] ; then
    PATH="$USR/local/bin:$PATH"
fi
