#pragma once

#include <stdio.h>
#include "config.h"

extern int mm_init (void);
extern void *mm_malloc (size_t size);
extern void mm_free (void *ptr);
extern void *mm_realloc(void *ptr, size_t size);

#ifdef DEBUG
# define debug(args...) do { printf (args); } while (0)
extern void check_consistency ();
#else
# define debug(args...)
# define check_consistency(args...)
#endif

/* Memory alignment. */
#define ALIGN(size) (((size) + (ALIGNMENT-1)) & ~0x7)
