#!/bin/csh -f

cd /home/KNUEEhdd1/elec518/tjp6/01-vcs/12-vmips

#This ENV is used to avoid overriding current script in next vcselab run 
setenv SNPS_VCSELAB_SCRIPT_NO_OVERRIDE  1

/usr/synopsys/vcs/vcs_vR/R-2020.12-SP1/linux64/bin/vcselab $* \
    -o \
    simv \
    -nobanner \

cd -

