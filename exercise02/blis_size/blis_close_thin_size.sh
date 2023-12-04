#!/bin/bash
#SBATCH -n 12 -N 1
#SBATCH -p THIN
#SBATCH --time=1:30:00

#module load architecture/AMD
module load mkl
module load openBLAS/0.3.23-omp

export LD_LIBRARY_PATH=/u/dssc/acuber00/final_project/ex2/blis/lib:$LD_LIBRARY_PATH

export OMP_PLACES=cores
export OMP_PROC_BIND=close

echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > blis_single_close_thin_size.csv 
echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > blis_double_close_thin_size.csv 

for size in {2000..20000..2000}
do
	export BLIS_NUM_THREADS=12
	echo -n "12, " >> blis_single_close_thin_size.csv
	echo -n "12, " >> blis_double_close_thin_size.csv

	./gemm_blis_float.x $size $size $size >> blis_single_close_thin_size.csv
	./gemm_blis_double.x $size $size $size >> blis_double_close_thin_size.csv
done

for size in {2000..20000..2000}
do
	export BLIS_NUM_THREADS=12
	echo -n "12, " >> blis_single_close_thin_size.csv
	echo -n "12, " >> blis_double_close_thin_size.csv

	./gemm_blis_float.x $size 10000 $size >> blis_single_close_thin_size.csv
	./gemm_blis_double.x $size 10000 $size >> blis_double_close_thin_size.csv
done