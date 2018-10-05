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
    python2.7 testCPU.py 1000 500000 &
done
wait
echo "====================================================="
w
date
echo "DONE"
