#!/bin/bash
#SBATCH -n 64 -N 1
#SBATCH -p EPYC
#SBATCH --time=1:30:00

#module load architecture/AMD
module load mkl
module load openBLAS/0.3.23-omp

export OMP_PLACES=cores
export OMP_PROC_BIND=spread

echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > mkl_single_spread_epyc_size.csv 
echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > mkl_double_spread_epyc_size.csv 
echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > oblas_single_spread_epyc_size.csv 
echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > oblas_double_spread_epyc_size.csv 

for size in {2000..20000..2000}
do
    echo -n "64, " >> mkl_single_spread_epyc_size.csv
    echo -n "64, " >> mkl_double_spread_epyc_size.csv
    echo -n "64, " >> oblas_single_spread_epyc_size.csv
    echo -n "64, " >> oblas_double_spread_epyc_size.csv

    srun -n1 --cpus-per-task=64 ../gemm_mkl_float.x $size $size $size >> mkl_single_spread_epyc_size.csv
    srun -n1 --cpus-per-task=64 ../gemm_mkl_double.x $size $size $size >> mkl_double_spread_epyc_size.csv

    srun -n1 --cpus-per-task=64 ../gemm_oblas_float.x $size $size $size >> oblas_single_spread_epyc_size.csv
    srun -n1 --cpus-per-task=64 ../gemm_oblas_double.x $size $size $size >> oblas_double_spread_epyc_size.csv
done

for size in {2000..20000..2000}
do
    echo -n "64, " >> mkl_single_spread_epyc_size.csv
    echo -n "64, " >> mkl_double_spread_epyc_size.csv
    echo -n "64, " >> oblas_single_spread_epyc_size.csv
    echo -n "64, " >> oblas_double_spread_epyc_size.csv

    srun -n1 --cpus-per-task=64 ../gemm_mkl_float.x $size 10000 $size >> mkl_single_spread_epyc_size.csv
    srun -n1 --cpus-per-task=64 ../gemm_mkl_double.x $size 10000 $size >> mkl_double_spread_epyc_size.csv

    srun -n1 --cpus-per-task=64 ../gemm_oblas_float.x $size 10000 $size >> oblas_single_spread_epyc_size.csv
    srun -n1 --cpus-per-task=64 ../gemm_oblas_double.x $size 10000 $size >> oblas_double_spread_epyc_size.csv
done