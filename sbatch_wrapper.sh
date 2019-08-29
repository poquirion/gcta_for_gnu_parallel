#!/bin/bash


# for chr in chr*.dat; do
for chr in test40.dat; do

  export chr
  echo $chr
  sbatch --job-name=$chr.run --output=$chr.slurm-%j.out   parallel_wrapper.sh

done
