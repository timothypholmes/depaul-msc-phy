#!/usr//bin/python
#
# driver.py - The driver tests the correctness of the student's cache
#     simulator and the correctness and performance of their aoat
#     function. It uses ./test-csim to check the correctness of the
#     simulator and it runs ./test-aoat on three different sized
#     matrices (32x32, 64x64, and 67x67) to test the correctness and
#     performance of the aoat function.
#
import subprocess;
import re;
import os;
import sys;
import optparse;

#
# computeMissScore - compute the score depending on the number of
# cache misses
#
def computeMissScore(miss, lower, upper, bonus, full_score):
    if miss <= bonus:
        return full_score + 2
    if miss <= lower:
        return full_score
    if miss >= upper: 
        return 0

    score = (miss - lower) * 1.0 
    range = (upper- lower) * 1.0
    return round((1 - score / range) * full_score, 1)

#
# main - Main function
#
def main():

    # Configure maxscores here
    maxscore= {};
    maxscore['csim'] = 27
    maxscore['aoatc'] = 1
    maxscore['aoat32'] = 8
    maxscore['aoat64'] = 8
    maxscore['aoat67'] = 10

    # Parse the command line arguments 
    p = optparse.OptionParser()
    p.add_option("-A", action="store_true", dest="autograde", 
                 help="emit autoresult string for Autolab");
    opts, args = p.parse_args()
    autograde = opts.autograde

    # Check the correctness of the cache simulator
    print("Part A: Testing cache simulator")
    print("Running ./test-csim")
    p = subprocess.Popen("./test-csim", 
                         shell=True, stdout=subprocess.PIPE)
    stdout_data = p.communicate()[0].decode('ascii')

    # Emit the output from test-csim
    stdout_data = re.split('\n', stdout_data)
    for line in stdout_data:
        if re.match("TEST_CSIM_RESULTS", line):
            resultsim = re.findall(r'(\d+)', line)
        else:
            print("%s" % (line))

    # Check the correctness and performance of the aoat function
    # 32x32 aoat
    print("Part B: Testing aoat function")
    print("Running ./test-aoat -N 32")
    p = subprocess.Popen("./test-aoat -N 32 | grep TEST_AOAT_RESULTS", 
                         shell=True, stdout=subprocess.PIPE)
    stdout_data = p.communicate()[0].decode('ascii')
    result32 = re.findall(r'(\d+)', stdout_data)
    
    # 64x64 aoat
    print("Running ./test-aoat -N 64")
    p = subprocess.Popen("./test-aoat -N 64 | grep TEST_AOAT_RESULTS", 
                         shell=True, stdout=subprocess.PIPE)
    stdout_data = p.communicate()[0].decode('ascii')
    result64 = re.findall(r'(\d+)', stdout_data)
    
    # 67x67 aoat
    print("Running ./test-aoat -N 67")
    p = subprocess.Popen("./test-aoat -N 67 | grep TEST_AOAT_RESULTS", 
                         shell=True, stdout=subprocess.PIPE)
    stdout_data = p.communicate()[0].decode('ascii')
    result67 = re.findall(r'(\d+)', stdout_data)
    
    # Compute the scores for each step
    csim_cscore  = list(map(int, resultsim[0:1]))
    aoat_cscore = int(result32[0]) * int(result64[0]) * int(result67[0]);
    miss32 = int(result32[1])
    miss64 = int(result64[1])
    miss67 = int(result67[1])
    aoat32_score = computeMissScore(miss32, 200, 600, 131, maxscore['aoat32']) * int(result32[0])
    aoat64_score = computeMissScore(miss64, 1000, 3000, 851, maxscore['aoat64']) * int(result64[0])
    aoat67_score = computeMissScore(miss67, 1100, 2200, 887, maxscore['aoat67']) * int(result67[0])
    total_score = csim_cscore[0] + aoat32_score + aoat64_score + aoat67_score

    # Summarize the results
    print("\nCache Lab summary:")
    print("%-22s%8s%10s%12s" % ("", "Points", "Max pts", "Misses"))
    print("%-22s%8.1f%10d" % ("Csim correctness", csim_cscore[0], 
                              maxscore['csim']))

    misses = str(miss32)
    if miss32 == 2**31-1 :
        misses = "invalid"
    print("%-22s%8.1f%10d%12s" % ("Aoat perf 32x32", aoat32_score, 
                                  maxscore['aoat32'], misses))

    misses = str(miss64)
    if miss64 == 2**31-1 :
        misses = "invalid"
    print("%-22s%8.1f%10d%12s" % ("Aoat perf 64x64", aoat64_score, 
                                  maxscore['aoat64'], misses))

    misses = str(miss67)
    if miss67 == 2**31-1 :
        misses = "invalid"
    print("%-22s%8.1f%10d%12s" % ("Aoat perf 67x67", aoat67_score, 
                                  maxscore['aoat67'], misses))

    print("%22s%8.1f%10d" % ("Total points", total_score,
                             maxscore['csim'] + 
                             maxscore['aoat32'] + 
                             maxscore['aoat64'] +
                             maxscore['aoat67']))
    
    # Emit autoresult string for Autolab if called with -A option
    if autograde:
        autoresult="%.1f:%d:%d:%d" % (total_score, miss32, miss64, miss67)
        print("\nAUTORESULT_STRING=%s" % autoresult)
    
    
# execute main only if called as a script
if __name__ == "__main__":
    main()

