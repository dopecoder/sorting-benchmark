#!/bin/bash

# Variables for setting timeout on test calls.
timeoutOccuredExitCode=124
timeoutLength=100

# Construct the output file path.
mkdir -p outputs
fileName=outputs/result
currentTime=$(date "+%s")
outputFileName=$fileName-$currentTime.csv

# Run the script with timeout.
function runScript {

    export LD_PRELOAD=../../preloadlib/bin/preloadlib.so
    ./sorting_benchmarks.out $1 $2 ../data/sorting-benchmarks/data/output-local.txt $3
}
# Number of elements and algorithms arrays.
files=(data/asc_input.txt data/desc_input.txt data/rand_input.txt)
elementCount=(10 100 1000 10000 1000000)
algorithms=(is ms qs)

# Loop over the elements and algorithms and run the tests for every combination.


for fileName in "${files[@]}"
do
    echo "-------------------- $fileName --------------------" | tee -a $outputFileName
    for numberOfElements in "${elementCount[@]}"
    do
        for algorithm in "${algorithms[@]}"
        do
            # for count in {1..3}
            # do
            echo $elementCount >> $outputFileName
            runScript $numberOfElements $fileName $algorithm | tee -a $outputFileName
            # done
        done
    done
done

