/*
 * aoat.c - Matrix aoat: grand-sum(A o A^T).
 *
 * Each aoat function must have a prototype of the form:
 * int aoat (int N, const int A[N][N]);
 *
 * A aoat function is evaluated by counting the number of misses
 * on a 1KB direct mapped cache with a block size of 32 bytes.
 */
#include <stdio.h>
#include "cachelab.h"

/*
 * aoat_submit - This is the solution aoat function that you
 *     will be graded on for Part B of the assignment. Do not change
 *     the description string "Aoat submission", as the driver
 *     searches for that string to identify the aoat function to
 *     be graded.
 */
char aoat_submit_desc[] = "Aoat submission";
int aoat_submit (int N, const int A[N][N]) {
  int row_index, col_index, row_block_index, col_block_index, sum = 0;

  if (N == 32) { // For the 32x32 case
    int B = 8; // Block size
    for (row_index = 0; row_index < N; row_index += B) {
      for (col_index = 0; col_index < N; col_index += B) {
        for (row_block_index = row_index; row_block_index < row_index + B; row_block_index++) {
          for (col_block_index = col_index; col_block_index < col_index + B; col_block_index++) {
            if (row_index < col_index) { // Limit to upper triangle
              sum += 2 * (A[row_block_index][col_block_index] * A[col_block_index][row_block_index]);
            }
            else if (row_index == col_index) { // Limit to diag
              sum += A[row_block_index][col_block_index] * A[col_block_index][row_block_index];
            }
          }
        }
      }
    }
    return sum;
  }

  else if (N == 64) { // For the 64x64 case
    int B = 4; // 4 Block size
    for (row_index = 0; row_index < N; row_index += B) {
      for (col_index = 0; col_index < N; col_index += B) {
        for (row_block_index = row_index; row_block_index < row_index + B; row_block_index++) {
          for (col_block_index = col_index; col_block_index < col_index + B; col_block_index++) {
            if (row_index < col_index) { // Limit to upper triangle (can also be lower) takes advantage of spacial locality 
              sum += 2 * (A[row_block_index][col_block_index] * A[col_block_index][row_block_index]);
            }
            else if (row_index == col_index) { // Limit to diag
              sum += A[row_block_index][col_block_index] * A[col_block_index][row_block_index];
            }
          }
        }
      }
    }
    return sum;
  }

  else if (N == 67) { // For the 67x67 case
    int B = 17; // 5 17 Block size
    for (row_index = 0; row_index < N; row_index += B) {
      for (col_index = 0; col_index < N; col_index += B) {
        for (row_block_index = row_index; row_block_index < row_index + B; row_block_index++) {
          for (col_block_index = col_index; col_block_index < col_index + B; col_block_index++) {
            if (row_index < col_index) { // Limit to upper triangle
              sum += 2 * (A[row_block_index][col_block_index] * A[col_block_index][row_block_index]);
            }
            else if (row_index == col_index) { // Limit to diag
              sum += A[row_block_index][col_block_index] * A[col_block_index][row_block_index];
            }
          }
        }
      }
    }
    return sum;
  }
  return 0;
}


char aoat_simple_block_desc[] = "Aoat simple block (Not taking advantage of symmetry)";
int aoat_simple_block (int N, const int A[N][N]) {
  int row_index, col_index, row_block_index, col_block_index, sum = 0;

  if (N == 32) {
    int B = 8;
    for (row_index = 0; row_index < N; row_index += B) {
      for (col_index = 0; col_index < N; col_index += B) {
        for (row_block_index = row_index; row_block_index < row_index + B; row_block_index++) {
          for (col_block_index = col_index; col_block_index < col_index + B; col_block_index++) {
            sum += A[row_block_index][col_block_index] * A[col_block_index][row_block_index];
          }
        }
      }
    }
    return sum;
  }

  else if (N == 64) {
    int B = 4;
    for (row_index = 0; row_index < N; row_index += B) {
      for (col_index = 0; col_index < N; col_index += B) {
        for (row_block_index = row_index; row_block_index < row_index + B; row_block_index++) {
          for (col_block_index = col_index; col_block_index < col_index + B; col_block_index++) {
            sum += A[row_block_index][col_block_index] * A[col_block_index][row_block_index];
          }
        }
      }
    }
    return sum;
  }

  else if (N == 67) {
    int B = 23;
    for (row_index = 0; row_index < N; row_index += B) {
      for (col_index = 0; col_index < N; col_index += B) {
        for (row_block_index = row_index; row_block_index < row_index + B; row_block_index++) {
          for (col_block_index = col_index; col_block_index < col_index + B; col_block_index++) {
            sum += A[row_block_index][col_block_index] * A[col_block_index][row_block_index];
          }
        }
      }
    }
      return sum;
    }
  return 0;
}


/*
 * aoat - A simple baseline aoat function, not optimized for the cache.
 */
char aoat_desc[] = "Simple row-wise scan aoat";
int aoat (int N, const int A[N][N]) {
  int i, j, res = 0;

  for (i = 0; i < N; i++) {
    for (j = 0; j < N; j++) {
      res += A[i][j] * A[j][i];
    }
  }

  return res;
}

/*
 * registerAoatFunctions - This function registers your aoat
 *     functions with the driver.  At runtime, the driver will
 *     evaluate each of the registered functions and summarize their
 *     performance. This is a handy way to experiment with different
 *     aoat strategies.
 */
void registerAoatFunctions() {
  /* Register your solution function */
  registerAoatFunction (aoat_submit, aoat_submit_desc);

  /* Register any additional aoat functions */
  registerAoatFunction (aoat, aoat_desc);
  //registerAoatFunction (aoat_simple_block ,aoat_simple_block_desc);
}
