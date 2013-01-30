/*
Even though I’ve studied this algorithm a couple of times, I’ve never
had to implement it before. So I assigned it to myself.
*/

//to do:  add main(), #include std headers

/** should have a time-complecity of O(N×log(N))
    and a space-compelcity of O(N) **/
void mergesort(int N, int array[]) {
  int k; // k is the block size.
  int x; //x is which block we are at.
  int i,j; //indices in old[]
  int p; // index in new[]
  int ilimit,jlimit; //end of blocks.
  int *hold = malloc(sizeof(hold) * N);
  if (hold == NULL) {
    fprintf(stderr,"malloc failed\n");
    exit(2);
  }
  int *new = hold;
  int *old = array;
  int *tmp;
  for (k = 1; k < N; k *= 2) {
    p = 0;
    for (x = 0; x < N; x += (2*k)) {
      i = x;
      ilimit = i + k;
      j = ilimit;
      if (ilimit >= N) {
				while (i < N)
					new[p++] = old[i++];
				break; //out of for-loop
      }
      jlimit = j + k;
      if (jlimit >= N)
				jlimit = N;
      while (1) {
				if (old[i] < old[j]) {
					new[p++] = old[i++];
					if (i == ilimit) {
						while (j < jlimit)
							new[p++] = old[j++];
						break; //out of while-loop
					}
				} else {
					new[p++] = old[j++];
					if (j == jlimit) {
						while (i < ilimit)
							new[p++] = old[i++];
						break; //out of while-loop
					}
				}
      } // End while loop.
    } // End inner for loop.
    tmp = old; old = new; new = tmp;
  }// End outer for loop.
  if (old != array)
    for (i = 0; i < N; i++)
      array[i] = old[i];
  free(hold);
  return;
}
