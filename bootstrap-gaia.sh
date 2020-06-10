#!/bin/bash

chmod +x script/sh/bootstrap.sh
echo "- [$@]"
/bin/bash -c "script/sh/bootstrap.sh $@"
source ~/.bashrc