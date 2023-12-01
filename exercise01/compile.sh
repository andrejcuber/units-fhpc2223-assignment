module load openMPI/4.1.5/gnu

mpicc game_of_life.c -o gof_mpi
mpicc fopenmp game_of_life.c -o gof
