#include "cachelab.h"
#include <getopt.h> 
#include <stdlib.h> 
#include <unistd.h>  
#include <stdio.h>
#include <string.h>

// getopt variables
int  opt, h, v, s, E, b;
char *policy;
char *trace_name;

// File variables 
char operation;
unsigned long address;
int size;

// Cache counts
int hit_count = 0;
int miss_count = 0;
int eviction_count = 0;

/*
-h: Optional help flag that prints usage info
-v: Optional verbose flag that displays trace info
-s <s>: Number of set index bits (S=2s is the number of sets)
-E <E>: Associativity (number of lines per set)
-b <b>: Number of block bits (B=2b is the block size)
-p <policy>: Replacement policy (one of lru, lfu, low, or hig)
-t <tracefile>: Name of the valgrind trace to replay
*/

// Input args
typedef struct Data {
    int h;
    int v;
    int s;
    int E;
    int b;
    int S;
    int B;
    char * p;
    char * t;
} data;

// Line struct
typedef struct Line {
    int valid_bit;
    unsigned long tag_bit;
    int access;
    long frequency;
} line;

// Set struct (contains line data types)
typedef line * cache_set;

// Cache struct (contains set data types - from line)
typedef cache_set * cache;

/*
lru: Least recently used; the line that gets replaced is the line that was last accessed 
     furthest in the past.
lfu: Least frequently used; the line that gets replaced is the line that has been 
     referenced the fewest number of times since it last was added to the set. In case 
     there are multiple candidates, select the one with lowest address (smallest tag).
low: Lowest address; the line that gets replaced is the line with the smallest tag.
hig: Highest address; the line that gets replaced is the line with the greatest tag.
*/


void help() {
        
    printf("Usage: ./csim [-hv] -s <s> -E <E> -b <b> -p <policy> -t <tracefile>\n");
    printf("Options:\n");
    printf("--------\n");
    printf("    -h: Optional help flag that prints usage info\n");
    printf("    -v: Optional verbose flag that displays trace info\n");
    printf("    -s <s>: Number of set index bits (S=2^s is the number of sets)\n");
    printf("    -E <E>: Associativity (number of lines per set)\n");
    printf("    -b <b>: Number of block bits (B=2^b is the block size)\n");
    printf("    -p <policy>: Replacement policy (one of lru, lfu, low, or high)\n");
    printf("    -t <tracefile>: Name of the valgrind trace to replay\n\n");
    printf("Ex:\n");
    printf("---\n");
    printf("./csim -s 1 -E 2 -b 1 -p policy -t traces/yi2.trace\n");

}


void read_args(data * args, int argc, char ** argv) {

    while(-1 != (opt = getopt(argc, argv, "hvs:E:b:p:t:"))) 
        {
        switch(opt) {
            case 'h':
                help();
                break;
            case 'v':
                v = 1;
                break;
            case 's':
                s = atoi(optarg);
                break;
            case 'E':
                E = atoi(optarg);
                break;
            case 'b':
                b = atoi(optarg);
                break;
            case 'p':
                policy = optarg;
                break;
            case 't':
                trace_name = optarg;
                break;
            default:
                printf("Invalid Flag");
                break;

        }
    }
}


void init_cache(cache * system_cache, data * cache_data) {

    int set_n  = cache_data->S;
    int line_n = cache_data->E;
    
    // Allocate memory in heap for set
    *system_cache = (cache_set *)malloc(sizeof(cache_set) * set_n);

    for(int cur_set = 0; cur_set < set_n; cur_set++) {

        // Allocate memory in heap for line set
        (*system_cache)[cur_set] = (line*)malloc(sizeof(line)*line_n);

        for(int cur_line = 0; cur_line < line_n; cur_line++) {

            // Assign zero for all line (and set) values
            (*system_cache)[cur_set][cur_line].valid_bit = 0;
            (*system_cache)[cur_set][cur_line].tag_bit   = 0;
            (*system_cache)[cur_set][cur_line].access    = 0;
            (*system_cache)[cur_set][cur_line].frequency = 0;
        }
    }
}


