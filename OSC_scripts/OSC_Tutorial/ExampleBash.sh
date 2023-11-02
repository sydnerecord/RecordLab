#!/bin/bash

#SBATCH --job-name=regressionexample
#SBATCH --cpus-per-task=6
#SBATCH --time=24:00:00
#SBATCH --mem=4gb 
#SBATCH --mail-user=sydne.record@maine.edu
#SBATCH --mail-type=END
#SBATCH --account=PUOM0017

module load R/4.3.0-gnu11.2
     
cp /users/PUOM0017/srecord/ExampleData/MultipleRegressionExample.R $TMPDIR
cd $TMPDIR
     
R CMD BATCH MultipleRegressionExample.R test.Rout
     
cp test.Rout $SLURM_SUBMIT_DIR
