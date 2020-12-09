/*
 * cachelab.c - Cache Lab helper functions
 */
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "cachelab.h"
#include <time.h>

trans_func_t func_list[MAX_TRANS_FUNCS];
aoat_func_t func_list_aoat[MAX_TRANS_FUNCS];
int func_counter = 0;
int func_counter_aoat = 0;

/*
 * printSummary - Summarize the cache simulation statistics. Student cache simulators
 *                must call this function in order to be properly autograded.
 */
void printSummary (int hits, int misses, int evictions) {
  printf ("hits:%d misses:%d evictions:%d\n", hits, misses, evictions);
  FILE *output_fp = fopen (".csim_results", "w");
  assert (output_fp);
  fprintf (output_fp, "%d %d %d\n", hits, misses, evictions);
  fclose (output_fp);
}

/*
 * initMatrix - Initialize the given matrix
 */
void initMatrix (int M, int N, int A[N][M], int B[M][N]) {
  int i, j;
  srand (time (NULL));

  for (i = 0; i < N; i++) {
    for (j = 0; j < M; j++) {
      // A[i][j] = i+j;  /* The matrix created this way is symmetric */
      A[i][j] = rand() % 256;
      B[j][i] = rand() % 256;
    }
  }
}

/*
 * correctTrans - baseline transpose function used to evaluate correctness
 */
void correctTrans (int M, int N, const int A[N][M], int B[M][N]) {
  int i, j, tmp;

  for (i = 0; i < N; i++) {
    for (j = 0; j < M; j++) {
      tmp = A[i][j];
      B[j][i] = tmp;
    }
  }
}

/*
 * correctAoat - baseline aoat function used to evaluate correctness
 */
int correctAoat (int N, const int A[N][N]) {
  int i, j, res = 0;

  for (i = 0; i < N; i++) {
    for (j = 0; j < N; j++) {
      res += A[i][j] * A[j][i];
    }
  }

  return res;
}



/*
 * registerTransFunction - Add the given trans function into your list
 *     of functions to be tested
 */
void registerTransFunction (void (*trans) (int M, int N, const int[N][M], int[M][N]),
                            char *desc) {
  func_list[func_counter].func_ptr = trans;
  func_list[func_counter].description = desc;
  func_list[func_counter].correct = 0;
  func_list[func_counter].num_hits = 0;
  func_list[func_counter].num_misses = 0;
  func_list[func_counter].num_evictions = 0;
  func_counter++;
}

/*
 * registerAoatFunction - Add the given aoat function into your list
 *     of functions to be tested
 */
void registerAoatFunction (int (*aoat) (int N, const int[N][N]),
                           char *desc) {
  func_list_aoat[func_counter_aoat].func_ptr = aoat;
  func_list_aoat[func_counter_aoat].description = desc;
  func_list_aoat[func_counter_aoat].correct = 0;
  func_list_aoat[func_counter_aoat].num_hits = 0;
  func_list_aoat[func_counter_aoat].num_misses = 0;
  func_list_aoat[func_counter_aoat].num_evictions = 0;
  func_counter_aoat++;
}
