import random
import sys

N=int(sys.argv[1])
loops=int(sys.argv[2])

total=0
for i in xrange(loops):
    y=[random.uniform(1,0) for x in xrange(N)]
    total=total+sum(y)

print N, loops, total

