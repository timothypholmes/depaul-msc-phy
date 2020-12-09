#include <stdio.h>
#include <stdlib.h>

// Problem 1
long decode2 (long x, long y, long z) {
  // x - %rdi  y - %rsi  z - rdx
  long t;
  x -= z;
  y *= x;
  t = x;
  t <<= 63;
  t >>= 63;
  t ^= y;
  t += z;
  return t; 
}

// Problem 2
long loop(long x, int n) {
  // x - %rdi  n - %esi
  long t = 0;
  long mask;
  for (mask = 1; mask != x; mask = mask <<= n) {
    t |= (x & mask);
  }
  return t; 
}
