#!/bin/bash
#SBATCH -n 4
#SBATCH -p EPYC
#SBATCH --time=2:00:00

module load openMPI/4.1.5/gnu

mpirun -np 1 ./gof_mpi -i -k 10000 -n 200 -f init10k.pbm
mpirun -np 1 ./gof_mpi -i -k 14140 -n 200 -f init14k.pbm
mpirun -np 1 ./gof_mpi -i -k 21200 -n 200 -f init21k.pbm
mpirun -np 1 ./gof_mpi -i -k 28300 -n 200 -f init28k.pbm
mpirun -np 1 ./gof_mpi -i -k 35400 -n 200 -f init35k.pbm
mpirun -np 1 ./gof_mpi -i -k 42500 -n 200 -f init42k.pbm
#mpirun -np 1 ./gof_mpi2 -i -k 49500 -n 200 -f init49k.pbm
#mpirun -np 1 ./gof_mpi2 -i -k 56600 -n 200 -f init56k.pbm

exit
