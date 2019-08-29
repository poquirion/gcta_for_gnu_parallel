#!/usr/bin/env bash
#SBATCH -A def-lathrop
#SBATCH --time 01:00:00
#SBATCH --mem=771000
#SBATCH  --ntasks-per-node=40
#SBATCH  --nodes=1


parallel --joblog ${chr}.log  --jobs ${SLURM_CPUS_ON_NODE} --workdir $PWD  < ${chr}
