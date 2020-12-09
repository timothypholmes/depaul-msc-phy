#include <stdio.h>
#include <limits.h>

void bin2dec(const char *bin_num) {

   printf ("Binary to Decimal\n");
   printf ("-----------------\n");

   const char base_digit[10] = {
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
   };

   long long int binary_number=0, i=0;

   for ( i; bin_num[i] != '\0'; i++) {
      binary_number *= 10;
      binary_number += bin_num[i] - '0';
   }

   long long dec_num=0, remainder;
   int base=1;
   
   while ( binary_number !=  0) {

      remainder = binary_number % 10; 
      dec_num = dec_num + (remainder * base);
      binary_number = binary_number / 10;
      base = base * 2;

   }

   printf("%ld\n", dec_num);

}

void dec2bin(int num) {

   printf ("Decimal to Binary\n");
   printf ("-----------------\n");

   int dec_num[64], index=0, base=2, new_digit;

   const char base_digit[2] = {
      '0', '1'
   };
	
   do {
      dec_num[index] = num % base;
      ++index;
      num = num / base;
   }
   while ( num != 0 );

   for ( --index; index >=0; --index ) {
      new_digit = dec_num[index];
      printf ("%c", base_digit[new_digit]);
   }

   printf("\n");

}
 

void hex2dec(const char *hex_num) {
   
   printf ("Hexadecimal to Decimal\n");
   printf ("----------------------\n");

   const char base_digit[10] = {
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
   };

   long long int hexadecimal_number=0, i=0;

   for ( i; hex_num[i] != '\0'; i++) {
      if (hex_num[i] >= '0' && hex_num[i] <= '9') {
         hexadecimal_number *= 16;
         hexadecimal_number += hex_num[i] - '0';}
      else if (hex_num[i] >= 'A' && hex_num[i] <= 'F') {
         hexadecimal_number *= 16;
         hexadecimal_number += hex_num[i] - 'A' + 10;}
   }
 
   printf("%ld\n", hexadecimal_number);

}

void dec2hex(int num) {

   printf ("Decimal to Hexadecimal\n");
   printf ("----------------------\n");

   int dec_num[64], index=0, base=16, new_digit;

   const char base_digit[16] = {
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
      'A', 'B', 'C', 'D', 'E', 'F'
   };
	
   do {
      dec_num[index] = num % base;
      ++index;
      num = num / base;
   }
   while ( num != 0 );

   for ( --index; index >=0; --index ) {
      new_digit = dec_num[index];
      printf ("%c", base_digit[new_digit]);
   }

   printf("\n");

}


// test code; do not modify
int main() {
  char *bin_nums[] = {"0", "10010110", "10111011001001"};
  char *hex_nums[] = {"F", "9AC", "F35E8"};
  int dec_nums[] = {0, 1, 77, 159, 65530, 987654321};
  int i;

  for (i = 0; i < sizeof(bin_nums)/sizeof(char *); i++)
  	bin2dec(bin_nums[i]);

  for (i = 0; i < sizeof(dec_nums)/sizeof(int); i++)
  	dec2bin(dec_nums[i]);

  for (i = 0; i < sizeof(hex_nums)/sizeof(char *); i++)
  	hex2dec(hex_nums[i]);

  for (i = 0; i < sizeof(dec_nums)/sizeof(int); i++)
  	dec2hex(dec_nums[i]);

  return 0;
}
