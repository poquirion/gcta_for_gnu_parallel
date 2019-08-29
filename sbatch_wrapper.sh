#!/bin/bash


# for chr in chr*.dat; do
for chr in test.dat; do

  export chr
  echo $chr
  sbatch parallel_wrapper.sh

done
