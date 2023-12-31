#include "/opt/homebrew/opt/open-mpi/include/mpi.h" //used for local developing on M1 mac
#include "/opt/homebrew/opt/libomp/include/omp.h" //used for local developing on M1 mac
//#include <mpi.h>
//#include <omp.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <getopt.h>
#include <time.h>

//Hybrid definition:
#ifdef MPI_OPENMP
#define MPI_OPENMP 1
#endif

/*Global (passed) arguments:*/
#define INIT 1
#define RUN  2
#define K_DFLT 100
#define ORDERED 0
#define STATIC  1

char fname_deflt[] = "game_of_life.pgm";
char path_deftl[] = "./snapshots";

int   action = 0;
int   k      = K_DFLT; //size_of the playground
int   kx     = K_DFLT;
int   ky     = K_DFLT;
int   e      = ORDERED;
int   n      = 100; // number of steps
int num_thread = 0;
int   s      = 1; //file savings
char *fname  = NULL; //name of the file
char *path = NULL; //Path to folder where we will save snapshots

char** allocate_memory(int rows, int cols){
    int i;
    char *data = malloc(rows*cols*sizeof(char));
    char** arr = malloc(rows*sizeof(char *));
    for (i=0; i<rows; i++){
        arr[i] = &(data[i*cols]);
    }

    return arr;
}

void generate_initial_image(char** initial_grid, int x, int y){
    int table_size = 2;
    const char available_char[] = {'1', '0'};
    //global_grid = allocate_memory(x, y);

    srand(time(NULL));
    //#pragma omp for
    for (int ii = 0; ii < x;ii++){
        for (int jj = 0; jj < y; jj++){
            initial_grid[ii][jj] = available_char[rand() % table_size];
        }
    }
}

void write_pgm_image( void *image, int maxval, int xsize, int ysize, const char *image_name)
/*
 * image        : a pointer to the memory region that contains the image
 * maxval       : either 255 or 65536
 * xsize, ysize : x and y dimensions of the image
 * image_name   : the name of the file to be written
 *
 */
{
  FILE* image_file; 
  image_file = fopen(image_name, "w"); 
  
  // Writing header
  // The header's format is as follows, all in ASCII.
  // "whitespace" is either a blank or a TAB or a CF or a LF
  // - The Magic Number (see below the magic numbers)
  // - the image's width
  // - the height
  // - a white space
  // - the image's height
  // - a whitespace
  // - the maximum color value, which must be between 0 and 65535
  //
  // if he maximum color value is in the range [0-255], then
  // a pixel will be expressed by a single byte; if the maximum is
  // larger than 255, then 2 bytes will be needed for each pixel
  //

  int color_depth = 1 + ( maxval > 255 );

  fprintf(image_file, "P1\n# generated by\n# Andrej Cuber\n%d %d\n%d\n", xsize, ysize, maxval);
  
  // Writing file
  fwrite( image, 1, xsize*ysize*color_depth, image_file);  

  fclose(image_file); 
  return ;

  /* ---------------------------------------------------------------

     TYPE    MAGIC NUM     EXTENSION   COLOR RANGE
           ASCII  BINARY

     PBM   P1     P4       .pbm        [0-1]
     PGM   P2     P5       .pgm        [0-255]
     PPM   P3     P6       .ppm        [0-2^16[
  
  ------------------------------------------------------------------ */
}

void read_pgm_image( char **image, int *maxval, int *xsize, int *ysize, const char *image_name)
/*
 * image        : a pointer to the pointer that will contain the image
 * maxval       : a pointer to the int that will store the maximum intensity in the image
 * xsize, ysize : pointers to the x and y sizes
 * image_name   : the name of the file to be read
 *
 */
{
  FILE* image_file; 
  image_file = fopen(image_name, "r");
  

  *image = NULL;
  *xsize = *ysize = *maxval = 0;
  
  char    MagicN[3];
  char   *line = NULL;
  size_t  k, n = 0;
  
  // get the Magic Number
  k = fscanf(image_file, "%2s%*c", MagicN );
  
  // skip all the comments
  k = getline( &line, &n, image_file);
  while ( (k > 0) && (line[0]=='#') )
    k = getline( &line, &n, image_file);

  if (k > 0)
    {
      k = sscanf(line, "%d%*c%d%*c%d%*c", xsize, ysize, maxval);
      if ( k < 3 )
	fscanf(image_file, "%d%*c", maxval);
    }
  else
    {
      *maxval = -1;         // this is the signal that there was an I/O error
			    // while reading the image header
      free( line );
      return;
    }
  free( line );
  
  int color_depth = 1 + ( *maxval > 255 );
  unsigned int size = *xsize * *ysize * color_depth;
  //printf("xsize: %d, ysize: %d, max_val %d\n", *xsize, *ysize, *maxval);


  if ( (*image = (char*)malloc( size )) == NULL )
    {
      fclose(image_file);
      *maxval = -2;         // this is the signal that memory was insufficient
      *xsize  = 0;
      *ysize  = 0;
      return;
    }
  
  if ( fread( *image, 1, size, image_file) != size )
    {
      free( image );
      image   = NULL;
      *maxval = -3;         // this is the signal that there was an i/o error
      *xsize  = 0;
      *ysize  = 0;
    }  
    
  fclose(image_file);
  return;
}

