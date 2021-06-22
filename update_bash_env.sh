#!/bin/bash

ldir=`pwd`
cd /opt/scripts/kasenv
git checkout *
git fetch
git pull
cd $ldir
source ~/.bashrc

