#!/bin/bash

bams=$*

echo "====================================================="
echo "START"
date
w
echo "----------"

for bam in $bams; do
    base=$(basename $bam)
    #mkdir -p out/$base
    Rscript --no-save testCPU.R 1000 1 &
done
wait
echo "====================================================="
w
date
echo "DONE"
