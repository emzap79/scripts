#!/bin/sh
# Magic Sysrq aktivieren um sicheren                                                    {{{2
# Systemneustart zu ermöglichen über Alt+Druck ~ REISUB
# if [ $(cat "/proc/sys/kernel/sysrq") = 0 ]; then
# if [ `crontab -l | wc -l` = 0 ]; then
if [ `cat /proc/sys/kernel/sysrq` = 0 ]; then
    echo bla
    # echo 1 | sudo tee /proc/sys/kernel/sysrq # enable interpreting magic sysrq
fi
