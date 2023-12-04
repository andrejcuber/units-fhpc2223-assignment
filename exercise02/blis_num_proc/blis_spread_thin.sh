#!/bin/bash
#SBATCH -n 12 -N 1
#SBATCH -p THIN
#SBATCH --time=2:00:00

module load mkl
module load openBLAS/0.3.23-omp

export LD_LIBRARY_PATH=/u/dssc/acuber00/final_project/ex2/blis/lib:$LD_LIBRARY_PATH

export OMP_PLACES=cores
export OMP_PROC_BIND=spread

echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > blis_single_spread_thin.csv 
echo "cores, sizeM, sizeN, sizeK, time[s],gflops" > blis_double_spread_thin.csv 

for cores in {1..12..1}
do
	export BLIS_NUM_THREADS=$cores
	echo -n "$cores, " >> blis_single_spread_thin.csv
	echo -n "$cores, " >> blis_double_spread_thin.csv
	./gemm_blis_float.x 9000 9000 9000 >> blis_single_spread_thin.csv
	./gemm_blis_double.x 9000 9000 9000 >> blis_double_spread_thin.csv
done

for cores in {14..64..2}
do
	export BLIS_NUM_THREADS=$cores
	echo -n "$cores, " >> blis_single_spread_thin.csv
	echo -n "$cores, " >> blis_double_spread_thin.csv
	./gemm_blis_float.x 9000 9000 9000 >> blis_single_spread_thin.csv
	./gemm_blis_double.x 9000 9000 9000 >> blis_double_spread_thin.csv
done

#for cores in {56..128..4}
#do
#	export BLIS_NUM_THREADS=$cores
#	echo -n "$cores, " >> blis_single_spread_epyc.csv
#	echo -n "$cores, " >> blis_double_spread_epyc.csv
#	./gemm_blis_float.x 9000 9000 9000 >> blis_single_spread_epyc.csv
#	./gemm_blis_double.x 9000 9000 9000 >> blis_double_spread_epyc.csvdone
#done

exit
