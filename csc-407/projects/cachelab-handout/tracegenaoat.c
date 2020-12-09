/*
 * tracegen.c - Running the binary tracegen with valgrind produces
 * a memory trace of all of the registered aoatpose functions.
 *
 * The beginning and end of each registered aoatpose function's trace
 * is indicated by reading from "marker" addresses. These two marker
 * addresses are recorded in file for later use.
 */

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <unistd.h>
#include <getopt.h>
#include "cachelab.h"
#include <string.h>

/* External variables declared in cachelab.c */
extern aoat_func_t func_list_aoat[MAX_AOAT_FUNCS];
extern int func_counter_aoat;

/* External function from aoat.c */
extern void registerAoatFunctions();

/* Markers used to bound trace regions of interest */
volatile char MARKER_START, MARKER_END;

static int A[256][256];
static int N;


int validate (int fn, int N, const int A[N][N], int grand_sum) {
  int correct = correctAoat (N, A);

  if (grand_sum != correct) {
    printf ("Validation failed on function %d! Expected %d but got %d\n", fn, correct, grand_sum);
    return 0;
  }

  return 1;
}

int main (int argc, char *argv[]) {
  int i;

  char c;
  int selectedFunc = -1;

  while ( (c = getopt (argc, argv, "N:F:")) != -1) {
    switch (c) {
    case 'N':
      N = atoi (optarg);
      break;

    case 'F':
      selectedFunc = atoi (optarg);
      break;

    case '?':
    default:
      printf ("./tracegen failed to parse its options.\n");
      exit (1);
    }
  }


  /*  Register aoat functions */
  registerAoatFunctions();

  /* Fill A with data */
  initMatrix (N, N, A, A);

  /* Record marker addresses */
  FILE *marker_fp = fopen (".marker", "w");
  assert (marker_fp);
  fprintf (marker_fp, "%llx %llx",
           (unsigned long long int) &MARKER_START,
           (unsigned long long int) &MARKER_END);
  fclose (marker_fp);

  if (-1 == selectedFunc) {
    /* Invoke registered aoat functions */
    for (i = 0; i < func_counter_aoat; i++) {
      MARKER_START = 33;
      int res = (*func_list_aoat[i].func_ptr) (N, A);
      MARKER_END = 34;

      if (!validate (i, N, A, res))
        return i + 1;
    }
  } else {
    MARKER_START = 33;
    int res = (*func_list_aoat[selectedFunc].func_ptr) (N, A);
    MARKER_END = 34;

    if (!validate (selectedFunc, N, A, res))
      return selectedFunc + 1;

  }

  return 0;
}
