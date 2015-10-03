
void setup() {
  int seed = 1; // TRY DIFFERENT SEED VALUES
  boolean found_the_needle = false; // assume you won't find the number     
  long t_sum = 0;
  int t_count = 10; // increase for greater accuracy at a trade off of time
  
  println("Search haystack " + t_count + " times.");
  
  for(int i=0; i<t_count; i++) {
    int haystack[] = generateHaystack(10000000, seed);
    long t = System.nanoTime();
    sortHaystack(haystack, 0, 9999999);
    found_the_needle = binarySearch(42, haystack); // deep philosophical search...
    long del = System.nanoTime() - t;
    println("Done searching in " + str(del/1000) + " microseconds.");
    if(i >= 3) // the earlier times are sometimes corrupted by memory mamangement and system processes
      t_sum += del;
  }
  long t_average = t_sum/(t_count-3);
  
  println("Average of last " + str(t_count - 3) + " searches is " + str(t_average/1000) + " microseconds.");
  
  if(found_the_needle) {
    println("\nThe needle is in there!");
  } else {
    println("\nNo trace of the needle could be found.");
  }
  
  exit();
}

int[] generateHaystack(int size, int seed) {
  int[] numbers = new int[size];
  
  randomSeed(seed);
  for(int i=0; i<size; i++) {
    numbers[i] = int(random(0, size)); // needles
  }
  
  return(numbers);
}

//Globals to save time.
int left;
int pivot;
int pivotLoc;
int temp;
//quicksort
void sortHaystack(int[] haystack, int min, int max) {
 if (min < max) {
   pivotLoc = part(haystack, min, max);
   sortHaystack(haystack, min, pivotLoc - 1);
   sortHaystack(haystack, pivotLoc + 1, max);
 }
}
//http://www.algorithmist.com/index.php/Quicksort --- transalted psuedocode there to java to test
int part(int[] haystack, int min, int max) {
  pivot = haystack[min];
  int left = min;
  for (int i=min+1; i<=max; i++) {
    if (haystack[i] < pivot) {
      left++;
      temp = haystack[i];
      haystack[i] = haystack[left];
      haystack[left] = temp;
    }
  }
  temp = haystack[min];
  haystack[min] = haystack[left];
  haystack[left] = temp;
  return left;
}


boolean binarySearch(int e, int[] haystack) {
  int a = 0;
  int c = 999999;
  int b;
  while (a <= c) {
    b = (c+a)/2;
    if (e < haystack[b]) { c = b - 1; } 
    else if (e > haystack[b]) { a = b + 1; }
    else if (e == haystack[b]){ return true; }
  }
  return false;
}