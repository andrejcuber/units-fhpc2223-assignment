#!/bin/bash
#SBATCH -n 256 -N 2
#SBATCH -p EPYC
#SBATCH --time=2:00:00

module load openMPI/4.1.5/gnu

echo "ordered"
echo "MPI+openMP, ntasks=4"
srun --ntasks=4 --cpus-per-task=20 ./gof -i -k 4000 -n 2000 -f hybrid_init.pbm -e 0
echo "MPI+openMP, threads=1"
time srun --ntasks=4 --cpus-per-task=1 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=2"
time srun --ntasks=4 --cpus-per-task=2 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=3"
time srun --ntasks=4 --cpus-per-task=3 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=4"
time srun --ntasks=4 --cpus-per-task=4 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=6"
time srun --ntasks=4 --cpus-per-task=6 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=8"
time srun --ntasks=4 --cpus-per-task=8 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=10"
time srun --ntasks=4 --cpus-per-task=10 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=12"
time srun --ntasks=4 --cpus-per-task=12 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=14"
time srun --ntasks=4 --cpus-per-task=14 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=16"
time srun --ntasks=4 --cpus-per-task=16 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=20"
time srun --ntasks=4 --cpus-per-task=20 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=24"
time srun --ntasks=4 --cpus-per-task=24 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=28"
time srun --ntasks=4 --cpus-per-task=28 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=32"
time srun --ntasks=4 --cpus-per-task=32 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=36"
time srun --ntasks=4 --cpus-per-task=36 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=40"
time srun --ntasks=4 --cpus-per-task=40 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=48"
time srun --ntasks=4 --cpus-per-task=48 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=56"
time srun --ntasks=4 --cpus-per-task=56 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000
echo "MPI+openMP, threads=62"
time srun --ntasks=4 --cpus-per-task=62 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 0 -s 2000

echo "static"
echo "MPI+openMP, ntasks=4"
#srun --ntasks=4 --cpus-per-task=20 ./gof -i -k 4000 -n 2000 -f hybrid_init.pbm -e 1
echo "MPI+openMP, threads=1"
time srun --ntasks=4 --cpus-per-task=1 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=2"
time srun --ntasks=4 --cpus-per-task=2 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=3"
time srun --ntasks=4 --cpus-per-task=3 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=4"
time srun --ntasks=4 --cpus-per-task=4 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=6"
time srun --ntasks=4 --cpus-per-task=6 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=8"
time srun --ntasks=4 --cpus-per-task=8 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=10"
time srun --ntasks=4 --cpus-per-task=10 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=12"
time srun --ntasks=4 --cpus-per-task=12 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=14"
time srun --ntasks=4 --cpus-per-task=14 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=16"
time srun --ntasks=4 --cpus-per-task=16 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=20"
time srun --ntasks=4 --cpus-per-task=20 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=24"
time srun --ntasks=4 --cpus-per-task=24 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=28"
time srun --ntasks=4 --cpus-per-task=28 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=32"
time srun --ntasks=4 --cpus-per-task=32 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=36"
time srun --ntasks=4 --cpus-per-task=36 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=40"
time srun --ntasks=4 --cpus-per-task=40 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=48"
time srun --ntasks=4 --cpus-per-task=48 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=56"
time srun --ntasks=4 --cpus-per-task=56 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000
echo "MPI+openMP, threads=62"
time srun --ntasks=4 --cpus-per-task=62 ./gof -r -k 4000 -n 2000 -f hybrid_init.pbm -e 1 -s 2000


exit
