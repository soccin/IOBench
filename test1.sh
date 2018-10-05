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
    ./picardV2.local ValidateSamFile I=$bam &
done
wait
echo "====================================================="
w
date
echo "DONE"