void write_pbm_parallel(int r_id, char* file_name, char** array, int counts, int* displac){
    MPI_File fhandle;
    MPI_Status stat;
    //int offs = displac[r_id];
    int acc_mode, check = 0;

    if (r_id == 0){
        char* header = (char *)malloc(50*sizeof(char));
    
        //sprintf(header, "P1\n# generated by\n# Andrej Cuber\n%d %d\n1\n", kx, ky);
        sprintf(header, "P4 %d %d\n%d\n", kx, ky, 1);
        
        acc_mode = MPI_MODE_CREATE | MPI_MODE_WRONLY;

        check += MPI_File_open(MPI_COMM_SELF, file_name, acc_mode, MPI_INFO_NULL, &fhandle);
        check += MPI_File_write_at(fhandle, 0, header, 70, MPI_CHAR, &stat);
        check += MPI_File_close(&fhandle);

        if (check != 0){
            printf("Problem writting header \n");
            check = 0;
        }        
    }
    //check += MPI_File_seek(fhandle, offs, MPI_SEEK_SET);
    MPI_Barrier(MPI_COMM_WORLD);
    acc_mode = MPI_MODE_WRONLY | MPI_MODE_APPEND;
    check += MPI_File_open(MPI_COMM_SELF, file_name, acc_mode, MPI_INFO_NULL, &fhandle);
    check += MPI_File_write_all(fhandle, &(array[0][0]), counts, MPI_CHAR, &stat);
    //check += MPI_File_write_at_all(fhandle, offs, &(array[0][0]), counts, MPI_CHAR, &stat);
    check += MPI_Barrier(MPI_COMM_WORLD);
    check += MPI_File_close(&fhandle);

    if(check!= 0){
        printf("Error writting file: %s\n", file_name);
    }
}

void calculate_workload(int *num_row_per_process, int num_proc, int grid_size){
    for (int i = 0; i<num_proc;i++){
        num_row_per_process[i] = grid_size/num_proc;
    }
    for (int i = 0; i<(grid_size%num_proc); i++){
        num_row_per_process[i]++;
    }
}

int game_rules(char** prev_gen, char** next_gen, int i, int j, int al_neigh){
    int changed = 0;

    if (prev_gen[i][j] == '1'){
        if (al_neigh != 2 && al_neigh != 3){
            next_gen[i][j] = '0';
            changed = 1;
        }
        else {
            next_gen[i][j] = '1';
        }
    }
    else{
        if (al_neigh == 3){
            next_gen[i][j] = '1';
            changed = 1;
        }
        else{
            next_gen[i][j] = '0';
        }
    }
    return changed;
}

int evolve_inner(char** prev_gen, char** next_gen, int nrows, int ncols){
    int changed = 0;

    #pragma omp parallel for collapse(2) schedule(static)
    for (int i = 1; i<nrows-1; i++){
        for (int j = 1; j<ncols-1; j++) {
            int neigh = (prev_gen[i-1][j-1] == '1') + (prev_gen[i-1][j] == '1') + (prev_gen[i-1][j+1] == '1') + (prev_gen[i][j-1] == '1') + (prev_gen[i][j+1] == '1') + (prev_gen[i+1][j-1] == '1') + (prev_gen[i+1][j] == '1') + (prev_gen[i+1][j+1] == '1');

            if (game_rules(prev_gen, next_gen, i, j, neigh) == 1){
                changed = 1;
            }
        }
    }
    return changed;
}

