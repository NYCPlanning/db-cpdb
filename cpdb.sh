#!/bin/bash
source bash/config.sh

case $1 in 
    dataloading ) ./bash/01_dataloading.sh ;;
    attribute ) ./bash/02_build_attribute.sh ;;
    adminbounds ) ./bash/03_adminbounds.sh ;;
    analysis ) ./bash/04_analysis.sh ;;
esac