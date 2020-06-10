#!/bin/bash

chmod +x script/sh/bootstrap.sh
echo "- invoking script/sh/bootstrap.sh [$@]"
/bin/bash -c 'script/sh/bootstrap.sh' /bin/bash "$@"
source ~/.bashrc