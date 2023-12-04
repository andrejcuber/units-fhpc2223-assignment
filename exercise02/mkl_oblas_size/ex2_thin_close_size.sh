#!/bin/bash
#SBATCH -n 12 -N 1
#SBATCH -p THIN
#SBATCH --time=1:30:00

#module load architecture/AMD
module load mkl
module load openBLAS/0.3.23-omp

export OMP_PLACES=cores
export OMP_PROC_BIND=close

echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > mkl_single_close_thin_size.csv 
echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > mkl_double_close_thin_size.csv 
echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > oblas_single_close_thin_size.csv 
echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > oblas_double_close_thin_size.csv 

for size in {2000..20000..2000}
do
    echo -n "12, " >> mkl_single_close_thin_size.csv
    echo -n "12, " >> mkl_double_close_thin_size.csv
    echo -n "12, " >> oblas_single_close_thin_size.csv
    echo -n "12, " >> oblas_double_close_thin_size.csv

    srun -n1 --cpus-per-task=12 ../gemm_mkl_float.x $size $size $size >> mkl_single_close_thin_size.csv
    srun -n1 --cpus-per-task=12 ../gemm_mkl_double.x $size $size $size >> mkl_double_close_thin_size.csv

    srun -n1 --cpus-per-task=12 ../gemm_oblas_float.x $size $size $size >> oblas_single_close_thin_size.csv
    srun -n1 --cpus-per-task=12 ../gemm_oblas_double.x $size $size $size >> oblas_double_close_thin_size.csv
done

for size in {2000..20000..2000}
do
    echo -n "12, " >> mkl_single_close_thin_size.csv
    echo -n "12, " >> mkl_double_close_thin_size.csv
    echo -n "12, " >> oblas_single_close_thin_size.csv
    echo -n "12, " >> oblas_double_close_thin_size.csv

    srun -n1 --cpus-per-task=12 ../gemm_mkl_float.x $size 10000 $size >> mkl_single_close_thin_size.csv
    srun -n1 --cpus-per-task=12 ../gemm_mkl_double.x $size 10000 $size >> mkl_double_close_thin_size.csv

    srun -n1 --cpus-per-task=12 ../gemm_oblas_float.x $size 10000 $size >> oblas_single_close_thin_size.csv
    srun -n1 --cpus-per-task=12 ../gemm_oblas_double.x $size 10000 $size >> oblas_double_close_thin_size.csv
done
