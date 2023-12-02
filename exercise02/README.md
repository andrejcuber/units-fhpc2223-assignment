# Exercise 02

## Objectives:
The goal of this exercise was to get familiar with performance of various math libraries that are used in high performance computing (mkl, openBLAS and BLIS).

We had to benchmark processor used in cluster with various libraries, precision and dimensions and compare it to the peak power of processor.

## Files:
Files that you find in this folder are:
- shell scripts that I used to submit via sbatch command,
- makefile that I used to compile the executables (needs path to blis library),
- modified dgemm.c file (that was provided to us); I removed some prints to make it more compact, but I still needed quite a bit of effort to clean data to the point I could use it,
- a sl_batch.sh script that sbatch-es all three files on its own