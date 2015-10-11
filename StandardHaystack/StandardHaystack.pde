
void setup() {
  int seed = 0; // TRY DIFFERENT SEED VALUES
  
  boolean found_the_needle = false; // assume you won't find the number     
  long t_sum = 0;
  int t_count = 10; // increase for greater accuracy at a trade off of time
  
  println("Search haystack " + t_count + " times.");
  
  for(int i=0; i<t_count; i++) {
    int haystack[] = generateHaystack(100000, seed);
  
    long t = System.nanoTime();
    bubbleHaystack(haystack);
    found_the_needle = binarySearch(42, haystack); //Binary Search for 42
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
void bubbleHaystack(int[] haystack) {
  int store;
  int l = haystack.length;
  println("Sorting...");
  for (int i = l; i >= 0; i--) {
    for (int j = 0; j < l - 1; j++) {
      if (haystack[j] > haystack[j+1]) {
        store = haystack[j];
        haystack[j] = haystack[j+1];
        haystack[j+1] = store;
      }
    }
  }
}
boolean binarySearch(int e, int[] haystack) {
  println("Searching..."); //Wrote recursivley, proccessing couldn't deal with so many self calls.
  int minval = 0;
  int maxval = haystack.length;
  while (minval <= maxval) {
    int midval = (maxval+minval)/2;
    if (e < haystack[midval]) {
      maxval = midval - 1; //offset max, keeps from looping on value
    } else if (e > haystack[midval]) {
      minval = midval + 1; //offset min, so algortithm continues
    } else if (e == haystack[midval]){
      return true;
    }
  }
  println("No needle");
  return false;
}