/*
Even though I’ve studied this algorithm a couple of times, I’ve never
had to implement it before. So I assigned it to myself.
*/

//to do:  add back main(), make compilable

//class whatever {
	public static void mergeSort(Comparable array[]) {
		int N = array.length;
		int k; // k is the block size.
		int x; // x is which block we are at.
		int i,j; //indices in old[]
		int p; // index in new[]
		int ilimit,jlimit; // end of blocks.
		Comparable hold [] = new Comparable [N];
		Comparable neww [] = hold;
		Comparable old [] = array;
		Comparable tmp [];
		for (k = 1; k < N; k *= 2) {
			p = 0;
			for (x = 0; x < N; x += (2*k)) {
				i = x;
				ilimit = i + k;
				j = ilimit;
				if (ilimit >= N) {
					while (i < N)
						neww[p++] = old[i++];
					break; //out of for-loop
				}
				jlimit = j + k;
				if (jlimit >= N)
					jlimit = N;
				while (true) {
					if (old[i].compareTo(old[j]) < 0) {
						neww[p++] = old[i++];
						if (i == ilimit) {
							while (j < jlimit)
								neww[p++] = old[j++];
							break; //out of while-loop
						}
					} else {
						neww[p++] = old[j++];
						if (j == jlimit) {
							while (i < ilimit)
								neww[p++] = old[i++];
							break; //out of while-loop
						}
					}
				} // End while loop.
			} // End inner for loop.
			tmp = old; old = neww; neww = tmp;
		}// End outer for loop.
		if (old != array)
			for (i = 0; i < N; i++)
				array[i] = old[i];
	}
//}