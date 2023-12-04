#!/bin/bash
#SBATCH -n 64 -N 1
#SBATCH -p EPYC
#SBATCH --time=2:00:00

#module load architecture/AMD
module load mkl
module load openBLAS/0.3.23-omp

export OMP_PLACES=cores
export OMP_PROC_BIND=close

echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > mkl_single_close_epyc_v2.csv 
echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > mkl_double_close_epyc_v2.csv 
echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > oblas_single_close_epyc_v2.csv 
echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > oblas_double_close_epyc_v2.csv 

for cores in {1..12..1}
do
    echo -n "$cores, " >> mkl_single_close_epyc_v2.csv
    echo -n "$cores, " >> mkl_double_close_epyc_v2.csv
    echo -n "$cores, " >> oblas_single_close_epyc_v2.csv
    echo -n "$cores, " >> oblas_double_close_epyc_v2.csv

    srun -n1 --cpus-per-task=$cores ../gemm_mkl_float.x 8000 4000 8000 >> mkl_single_close_epyc_v2.csv
    srun -n1 --cpus-per-task=$cores ../gemm_mkl_double.x 8000 4000 8000 >> mkl_double_close_epyc_v2.csv

    srun -n1 --cpus-per-task=$cores ../gemm_oblas_float.x 8000 4000 8000 >> oblas_single_close_epyc_v2.csv
    srun -n1 --cpus-per-task=$cores ../gemm_oblas_double.x 8000 4000 8000 >> oblas_double_close_epyc_v2.csv
done

for cores in {14..64..2}
do
    echo -n "$cores, " >> mkl_single_close_epyc_v2.csv
    echo -n "$cores, " >> mkl_double_close_epyc_v2.csv
    echo -n "$cores, " >> oblas_single_close_epyc_v2.csv
    echo -n "$cores, " >> oblas_double_close_epyc_v2.csv

    srun -n1 --cpus-per-task=$cores ../gemm_mkl_float.x 8000 4000 8000 >> mkl_single_close_epyc_v2.csv
    srun -n1 --cpus-per-task=$cores ../gemm_mkl_double.x 8000 4000 8000 >> mkl_double_close_epyc_v2.csv

    srun -n1 --cpus-per-task=$cores ../gemm_oblas_float.x 8000 4000 8000 >> oblas_single_close_epyc_v2.csv
    srun -n1 --cpus-per-task=$cores ../gemm_oblas_double.x 8000 4000 8000 >> oblas_double_close_epyc_v2.csv
done

exit
