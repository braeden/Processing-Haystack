
void setup() {
  int seed = 1; // TRY DIFFERENT SEED VALUES
  
  boolean found_the_needle = false; // assume you won't find the number     
  long t_sum = 0;
  int t_count = 10; // increase for greater accuracy at a trade off of time
  
  println("Search haystack " + t_count + " times.");
  
  for(int i=0; i<t_count; i++) {
    int haystack[] = generateHaystack(10000000, seed);
    long t = System.nanoTime();
    sortHaystack(haystack);
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
void countSort(int[] arr, int n, int exp)
{
  int[] count = new int[n+1];
  int[] output = new int[n];
  
  int i = 0;
    
  for(i = 0; i < n; ++i)
    ++count[(arr[i] / exp) % 10];
    
  for (i = 1; i <= n; ++i)
    count[i] += count[i-1];
    
  for (i = n - 1; i >= 0; --i)
  {
    output[count[(arr[i] / exp) % 10]-1] = arr[i];
    --count[(arr[i] / exp) % 10];
  }
  
  for (i = 0; i < n; ++i)
    arr[i] = output[i];  
}

//radix sort
void sortHaystack(int[] haystack) 
{
  int max = 10000000;
  
  for (int e = 1; max/e > 0; e *= 10)
    countSort(haystack, max, e);
}


boolean binarySearch(int e, int[] haystack) {
//Wrote recursivley, proccessing couldn't deal with so many self calls.
  int minval = 0;
  int maxval = 999999; //Fixed num for speed:haystack.length-1
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
  return false;
}