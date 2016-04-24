#!/bin/bash

set -ex

# http://serverfault.com/questions/160581/how-to-setup-passwordless-sudo-on-linux
# http://stackoverflow.com/questions/323957/how-do-i-edit-etc-sudoers-from-a-script

if [ -z "$1" ]; then
    export EDITOR=$0 && visudo
else
    echo "ALL ALL=(ALL) NOPASSWD: ALL" >> $1
fi
