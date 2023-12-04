# Exercise 02

## Objectives:
The goal of this exercise was to get familiar with performance of various math libraries that are used in high performance computing (mkl, openBLAS and BLIS).

We had to benchmark processor used in cluster with various libraries, precision and dimensions and compare it to the peak power of processor.

## Files:
Files that you find in this folder are:
- five folders, its name corresponding to the name of the function that was tested on ORFEO. After the name of the function follows the exercise that I had to execute, either make measurement for increasing number of processor (denoted as *_num_proc) or increasing the size of the matrix (denoted as *_size). Output_data contains graphs and cleaned data that I used to create graphs.
- In those four function folders, you'll get the programs output and the shell scripts that were used to submit jobs to SLURM.
- There is also dgemm.c file, that was modified to output cleaner data and its makefile.