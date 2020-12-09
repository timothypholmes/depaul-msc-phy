#include <stdio.h>
#include <limits.h>

void set_bits(int value, int pos, int n) {
  
  printf("Setting Bit\n");
  printf("-----------\n");

  int mask, i=0;
 
  for (i; i<=n-1; i++) {
    mask += (1 << (pos + i)); 
  }

  value = value | mask;

  printf ("The set bit is: 0x%X \n", value);
}


void reset_bits(int value, int pos, int n) {
  
  printf("Reset Bit\n");
  printf("---------\n");
  
  int mask, i=0;

  for (i; i<=n-1; i++) {
    mask += (1 << (pos + i));
  }

  mask = ~mask;
  value = value & mask;
  
  printf ("The reset bit is: 0x%X \n", value);
}


void extract_bits(int value, int pos, int n) {
  
  printf("Extract Bit\n");
  printf("-----------\n");

  int mask;
  // Left shift n - 1 range of bits
  // Right shift the value to position  
  value = (((1 << n) - 1) & (value >> (pos)));

  printf ("The extracted bit is: 0x%X \n", value);
}


void add_bits(int value) {
   printf("Add Bit\n");
   printf("-------\n");
  
   int sum=0;

   while( value ) {
      value = value & (value - 1);
      sum ++;
   }

   printf ("The added bit is: %d \n", sum);
}


/* test code; do not modify */
int main() {
  int i;
  int value = 0xA1B2C3D4;
  
  for (i = 1; i < 32; i+=8)
  	set_bits(value, i, 4);
  for (i = 31; i >= 0; i-=8)
  	reset_bits(value, i, 4);
  for (i = 0; i < 32; i+=8)
	extract_bits(value, i, 4);
  for (i = 0; i < 8; i++)
	add_bits(i);
  return 0;
}