void cache_process(int address, cache * system_cache, data * cache_data) {

	long set_index = (address >> cache_data->b) & (cache_data->S - 1); 
	long tag = (address >> (cache_data->b + cache_data->s)); 

    // Policy identifiers
    const char *policy_set[] = {"lru", "lfu", "low", "hig"};

    int last_line = cache_data->E;
    char *policy = cache_data->p;
    cache_set set = (*system_cache)[set_index];

    for (int i = 0; i < last_line; i++) {
        
        if (set[i].valid_bit == 1) { // Account for # of access in set
            set[i].access++;
        }   

        if (set[i].tag_bit == tag && set[i].valid_bit == 1) { // Account for # of frew access in set
            set[i].frequency++;
        }
        
    }

    for (int i = 0; i < last_line; i++) {
        if (set[i].tag_bit == tag && set[i].valid_bit == 1) {
            if (v) {
                printf("hit");
            }
            set[i].access = 0;
            hit_count++;
            return;
        }
    }

    
    miss_count++;
    if (v) {
        printf("miss");
    }
    for (int i = 0; i < last_line; i++) {
        if (set[i].valid_bit == 0) {
            set[i].tag_bit   = tag;
            set[i].valid_bit = 1;
            set[i].access    = 0;
            return;
        }
    }

    eviction_count++; // Count miss and evict (set evict values)
    
    if (v) {
        printf(" eviction");
    }

    // Run lru replacment policy
    if (strcmp(policy, policy_set[0]) == 0) {
        int last_set = 0, last_access = set[0].access;
        for (int i = 0; i < last_line; i++) {
            if (set[i].access > last_access) {
                last_set = i;
                last_access = set[i].access;
            }
        }
        set[last_set].tag_bit = tag;
        set[last_set].access = 0;
    }
    
    
    // Run lfu replacment policy
    if (strcmp(policy, policy_set[1]) == 0) {
        int freq_set = 0, freq = set[0].frequency, low_tag = set[0].tag_bit;
        for(int i = 0; i < last_line; i++) {
            if (set[i].frequency < freq) {
                freq_set = i;
                freq = set[i].frequency;
                low_tag = set[i].tag_bit;
            }

            else if ((set[i].frequency == freq) & (set[i].tag_bit < low_tag)) { // If the same pick lowest tag
                freq_set = i;
                freq = set[i].frequency;
            }

        }
        set[freq_set].tag_bit   = tag;
        set[freq_set].frequency = 0;
    }
    
    
    // Run low replacment policy
    if (strcmp(policy, policy_set[2]) == 0) {
        int low_index = 0, low_tag = set[0].tag_bit;
        for (int i = 0; i < last_line; i++) {
            if (set[i].tag_bit < low_tag) {
                low_index = i;
                low_tag = set[i].tag_bit;
            }
        }
        set[low_index].tag_bit = tag;
    }

    
    // Run high replacment policy
    if (strcmp(policy, policy_set[3]) == 0) {
        int high_index = 0, high_tag = set[0].tag_bit;
        for (int i = 0; i < last_line; i++) {
            if (set[i].tag_bit > high_tag) {
                high_index = i;
                high_tag = set[i].tag_bit;
            }
        }
        set[high_index].tag_bit = tag;
    }
    
}


void read_trace(cache * system_cache, data * cache_data) {

    // Read in the file
    FILE *trace_file = fopen(cache_data->t, "r"); 

    // Scan each line in the files
    while(fscanf(trace_file, " %c %lx,%d", &operation, &address, &size) > 0) {
        if (v) {
            printf("\n %c %lx,%d ", operation, address, size);
        }

        switch(operation) {
            case 'I':
                break;
            case 'L': // Data load operation
                cache_process(address, system_cache, cache_data);
                break;

            case 'S': // Data store operation
                cache_process(address, system_cache, cache_data);
                break;

            case 'M': // Data modify operation
                // Acts as a load and a store so cache_process is called twice
                cache_process(address, system_cache, cache_data);
                cache_process(address, system_cache, cache_data);
                break;
        }  
    }

    printf("\n");
    fclose(trace_file);

}


int main(int argc, char** argv) {

    // Call structs
    cache system_cache;
    data  cache_data;
    
    read_args(&cache_data, argc, argv);

    // Set struct variables with inputs
    cache_data.s = s;
    cache_data.E = E;
    cache_data.b = b;
    cache_data.p = policy;
    cache_data.t = trace_name;
    cache_data.S = (1 << s);
    cache_data.B = (1 << b);

    // Run sim
    // -------
    init_cache(&system_cache, &cache_data); // Initialize cache
    read_trace(&system_cache, &cache_data); // Read in trace files and run caching process
    printSummary(hit_count, miss_count, eviction_count); // Print results
    
    // Used malloc, clear memory
    for(int i = 0; i < (cache_data.S); i++) {
        free(system_cache[i]);
    }
    free(system_cache);

    return 0;
}