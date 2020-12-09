make
./csim -s 1 -E 2 -b 1 -p lru -t traces/yi2.trace
./csim -s 4 -E 2 -b 4 -p lru -t traces/yi.trace
./csim -s 2 -E 4 -b 1 -p lru -t traces/dave.trace
./csim -s 5 -E 4 -b 5 -p lru -t traces/long.trace