int evolve_outer(char** prev_gen, char** next_gen, char* top_row, char* bottom_row, int nrows, int ncols){
    int changed = 0;
    int neigh;

    //First row:
    #pragma omp parallel for schedule(static)
    for (int j=1; j < ncols-1; j++){
        int i = 0;
        neigh = (prev_gen[i][j-1] == '1') + (prev_gen[i][j+1] == '1') + (prev_gen[i+1][j-1] == '1') + (prev_gen[i+1][j] == '1') + (prev_gen[i+1][j+1] == '1') + (top_row[j-1] == '1') + (top_row[j] == '1') + (top_row[j+1] == '1');

        if (game_rules(prev_gen, next_gen, i, j, neigh) == 1){
            changed = 1;
        }
    }

    //last_row:
    #pragma omp parallel for schedule(static)
    for (int j=1; j < ncols-1; j++){
        int i = nrows-1; //num row == 20, last row position is 19;
        neigh = (prev_gen[i-1][j-1] == '1') + (prev_gen[i-1][j] == '1') + (prev_gen[i-1][j+1] == '1') + (prev_gen[i][j-1] == '1') + (prev_gen[i][j+1] == '1') + (bottom_row[j-1] == '1') + (bottom_row[j] == '1') + (bottom_row[j+1] == '1');

        if (game_rules(prev_gen, next_gen, i, j, neigh) == 1){
            changed = 1;
        }
    }

    //first column:
    #pragma omp parallel for schedule(static)
    for (int i = 1; i < nrows-1; i++){
        int j = 0;
        neigh = (prev_gen[i][j+1] == '1') + (prev_gen[i-1][j+1] =='1') + (prev_gen[i-1][j] =='1') + (prev_gen[i-1][ncols-1] == '1') + (prev_gen[i][ncols-1] == '1') + (prev_gen[i+1][ncols-1] == '1') + (prev_gen[i+1][j] == '1') + (prev_gen[i+1][j+1] == '1');

        if (game_rules(prev_gen, next_gen, i, j, neigh) == 1){
            changed = 1;
        }
    }

    //last column:
    #pragma omp parallel for schedule(static)
    for (int i = 1; i< nrows-1; i++){
        int j = ncols-1;
        neigh = (prev_gen[i][0] == '1') + (prev_gen[i-1][0] == '1') + (prev_gen[i-1][j] =='1') + (prev_gen[i-1][j-1] == '1') + (prev_gen[i][j-1] == '1') + (prev_gen[i+1][j-1] == '1') + (prev_gen[i+1][j] == '1') + (prev_gen[i+1][0] == '1');

        if (game_rules(prev_gen, next_gen, i, j, neigh)==1) {
            changed = 1;
        } 
    }

    //top left:
    int i = 0, j = 0;
    neigh = (prev_gen[i][j+1] == '1') + (prev_gen[i+1][j+1] == '1') + (prev_gen[i+1][j] == '1') + (prev_gen[i+1][ncols-1] == '1') + (prev_gen[i][ncols-1] == '1') + (top_row[ncols-1] == '1') + (top_row[j] == '1') + (top_row[j+1] == '1'); 
    if (game_rules(prev_gen, next_gen, i, j, neigh) == 1){
        changed = 1;
    }
    
    //top right:
    i = 0, j = ncols-1;
    neigh = (prev_gen[i][0] == '1') + (prev_gen[i+1][0] == '1') + (prev_gen[i+1][j] == '1') + (prev_gen[i+1][j-1] == '1') + (prev_gen[i][j-1] == '1') + (top_row[j-1] == '1') + (top_row[j] == '1') + (top_row[0] == '1'); 
    if (game_rules(prev_gen, next_gen, i, j, neigh) == 1){
        changed = 1;
    }
    
    //bottom left:
    i = nrows-1, j = 0;
    neigh = (prev_gen[i][j+1] == '1') + (bottom_row[j+1] == '1') + (bottom_row[j] == '1') + (bottom_row[ncols-1] == '1') + (prev_gen[i][ncols-1] == '1') + (prev_gen[i-1][ncols-1] == '1') + (prev_gen[i-1][j] == '1') + (prev_gen[i-1][j+1] == '1');
    if (game_rules(prev_gen, next_gen, i, j, neigh) == 1){
        changed = 1;
    }

    //bottom right:
    i = nrows-1, j = ncols-1;
    neigh = (prev_gen[i][0] == '1') + (bottom_row[0] == '1') + (bottom_row[j] == '1') + (bottom_row[j-1] == '1') + (prev_gen[i][j-1] == '1') + (prev_gen[i-1][j-1] == '1') + (prev_gen[i-1][j] == '1') + (prev_gen[i-1][0] == '1');
    if (game_rules(prev_gen, next_gen, i, j, neigh) == 1){
        changed = 1;
    }
    return changed;
}

