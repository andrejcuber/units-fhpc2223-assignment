#!/bin/bash
#SBATCH -n 64 -N 1
#SBATCH -p EPYC
#SBATCH --time=1:30:00

#module load architecture/AMD
module load mkl
module load openBLAS/0.3.23-omp

#export LD_LIBRARY_PATH=/u/dssc/acuber00/final_project/ex2/blis/lib:$LD_LIBRARY_PATH

echo "Part 1: increasing size"
echo "mkl float"
srun -n1 --cpus-per-task=64 ./gemm_mkl_float.x 2000 10000 2000
srun -n1 --cpus-per-task=64 ./gemm_mkl_float.x 4000 10000 4000
srun -n1 --cpus-per-task=64 ./gemm_mkl_float.x 6000 10000 6000
srun -n1 --cpus-per-task=64 ./gemm_mkl_float.x 8000 10000 8000
srun -n1 --cpus-per-task=64 ./gemm_mkl_float.x 10000 10000 10000
srun -n1 --cpus-per-task=64 ./gemm_mkl_float.x 12000 10000 12000
srun -n1 --cpus-per-task=64 ./gemm_mkl_float.x 14000 10000 14000
srun -n1 --cpus-per-task=64 ./gemm_mkl_float.x 16000 10000 16000
srun -n1 --cpus-per-task=64 ./gemm_mkl_float.x 18000 10000 18000
srun -n1 --cpus-per-task=64 ./gemm_mkl_float.x 20000 10000 20000
srun -n1 --cpus-per-task=64 ./gemm_mkl_float.x 32000 10000 32000
#srun -n1 --cpus-per-task=64 ./gemm_mkl2.x 64000 1000 64000
#srun -n1 --cpus-per-task=64 ./gemm_mkl2.x 20000 20000 10000

echo "oblas float"
srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 2000 10000 2000
srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 4000 10000 4000
srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 6000 10000 6000
srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 8000 10000 8000
srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 10000 10000 10000
srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 12000 10000 12000
srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 14000 10000 14000
srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 16000 10000 16000
srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 18000 10000 18000
srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 20000 10000 20000
srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 32000 10000 32000
#srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 64000 1000 64000
#srun -n1 --cpus-per-task=64 ./gemm_oblas_float.x 20000 20000 10000

echo "blis float"
srun -n1 --cpus-per-task=64 ./gemm_blis_float.x 2000 10000 2000
srun -n1 --cpus-per-task=64 ./gemm_blis_float.x 4000 10000 4000
srun -n1 --cpus-per-task=64 ./gemm_blis_float.x 6000 10000 6000
srun -n1 --cpus-per-task=64 ./gemm_blis_float.x 8000 10000 8000
srun -n1 --cpus-per-task=64 ./gemm_blis_float.x 10000 10000 10000
srun -n1 --cpus-per-task=64 ./gemm_blis_float.x 12000 10000 12000
srun -n1 --cpus-per-task=64 ./gemm_blis_float.x 14000 10000 14000
srun -n1 --cpus-per-task=64 ./gemm_blis_float.x 16000 10000 16000
srun -n1 --cpus-per-task=64 ./gemm_blis_float.x 18000 10000 18000
srun -n1 --cpus-per-task=64 ./gemm_blis_float.x 20000 10000 20000
srun -n1 --cpus-per-task=64 ./gemm_blis_float.x 32000 10000 32000

echo "mkl double"
srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 2000 10000 2000
srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 4000 10000 4000
srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 6000 10000 6000
srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 8000 10000 8000
srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 10000 10000 10000
srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 12000 10000 12000
srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 14000 10000 14000
srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 16000 10000 16000
srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 18000 10000 18000
srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 20000 10000 20000
srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 32000 10000 32000
#srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 64000 1000 64000
#srun -n1 --cpus-per-task=64 ./gemm_mkl_double.x 20000 20000 10000

echo "oblas double"
srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 2000 10000 2000
srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 4000 10000 4000
srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 6000 10000 6000
srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 8000 10000 8000
srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 10000 10000 10000
srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 12000 10000 12000
srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 14000 10000 14000
srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 16000 10000 16000
srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 18000 10000 18000
srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 20000 10000 20000
srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 32000 10000 32000
#srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 64000 1000 64000
#srun -n1 --cpus-per-task=64 ./gemm_oblas_double.x 20000 20000 10000

echo "blis double"
srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 2000 10000 2000
srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 4000 10000 4000
srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 6000 10000 6000
srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 8000 10000 8000
srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 10000 10000 10000
srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 12000 10000 12000
srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 14000 10000 14000
srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 16000 10000 16000
srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 18000 10000 18000
srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 20000 10000 20000
srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 32000 10000 32000
#srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 64000 1000 64000
#srun -n1 --cpus-per-task=64 ./gemm_blis_double.x 20000 20000 10000
