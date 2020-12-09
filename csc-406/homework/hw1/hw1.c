#include <stdio.h>
#include <limits.h>

void ranges() {

  // Char
	printf("signed char\n");
	printf("minimum value: %d\n", SCHAR_MIN);
	printf("maximim value: %u\n\n", SCHAR_MAX);

  printf("unsigned char\n");
	printf("minimum value: %u\n", 0);
	printf("maximim value: %u \n\n", UCHAR_MAX);


  // Short
  printf("signed short\n");
	printf("minimum value: %d\n", SHRT_MIN);
	printf("maximim value: %d\n\n", SHRT_MAX);

  printf("unsigned short\n");
	printf("minimum value: %d\n", 0);
	printf("maximim value: %u\n\n", USHRT_MAX);


  // Int
  printf("signed int\n");
	printf("minimum value: %d\n", INT_MIN);
	printf("maximim value: %d\n\n", INT_MAX);

  printf("unsigned int\n");
	printf("minimum value: %d\n", 0);
	printf("maximim value: %u\n\n", UINT_MAX);


  // Long
  printf("signed long\n");
	printf("minimum value: %ld\n", LONG_MIN);
	printf("maximim value: %ld\n\n", LONG_MAX);

  printf("unsigned long\n");
	printf("minimum value: %d\n", 0);
	printf("maximim value: %lu\n\n", ULONG_MAX);


  // Long Long
  printf("signed long long\n");
	printf("minimum value: %lld\n", LLONG_MIN);
	printf("maximim value: %lld\n\n", LLONG_MAX);

  printf("unsigned long long\n");
	printf("minimum value: %d\n", 0);
	printf("maximim value: %llu\n\n", ULLONG_MAX);
  
}

void types() {

  char   a1='A',   a2='b',  a3='c';
  short  b1=35344, b2=2342, b3=-32000;
  int    c1=11,    c2=22,   c3=50;
  double d1=3.14,  d2=5.63, d3=23.1;

  // Char
  printf("&a1 = %p, %ul\n", &a1, &a1);
  printf("&a2 = %p, %ul\n", &a2, &a2);
  printf("&a3 = %p, %ul\n", &a3, &a3);


  // Short  
  printf("&b1 = %p, %ul\n", &b1, &b1);
  printf("&b2 = %p, %ul\n", &b2, &b2);
  printf("&b3 = %p, %ul\n", &b3, &b3);


  // Int
  printf("&c1 = %p, %ul\n", &c1, &c1);
  printf("&c2 = %p, %ul\n", &c2, &c2);
  printf("&c3 = %p, %ul\n", &c3, &c3);


  // Double
  printf("&d1 = %p, %ul\n", &d1, &d1);
  printf("&d2 = %p, %ul\n", &d2, &d2);
  printf("&d3 = %p, %ul\n", &d3, &d3);
  
}

void input_output() {

  char name[32];
  
  printf("Enter your name: ");
  fgets(name, sizeof(name), stdin);
  printf("Hello %s\n", name);

}

void area() {

  char height_str[32], width_str[32], *ptr;
  int height, width, area;


  // Height
  printf("What is the height? ");
  fgets(height_str, sizeof(height_str), stdin);
  height = strtol(height_str, &ptr, 10);


  // Width
  printf("What is the width? ");
  fgets(width_str, sizeof(width_str), stdin);
  width = strtol(width_str, &ptr, 10);


  // Area
  area = height * width;

  printf("The area is %d. \n", area);

}

void sum() {

  int data[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
  size_t data_len = sizeof (data) / sizeof(data[0]);
  int sum, i;

  sum = 0;

  for (i = 0; i <= sizeof(data_len) + 1; i++) {

    printf("%d \n", data[i]);
    sum += data[i];
    
  }

  printf("sum: %d \n", sum);
  
}

// test code; do not modify
int main() {
  ranges();

  types();

  input_output();

  area();

  sum();

  return 0;
}