int ordered_evo_game_rules(char** next_gen, int i, int j, int al_neigh){
    int changed = 0;

    if (next_gen[i][j] == '1'){
        if (al_neigh != 2 && al_neigh != 3){
            next_gen[i][j] = '0';
            changed = 1;
        }
        else {
            next_gen[i][j] = '1';
        }
    }
    else{
        if (al_neigh == 3){
            next_gen[i][j] = '1';
            changed = 1;
        }
        else{
            next_gen[i][j] = '0';
        }
    }
    return changed;
}

int ordered_evo_evolve_outer(char** next_gen, char* top_row, char* bottom_row, int nrows, int ncols){
    int changed = 0;
    int neigh;

    //top left:
    int i = 0, j = 0;
    neigh = (next_gen[i][j+1] == '1') + (next_gen[i+1][j+1] == '1') + (next_gen[i+1][j] == '1') + (next_gen[i+1][ncols-1] == '1') + (next_gen[i][ncols-1] == '1') + (top_row[ncols-1] == '1') + (top_row[j] == '1') + (top_row[j+1] == '1'); 
    if (ordered_evo_game_rules(next_gen, i, j, neigh) == 1){
        changed = 1;
    }

    //First row:
    #pragma omp parallel for schedule(static)
    for (int j=1; j < ncols-1; j++){
        int i = 0;
        neigh = (next_gen[i][j-1] == '1') + (next_gen[i][j+1] == '1') + (next_gen[i+1][j-1] == '1') + (next_gen[i+1][j] == '1') + (next_gen[i+1][j+1] == '1') + (top_row[j-1] == '1') + (top_row[j] == '1') + (top_row[j+1] == '1');

        if (ordered_evo_game_rules(next_gen, i, j, neigh) == 1){
            changed = 1;
        }
    }

    //top right:
    i = 0, j = ncols-1;
    neigh = (next_gen[i][0] == '1') + (next_gen[i+1][0] == '1') + (next_gen[i+1][j] == '1') + (next_gen[i+1][j-1] == '1') + (next_gen[i][j-1] == '1') + (top_row[j-1] == '1') + (top_row[j] == '1') + (top_row[0] == '1'); 
    if (ordered_evo_game_rules(next_gen, i, j, neigh) == 1){
        changed = 1;
    }

    //first column:
    #pragma omp parallel for schedule(static)
    for (int i = 1; i < nrows-1; i++){
        int j = 0;
        neigh = (next_gen[i][j+1] == '1') + (next_gen[i-1][j+1] =='1') + (next_gen[i-1][j] =='1') + (next_gen[i-1][ncols-1] == '1') + (next_gen[i][ncols-1] == '1') + (next_gen[i+1][ncols-1] == '1') + (next_gen[i+1][j] == '1') + (next_gen[i+1][j+1] == '1');

        if (ordered_evo_game_rules(next_gen, i, j, neigh) == 1){
            changed = 1;
        }
    }

    //last column:
    #pragma omp parallel for schedule(static)
    for (int i = 1; i< nrows-1; i++){
        int j = ncols-1;
        neigh = (next_gen[i][0] == '1') + (next_gen[i-1][0] == '1') + (next_gen[i-1][j] =='1') + (next_gen[i-1][j-1] == '1') + (next_gen[i][j-1] == '1') + (next_gen[i+1][j-1] == '1') + (next_gen[i+1][j] == '1') + (next_gen[i+1][0] == '1');

        if (ordered_evo_game_rules(next_gen, i, j, neigh) == 1){
            changed = 1;
        } 
    }
    
    //bottom left:
    i = nrows-1, j = 0;
    neigh = (next_gen[i][j+1] == '1') + (bottom_row[j+1] == '1') + (bottom_row[j] == '1') + (bottom_row[ncols-1] == '1') + (next_gen[i][ncols-1] == '1') + (next_gen[i-1][ncols-1] == '1') + (next_gen[i-1][j] == '1') + (next_gen[i-1][j+1] == '1');
    if (ordered_evo_game_rules(next_gen, i, j, neigh) == 1){
        changed = 1;
    }

    //bottom right:
    i = nrows-1, j = ncols-1;
    neigh = (next_gen[i][0] == '1') + (bottom_row[0] == '1') + (bottom_row[j] == '1') + (bottom_row[j-1] == '1') + (next_gen[i][j-1] == '1') + (next_gen[i-1][j-1] == '1') + (next_gen[i-1][j] == '1') + (next_gen[i-1][0] == '1');
    if (ordered_evo_game_rules(next_gen, i, j, neigh) == 1){
        changed = 1;
    }

    //last_row:
    #pragma omp parallel for schedule(static)
    for (int j=1; j < ncols-1; j++){
        int i = nrows-1; //num row == 20, last row position is 19;
        neigh = (next_gen[i-1][j-1] == '1') + (next_gen[i-1][j] == '1') + (next_gen[i-1][j+1] == '1') + (next_gen[i][j-1] == '1') + (next_gen[i][j+1] == '1') + (bottom_row[j-1] == '1') + (bottom_row[j] == '1') + (bottom_row[j+1] == '1');

        if (ordered_evo_game_rules(next_gen, i, j, neigh) == 1){
            changed = 1;
        }
    }
    return changed;
}

