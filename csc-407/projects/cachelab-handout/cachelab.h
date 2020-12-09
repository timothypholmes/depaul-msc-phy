/*
 * cachelab.h - Prototypes for Cache Lab helper functions
 */

#ifndef CACHELAB_TOOLS_H
#define CACHELAB_TOOLS_H

#define MAX_TRANS_FUNCS 100
#define MAX_AOAT_FUNCS 100

typedef struct trans_func {
  void (*func_ptr) (int M, int N, const int[N][M], int[M][N]);
  char *description;
  char correct;
  unsigned int num_hits;
  unsigned int num_misses;
  unsigned int num_evictions;
} trans_func_t;

typedef struct aoat_func {
  int (*func_ptr) (int N, const int[N][N]);
  char *description;
  char correct;
  unsigned int num_hits;
  unsigned int num_misses;
  unsigned int num_evictions;
} aoat_func_t;


/*
 * printSummary - This function provides a standard way for your cache
 * simulator * to display its final hit and miss statistics
 */
void printSummary (int hits, /* number of  hits */
                   int misses, /* number of misses */
                   int evictions); /* number of evictions */

/* Fill the matrix with data */
void initMatrix (int M, int N, int A[N][M], int B[M][N]);

/* The baseline trans function that produces correct results. */
void correctTrans (int M, int N, const int A[N][M], int B[M][N]);

/* Add the given function to the function list */
void registerTransFunction (
  void (*trans) (int M, int N, const int[N][M], int[M][N]), char *desc);

/* The baseline aoat function that produces correct results. */
int correctAoat (int N, const int A[N][N]);

/* Add the given function to the function list */
void registerAoatFunction (
  int (*aoat) (int N, const int[N][N]), char *desc);

#endif /* CACHELAB_TOOLS_H */
