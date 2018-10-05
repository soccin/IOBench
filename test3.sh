#!/bin/bash

bams=$*

echo "====================================================="
echo "START"
date
w
echo "----------"

for bam in $bams; do
    base=$(basename $bam)
    mkdir -p out/$$/$base
    ./picardV2.local SortSam SO=queryname I=$bam O=out/$$/$base/${base}.bam &
done
wait
echo "====================================================="
w
date
echo "DONE"
