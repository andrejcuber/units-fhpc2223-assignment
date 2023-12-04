#!/bin/bash
#SBATCH -n 384 -N 3
#SBATCH -p EPYC
#SBATCH --time=2:00:00

module load openMPI/4.1.5/gnu

export OMP_NUM_THREADS=64

echo "weak ordered"
export OMP_NUM_THREADS=62
mpirun -np 1 --map-by node --bind-to socket ./gof2 -r -k 10000 -n 200 -f init10k.pbm -e 0 -s 200
mpirun -np 2 --map-by node --bind-to socket ./gof2 -r -k 14140 -n 200 -f init14k.pbm -e 0 -s 200
mpirun -np 3 --map-by node --bind-to socket ./gof2 -r -k 21200 -n 200 -f init21k.pbm -e 0 -s 200
mpirun -np 4 --map-by node --bind-to socket ./gof2 -r -k 28300 -n 200 -f init28k.pbm -e 0 -s 200
mpirun -np 5 --map-by node --bind-to socket ./gof2 -r -k 35400 -n 200 -f init35k.pbm -e 0 -s 200
mpirun -np 6 --map-by node --bind-to socket ./gof2 -r -k 42500 -n 200 -f init42k.pbm -e 0 -s 200
#mpirun -np 7 --map-by ppr:1:socket ./gof2 -r -k 49500 -n 200 -f init49k.pbm -e 0 -s 200
#export OMP_NUM_THREADS=496
#mpirun -np 8 --map-by ppr:1:socket ./gof2 -r -k 56600 -n 200 -f init56k.pbm -e 0 -s 200

echo "weak static"
mpirun -np 1 --map-by node --bind-to socket ./gof2 -r -k 10000 -n 200 -f init10k.pbm -e 1 -s 200
mpirun -np 2 --map-by node --bind-to socket ./gof2 -r -k 14140 -n 200 -f init14k.pbm -e 1 -s 200
mpirun -np 3 --map-by node --bind-to socket ./gof2 -r -k 21200 -n 200 -f init21k.pbm -e 1 -s 200
mpirun -np 4 --map-by node --bind-to socket ./gof2 -r -k 28300 -n 200 -f init28k.pbm -e 1 -s 200
mpirun -np 5 --map-by node --bind-to socket ./gof2 -r -k 35400 -n 200 -f init35k.pbm -e 1 -s 200
mpirun -np 6 --map-by node --bind-to socket ./gof2 -r -k 42500 -n 200 -f init42k.pbm -e 1 -s 200
#mpirun -np 7 --map-by ppr:1:socket ./gof2 -r -k 49500 -n 200 -f init49k.pbm -e 1 -s 200
#export OMP_NUM_THREADS=496
#mpirun -np 8 --map-by ppr:1:socket ./gof2 -r -k 56600 -n 200 -f init56k.pbm -e 1 -s 200
exit