int ordered_evo_evolve_inner(char** next_gen, int nrows, int ncols){
    int changed = 0;

    #pragma omp parallel for collapse(2) schedule(static)
    for (int i = 1; i<nrows-1; i++){
        for (int j = 1; j<ncols-1; j++) {
            int neigh = (next_gen[i-1][j-1] == '1') + (next_gen[i-1][j] == '1') + (next_gen[i-1][j+1] == '1') + (next_gen[i][j-1] == '1') + (next_gen[i][j+1] == '1') + (next_gen[i+1][j-1] == '1') + (next_gen[i+1][j] == '1') + (next_gen[i+1][j+1] == '1');

            if (ordered_evo_game_rules(next_gen, i, j, neigh) == 1){
                changed = 1;
            }
        }
    }
    return changed;
}

void execute_ordered_evolution(char** initial_grid, int* s_counts, int* dispa, int rank, MPI_Comm comm2d, int part_rows, int part_cols, int max_steps, int top, int bottom, int last_row, int* num_rows, int num_proc){
    char** loc_array = allocate_memory(part_rows, part_cols);
    char** gat_array = allocate_memory(kx, ky);

    int local_change, changed;
    double total_write_time;
    clock_t start, end;

    char* top_row;
    char* bottom_row;
    char* snap_name;

    MPI_Status status_b, status_t;

    top_row = (char *)malloc(kx*sizeof(char));
    bottom_row = (char *)malloc(kx*sizeof(char));
    snap_name = (char *)malloc(50*sizeof(char));

    MPI_Scatterv(&(initial_grid[0][0]), s_counts, dispa, MPI_CHAR, &(loc_array[0][0]), s_counts[rank], MPI_CHAR, 0, comm2d);

    for (int ii = 1; ii<=max_steps; ii++){
        //Send top and bottom row
        MPI_Sendrecv(&loc_array[0][0], kx, MPI_CHAR, top, 0, &bottom_row[0], kx, MPI_CHAR, bottom, 0, comm2d, &status_b);
        MPI_Sendrecv(&loc_array[last_row][0], kx, MPI_CHAR, bottom, 0, &top_row[0], kx, MPI_CHAR, top, 0, comm2d, &status_t);

        local_change = ordered_evo_evolve_outer(loc_array, top_row, bottom_row, num_rows[rank], part_cols);
        local_change = ordered_evo_evolve_inner(loc_array, num_rows[rank], part_cols);

        if (ii%s == 0 || ii%n == 0){
            MPI_Gatherv(&(loc_array[0][0]), s_counts[rank], MPI_CHAR, &(gat_array[0][0]), s_counts, dispa, MPI_CHAR, 0, comm2d);

            if(rank == 0){
                sprintf(snap_name, "./snapshots/ordered_evo_snapshot_%05d.pbm", ii);

                start = clock();
                write_pgm_image(*gat_array, 1, kx, ky, snap_name);
                end = clock();
                total_write_time += ((double)(end-start))/CLOCKS_PER_SEC;
            }
        }
    }
}

