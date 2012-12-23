#!/bin/bash

n=$(grep '%%Pages' recipes.ps|awk '{print $2}');
pp=$(for ((i=1;$i<=$n;i++)); do echo $i,$i; done)
pp=$(echo $pp |  tr ' ' ',')
psselect -p$pp recipes.ps bookpages.ps
