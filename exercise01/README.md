# Exercise 01

## Objectives:
Program an application of Conways Game of life in parallel, using a hybrid MPI + openMP approach, and measure its performance and scaling on HPC cluster. 

## Files:
Files that yo ufind in this folder are:
- report_data, containing all graphs and relevant outputs when executing the game
- snapshots, folder that contains two sample .pbm files (smaller than the ones used in computation)
- shell scripts named "ex1*.sh" that were used to submit jobs to SLURM
- shell script "weak_create_init.sh" that creates the necessary files for weak scaling
- shell script named compile.sh that compiles and creates the runnable files used in the ex1* scripts
- game_of_life.c: my algorithm or solution to the asked problem.