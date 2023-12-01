#!/bin/bash
#SBATCH -n 256 -N 2
#SBATCH -p EPYC
#SBATCH --time=2:00:00

module load openMPI/4.1.5/gnu

echo "MPI ordered"
mpirun -np 1 ./gof_mpi -i -k 4000 -n 2000 -f init.pbm
time mpirun -np 1 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 2 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 3 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 4 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 5 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 6 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 7 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 8 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 10 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 12 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 14 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 16 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 20 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 24 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 28 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 32 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 40 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 48 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 56 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 64 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 72 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 80 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 88 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 96 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 104 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 112 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 120 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 128 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 144 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 160 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 176 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 192 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 208 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 224 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 240 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000
time mpirun -np 256 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 0 -s 2000

echo "MPI static"
#mpirun -np 1 gof_mpi -i -k 4000 -n 2000 -f init.pbm
time mpirun -np 1 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 2 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 3 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 4 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 5 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 6 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 7 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 8 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 10 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 12 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 14 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 16 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 20 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 24 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 28 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 32 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 40 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 48 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 56 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 64 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 72 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 80 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 88 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 96 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 104 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 112 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 120 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 128 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 144 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 160 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 176 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 192 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 208 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 224 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 240 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000
time mpirun -np 256 ./gof_mpi -r -k 4000 -n 2000 -f init.pbm -e 1 -s 2000

exit
