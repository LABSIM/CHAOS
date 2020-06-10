#!/bin/bash

chmod +x script/sh/bootstrap.sh
/bin/bash -c "script/sh/bootstrap.sh $@"
source ~/.bashrc