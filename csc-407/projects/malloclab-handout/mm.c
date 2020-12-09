/*
 * mm-naive.c - The fastest, least memory-efficient malloc package.
 *
 * In this naive approach, a block is allocated by simply incrementing the brk
 * pointer.  A block has a header which is the size of the payload. There are no
 * footers.  Blocks are never coalesced or reused. Realloc is not implemented.
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>
#include <string.h>
#include "mm.h"
#include "memlib.h"


// Define Marcros
#define WSIZE                8       // single word
#define DSIZE                16      // double word
#define CHUNKSIZE            (1<<13) // init free block and default size

#define MAX(x, y)            ((x) > (y)? (x) : (y))
#define PACK(size, alloc)    ((size) | (alloc))
#define GET(p)               (*(size_t *)(p))
#define PUT(p, val)          (*(size_t *)(p) = (val))
#define GET_SIZE(p)          (GET(p) & ~0x1)
#define GET_ALLOC(p)         (GET(p) & 0x1)
#define HDRP(bp)             ((void *)(bp) - WSIZE)
#define FTRP(bp)             ((void *)(bp) + GET_SIZE(HDRP(bp)) - DSIZE)
#define NEXT_BLKP(bp)        ((void *)(bp) + GET_SIZE(HDRP(bp)))
#define PREV_BLKP(bp)        ((void *)(bp) - GET_SIZE((void *)(bp) - DSIZE))
#define GET_NEXT_PTR(bp)     (*(char **)(bp + WSIZE))
#define GET_PREV_PTR(bp)     (*(char **)(bp))
#define SET_NEXT_PTR(bp, fptr) (GET_NEXT_PTR(bp) = fptr)
#define SET_PREV_PTR(bp, fptr) (GET_PREV_PTR(bp) = fptr)

static void *extend_heap(size_t words);
static void *find_fit(size_t size);
static void *coalesce(void *bp);
static void place(void *bp, size_t asize);
static void remove_list(void *bp); 

static char *heap_listp = 0;  
static char *free_listp = 0;  

// Init heap
int mm_init(void) {
  
  if ((heap_listp = mem_sbrk(4 * DSIZE)) == NULL) {
    return -1;
  }
  
  PUT(heap_listp + (1 * WSIZE), PACK(DSIZE, 1)); // Free block header
  PUT(heap_listp + (2 * WSIZE), PACK(DSIZE, 1)); // Free block footer
  PUT(heap_listp + (3 * WSIZE), PACK(0, 1));     // Epilouge header
  free_listp = heap_listp + DSIZE;

  if (extend_heap(CHUNKSIZE / WSIZE) == NULL) {
    return -1;
  }
  return 0;
}

// Allocate block
void *mm_malloc(size_t size) {

  size_t asize;      
  size_t extendsize; 
  void *bp;

  if (size == 0) {
    return NULL;
  }

  if (size <= DSIZE)
    asize = (2 * DSIZE);
  else
    asize = DSIZE * ((size + DSIZE + (DSIZE - 1)) / DSIZE);

  if ((bp = find_fit(asize)) != NULL) {
    place(bp, asize);
    return bp;
  }

  extendsize = MAX(asize, CHUNKSIZE);
  if ((bp = extend_heap(extendsize / WSIZE)) == NULL)  
    return (NULL);
  place(bp, asize);
  return bp;

  check_consistency(bp);
} 

// Free block
void mm_free(void *bp) {

  size_t size = GET_SIZE(HDRP(bp));
  PUT(HDRP(bp), PACK(size, 0));
  PUT(FTRP(bp), PACK(size, 0));
  coalesce(bp);

}

// Merge agjacent blocks
static void *coalesce(void *bp) {

  check_consistency(bp);

  size_t prev_alloc = GET_ALLOC(FTRP(PREV_BLKP(bp))) || PREV_BLKP(bp) == bp;
  size_t next_alloc = GET_ALLOC(HDRP(NEXT_BLKP(bp)));
  size_t size = GET_SIZE(HDRP(bp));
  
  if (prev_alloc && next_alloc) { // Case 1: Pass
    // pass
  }

  else if (prev_alloc && !next_alloc) { // Case 2: Merge right           
    size += GET_SIZE( HDRP(NEXT_BLKP(bp)));
    remove_list(NEXT_BLKP(bp));
    PUT(HDRP(bp), PACK(size, 0));
    PUT(FTRP(bp), PACK(size, 0));
  }

  else if (!prev_alloc && next_alloc) { // Case 3: Merge left         
    size += GET_SIZE( HDRP(PREV_BLKP(bp)));
    remove_list(PREV_BLKP(bp));
    bp = PREV_BLKP(bp);
    PUT(HDRP(bp), PACK(size, 0));
    PUT(FTRP(bp), PACK(size, 0));
  }

  else if (!prev_alloc && !next_alloc) { // Case 4: Merge both            
    size += GET_SIZE( HDRP(PREV_BLKP(bp))) + GET_SIZE( HDRP(NEXT_BLKP(bp)));
    remove_list(PREV_BLKP(bp));
    remove_list(NEXT_BLKP(bp));
    bp = PREV_BLKP(bp);
    PUT(HDRP(bp), PACK(size, 0));
    PUT(FTRP(bp), PACK(size, 0));
  }

  // insert coalesced block in free list
  SET_NEXT_PTR(bp, free_listp); 
  SET_PREV_PTR(free_listp, bp); 
  SET_PREV_PTR(bp, NULL); 
  free_listp = bp; 

  return bp;
  check_consistency(bp);
}

// Extend heap
static void *extend_heap(size_t words) {

  char *bp;
  size_t size = (words % 2) ? (words+1) * WSIZE : words * WSIZE;

  if (size < DSIZE) { // Min size is 4 words
    size = DSIZE;
  }

  if ((long)(bp = mem_sbrk(size)) == -1) {
	    return NULL;  
  }

  PUT(HDRP(bp), PACK(size, 0));        
  PUT(FTRP(bp), PACK(size, 0));        
  PUT(HDRP(NEXT_BLKP(bp)), PACK(0, 1)); 

  return coalesce(bp);
  check_consistency(bp);
}

// Finds fit for block
static void *find_fit(size_t asize) {

  void *bp;

  for (bp = free_listp; GET_ALLOC(HDRP(bp)) == 0; bp = GET_NEXT_PTR(bp)) {
    if (asize <= GET_SIZE(HDRP(bp))) 
      return bp; 
  }
  return NULL; 
  check_consistency(bp);
}

// Set headers and footers
static void place(void *bp, size_t asize) {

  check_consistency(bp);
  
  size_t csize = GET_SIZE(HDRP(bp));

  if ((csize - asize) >= (2 * DSIZE)) { // Split
    PUT(HDRP(bp), PACK(asize, 1));
    PUT(FTRP(bp), PACK(asize, 1));
    remove_list(bp);
    bp = NEXT_BLKP(bp);
    PUT(HDRP(bp), PACK(csize - asize, 0));
    PUT(FTRP(bp), PACK(csize - asize, 0));
    coalesce(bp);
  }
  else {                               // Don't split
    PUT(HDRP(bp), PACK(csize, 1));
    PUT(FTRP(bp), PACK(csize, 1));
    remove_list(bp);
  }
  check_consistency(bp);
}

// Remove free block pointer
static void remove_list(void *bp){

  check_consistency(bp);

  if (GET_PREV_PTR(bp)) {
    SET_NEXT_PTR(GET_PREV_PTR(bp), GET_NEXT_PTR(bp));
  }
  else {
    free_listp = GET_NEXT_PTR(bp);
  }
  SET_PREV_PTR(GET_NEXT_PTR(bp), GET_PREV_PTR(bp));
  check_consistency(bp);
}

// Reallocate block
void *mm_realloc(void *ptr, size_t size) {

  check_consistency(ptr);

  if (ptr == 0) {
    mm_malloc(size);
  }

  if (size == 0) {
    mm_free(ptr);
  }

  if (ptr != 0) {
    mm_malloc(size);
  }

  return 0;
  check_consistency(ptr);
}

#ifdef DEBUG

void check_consistency (void *bp) {

  if (GET(HDRP(bp)) != GET(FTRP(bp))) {
    printf("header neq to footer\n");
  }

  /*
  if (GET_SIZE(HDRP(heap_listp)) != DSIZE || !GET_ALLOC(HDRP(heap_listp))) {
    printf("header error")
  }
  */

  /*
  printf("%lu\n", GET_SIZE(HDRP(bp)));
  printf("%lu\n", GET_SIZE(FTRP(bp));
  */

  // print heap
  //printf("heap %p \n", heap_listp);

  // print free
  //printf("free %p \n", free_listp);
}

#endif
