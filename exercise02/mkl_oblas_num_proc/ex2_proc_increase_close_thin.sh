#!/bin/bash
#SBATCH -n 12 -N 1
#SBATCH -p THIN --nodelist=thin002
#SBATCH --time=2:00:00

#module load architecture/AMD
module load mkl
module load openBLAS/0.3.23-omp

export OMP_PLACES=cores
export OMP_PROC_BIND=close

echo "cores,sizeM,sizeN,sizeK,time[s],gflops" > mkl_single_close_thin.csv 
echo "cores,sizeM,sizeN,sizeK,time[s],gflops" > mkl_double_close_thin.csv 
echo "cores,sizeM,sizeN,sizeK,time[s],gflops" > oblas_single_close_thin.csv 
echo "cores,sizeM,sizeN,sizeK,time[s],gflops" > oblas_double_close_thin.csv 

for cores in {1..12..1}
do
    echo -n "$cores," >> mkl_single_close_thin.csv
    echo -n "$cores," >> mkl_double_close_thin.csv
    echo -n "$cores," >> oblas_single_close_thin.csv
    echo -n "$cores," >> oblas_double_close_thin.csv

    echo "mkl float close $cores\n"
    srun -n1 --cpus-per-task=$cores ../gemm_mkl_float.x 9000 9000 9000 >> mkl_single_close_thin.csv
    echo "mkl double close $cores\n"
    srun -n1 --cpus-per-task=$cores ../gemm_mkl_double.x 9000 9000 9000 >> mkl_double_close_thin.csv

    echo "oblas float close $cores\n"
    srun -n1 --cpus-per-task=$cores ../gemm_oblas_float.x 9000 9000 9000 >> oblas_single_close_thin.csv
    echo "oblas double close $cores\n"
    srun -n1 --cpus-per-task=$cores ../gemm_oblas_double.x 9000 9000 9000 >> oblas_double_close_thin.csv
done

#for cores in {20..36..2}
#do
#    echo -n "$cores, " >> mkl_single_close_thin.csv
#    echo -n "$cores, " >> mkl_double_close_thin.csv
#    echo -n "$cores, " >> oblas_single_close_thin.csv
#    echo -n "$cores, " >> oblas_double_close_thin.csv

#    srun -n1 --cpus-per-task=$cores ../gemm_mkl_float.x 9000 9000 9000 >> mkl_single_close_thin.csv
#    srun -n1 --cpus-per-task=$cores ../gemm_mkl_double.x 9000 9000 9000 >> mkl_double_close_thin.csv

#    srun -n1 --cpus-per-task=$cores ../gemm_oblas_float.x 9000 9000 9000 >> oblas_single_close_thin.csv
#    srun -n1 --cpus-per-task=$cores ../gemm_oblas_double.x 9000 9000 9000 >> oblas_double_close_thin.csv
#done

exit
