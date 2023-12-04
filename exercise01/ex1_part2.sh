#!/bin/bash
#SBATCH -n 256 -N 2
#SBATCH -p EPYC
#SBATCH --time=2:00:00

module load openMPI/4.1.5/gnu

echo "ordered"
echo "MPI+openMP, ntasks=4"
srun --ntasks=4 --cpus-per-task=20 ./gof2 -i -k 10000 -n 200 -f hybrid_init10k.pbm -e 0
echo "MPI+openMP, threads=1"
srun --ntasks=4 --cpus-per-task=1 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=2"
srun --ntasks=4 --cpus-per-task=2 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=3"
srun --ntasks=4 --cpus-per-task=3 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=4"
srun --ntasks=4 --cpus-per-task=4 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=6"
srun --ntasks=4 --cpus-per-task=6 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=8"
srun --ntasks=4 --cpus-per-task=8 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=10"
srun --ntasks=4 --cpus-per-task=10 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=12"
srun --ntasks=4 --cpus-per-task=12 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=14"
srun --ntasks=4 --cpus-per-task=14 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=16"
srun --ntasks=4 --cpus-per-task=16 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=20"
srun --ntasks=4 --cpus-per-task=20 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=24"
srun --ntasks=4 --cpus-per-task=24 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=28"
srun --ntasks=4 --cpus-per-task=28 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=32"
srun --ntasks=4 --cpus-per-task=32 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=36"
srun --ntasks=4 --cpus-per-task=36 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=40"
srun --ntasks=4 --cpus-per-task=40 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=48"
srun --ntasks=4 --cpus-per-task=48 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=56"
srun --ntasks=4 --cpus-per-task=56 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200
echo "MPI+openMP, threads=62"
srun --ntasks=4 --cpus-per-task=62 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 0 -s 200

echo "static"
echo "MPI+openMP, ntasks=4"
#srun --ntasks=4 --cpus-per-task=20 ./gof -i -k 4000 -n 2000 -f hybrid_init.pbm -e 1
echo "MPI+openMP, threads=1"
srun --ntasks=4 --cpus-per-task=1 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=2"
srun --ntasks=4 --cpus-per-task=2 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=3"
srun --ntasks=4 --cpus-per-task=3 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=4"
srun --ntasks=4 --cpus-per-task=4 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=6"
srun --ntasks=4 --cpus-per-task=6 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=8"
srun --ntasks=4 --cpus-per-task=8 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=10"
srun --ntasks=4 --cpus-per-task=10 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=12"
srun --ntasks=4 --cpus-per-task=12 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=14"
srun --ntasks=4 --cpus-per-task=14 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=16"
srun --ntasks=4 --cpus-per-task=16 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=20"
srun --ntasks=4 --cpus-per-task=20 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=24"
srun --ntasks=4 --cpus-per-task=24 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=28"
srun --ntasks=4 --cpus-per-task=28 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=32"
srun --ntasks=4 --cpus-per-task=32 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=36"
srun --ntasks=4 --cpus-per-task=36 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=40"
srun --ntasks=4 --cpus-per-task=40 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=48"
srun --ntasks=4 --cpus-per-task=48 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=56"
srun --ntasks=4 --cpus-per-task=56 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200
echo "MPI+openMP, threads=62"
srun --ntasks=4 --cpus-per-task=62 ./gof2 -r -k 10000 -n 200 -f hybrid_init10k.pbm -e 1 -s 200


exit