void execute_game_snapshots(char** initial_grid, int* s_counts, int* dispa, int rank, MPI_Comm comm2d, int part_rows, int part_cols, int max_steps, int top, int bottom, int last_row, int* num_rows, int num_proc){
    char** loc_array = allocate_memory(part_rows, part_cols);
    char** gat_array = allocate_memory(kx, ky);
    char** next_gen = allocate_memory(part_rows, part_cols);
    char** tmp;

    int local_change, changed;
    double total_write_time, total_write_time2;
    clock_t start, end, start2, end2;

    char* top_row;
    char* bottom_row;
    char* snap_name;
    char* snap_name2;

    MPI_Status status_b, status_t;

    top_row = (char *)malloc(kx*sizeof(char));
    bottom_row = (char *)malloc(kx*sizeof(char));
    snap_name = (char *)malloc(50*sizeof(char));
    snap_name2 = (char *)malloc(50*sizeof(char));

    MPI_Scatterv(&(initial_grid[0][0]), s_counts, dispa, MPI_CHAR, &(loc_array[0][0]), s_counts[rank], MPI_CHAR, 0, comm2d);

    for (int ii = 1; ii<=max_steps; ii++){
        //Send top and bottom row to arrays.
        MPI_Sendrecv(&loc_array[0][0], kx, MPI_CHAR, top, 0, &bottom_row[0], kx, MPI_CHAR, bottom, 0, comm2d, &status_b);
        MPI_Sendrecv(&loc_array[last_row][0], kx, MPI_CHAR, bottom, 0, &top_row[0], kx, MPI_CHAR, top, 0, comm2d, &status_t);

        local_change = evolve_inner(loc_array, next_gen, num_rows[rank], part_cols);
        local_change = evolve_outer(loc_array, next_gen, top_row, bottom_row, num_rows[rank], part_cols);

        MPI_Gatherv(&(loc_array[0][0]), s_counts[rank], MPI_CHAR, &(gat_array[0][0]), s_counts, dispa, MPI_CHAR, 0, comm2d);

        //printing snapshots here
        if (ii%s == 0 || ii%n == 0){
            MPI_Gatherv(&(loc_array[0][0]), s_counts[rank], MPI_CHAR, &(gat_array[0][0]), s_counts, dispa, MPI_CHAR, 0, comm2d);
            if(rank == 0){
                sprintf(snap_name, "./snapshots/snapshot_%05d.pbm", ii);

                start = clock();
                write_pgm_image(*gat_array, 1, kx, ky, snap_name);
                end = clock();

                total_write_time += ((double)(end-start))/CLOCKS_PER_SEC;
            }
        }

        tmp = loc_array;
        loc_array = next_gen;
        next_gen = tmp;
    }
    /*
    if (rank == 0){
        printf("Total write time: %.3f\n", total_write_time);
    }*/

    free(top_row);
    free(bottom_row);
    free(snap_name);

    free(loc_array[0]);
    free(loc_array);
    
    free(gat_array[0]);
    free(gat_array);

    free(next_gen[0]);
    free(next_gen);
}

