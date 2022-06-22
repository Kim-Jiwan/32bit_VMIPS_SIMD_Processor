#!/bin/csh

set options = "-full64 -gui -Mupdate -timescale=1ns/1ps"

vcs $options -f filelist | tee logfile

./simv

