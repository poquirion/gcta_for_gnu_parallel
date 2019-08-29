#!/usr/bin/env bash
#SBATCH -A def-poq-ad
#SBATCH --time
#SBATCH --job-name $chr
#SBATCH --mem=0
#SBATCH  --ntasks-per-node=40
#SBATCH  --node=1



parallel --joblog ${chr}.log  --jobs ${SLURM_CPUS_ON_NODE}  < ${chr}