int main(int argc, char **argv){
    int size, rank_id;

    char *ptr;
    char* point;
    int max_val = 1;

    clock_t start, end;
    double local_start, local_end, local_elapsed;

    /*Parsing the arguments*/
    char *optstring = "irk:x:y:e:f:n:s:";
    int c;
    while ((c = getopt(argc, argv, optstring)) != -1) {
        switch(c) {
        
        case 'i':
        action = INIT; break;
        
        case 'r':
        action = RUN; break;
        
        case 'k': //size of the playground
        kx = atoi(optarg);
        ky = atoi(optarg); break;

        case 'x':
        kx = atoi(optarg); break;

        case 'y':
        ky = atoi(optarg); break;

        case 'e':
        e = atoi(optarg); break;

        case 'f': //filename to save steps as image
        fname = (char*)malloc( sizeof(optarg)+1 );
        sprintf(fname, "%s", optarg );
        break;

        case 'n': //number of steps
        n = atoi(optarg); break;

        case 't': //number of openMP threads
        num_thread = atoi(optarg); break;
        
        case 's': // save file after s steps
        s = atoi(optarg); break;

        default :
        printf("argument -%c not known\n", c ); break;
        }
    }

    //Generates initial image and exits the program:
    if (action == INIT){
        char** global_grid = allocate_memory(kx, ky);
        generate_initial_image(global_grid, kx,ky);
        write_pgm_image(*global_grid, 1, kx, ky, fname);
        free(global_grid[0]);
        free(global_grid);
        return 0;
    }

    //Read the image
    read_pgm_image(&point, &max_val, &kx, &ky, fname);

    char** global_grid = allocate_memory(kx, ky);

    //Transform 1D grid into a 2D grid:
    if (action == RUN && rank_id == 0){
        int xx = 0, yy;

        for (int ii = 0; ii<kx*ky; ii++){
            yy = ii%ky;

            if (ii != 0 && ii%ky == 0){
                xx++;
            }
            global_grid[xx][yy] = point[ii];
        }
    }

    //Initialize MPI and create our 2D world:
    #if MPI_OPENMP
        int provided;
        MPI_Init_thread(&argc, &argv, MPI_THREAD_FUNNELED, &provided);
        num_thread = omp_get_num_threads();
    #else
        MPI_Init(&argc, &argv);
    #endif

    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank_id);
    MPI_Comm_set_errhandler(MPI_COMM_WORLD,MPI_ERRORS_RETURN);

    int dims[2] = {size, 0};
    int periods[2] = {1,0};
    int my_coords[2] = {0,0};

    MPI_Comm communicator_global;
    MPI_Dims_create(size, 2, dims);
    MPI_Cart_create(MPI_COMM_WORLD, 2, dims, periods, 0, &communicator_global);
    MPI_Cart_coords(communicator_global, rank_id, 2, my_coords);

    //Calculate number of rows per process:
    int num_row_per_process[size]; //stores the amount of rows per process
    int send_numbers[size]; //stores the total amount of sent data in Scatter call
    int disps[size]; //stores displacement of data in memory
    int last_row_index[size]; //stores last row index per process
    int last_r;

    calculate_workload(num_row_per_process, size, ky);
    if(rank_id == 0){
        int calc = 0;
        for (int i = 0; i<=size;i++){
            if (i == 0) {
                disps[i] = calc;
            }
            else {
                calc += num_row_per_process[i-1] * kx; //rows*columns
                disps[i] = calc;
            }
        }
    }

    for (int i = 0; i<size; i++){
        send_numbers[i] = num_row_per_process[i]*kx;
    }
    int recv_count = send_numbers[rank_id];

    char** local_grid = allocate_memory(num_row_per_process[rank_id], kx);
    
    if (rank_id == 0){
        for (int i = 0; i<size;i++){
            last_row_index[i] = num_row_per_process[i]-1;
            //printf("Last_row_index for rank %d is %d\n", i, last_row_index[i]);
        }
    }
    MPI_Bcast(last_row_index, size, MPI_INT, 0, communicator_global); //Broadcast the array with last row index to all processes

    //Dind neighbours, where top means process above me, and bottom means current process
    //Denoted as top, bottom for easier analogy -> top sends its bottom row to bottom process as bottoms top row in 2 process representation.
    int top, bottom;
    MPI_Cart_shift(communicator_global, 1, 1, &top, &bottom);

    //Initialize threads in hybrid approach:
    #if MPI_OPENMP
        omp_set_num_threads(num_thread);
    #endif
    
    local_start = MPI_Wtime();

    if (e == STATIC){
        execute_game_snapshots(global_grid, send_numbers, disps, rank_id, communicator_global, num_row_per_process[rank_id], kx, n, top, bottom, last_r, num_row_per_process, size);
    }
    else if (e == ORDERED){
        execute_ordered_evolution(global_grid, send_numbers, disps, rank_id, communicator_global, num_row_per_process[rank_id], kx, n, top, bottom, last_r, num_row_per_process, size);
    }

    MPI_Barrier(communicator_global);
    local_end = MPI_Wtime();

    float max_elapsed_time;
    float local_elapsed_time = local_end-local_start;
    MPI_Reduce(&local_elapsed_time, &max_elapsed_time, 1, MPI_FLOAT, MPI_MAX, 0, communicator_global);
    
    if (rank_id == 0){
        //fname = "final.pbm";
        //write_pgm_image(*gather_array, 1, kx, ky, fname);
        //printf("Elapsed time: %.3f\n", local_end-local_start);
        printf("%.3f\n", local_end-local_start);
        //printf("Max elapsed time: %.3f\n", max_elapsed_time);
        //printf("Elapsed time for barrier and gather: %.3f\n", ((double)(end-start))/CLOCKS_PER_SEC);
    }

    /*Finalize MPI:*/
    MPI_Finalize();

    free(global_grid[0]);
    free(global_grid);
    
    return 0;
}
