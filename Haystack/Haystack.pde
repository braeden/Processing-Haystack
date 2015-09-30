
void setup() {
  int seed = 1; // TRY DIFFERENT SEED VALUES
  
  boolean found_the_needle = false; // assume you won't find the number     
  long t_sum = 0;
  int t_count = 1; // increase for greater accuracy at a trade off of time
  
  println("Search haystack " + t_count + " times.");
  
  for(int i=0; i<t_count; i++) {
    int haystack[] = generateHaystack(10000, seed);
  
    long t = System.nanoTime();
    sortHaystack(haystack);
   // found_the_needle = searchHaystack(42, haystack); // deep philosophical search...
    int haystack[] = generateHaystack(1000, seed);
  
    long t = System.nanoTime();
    sortHaystack(haystack);
    println(haystack);
    found_the_needle = searchHaystack(42, haystack); // deep philosophical search...
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

//we're going to use quicksort, which has an average case of O(nlogn)
//Use the Hoar Partition Scheme, as seen here https://en.wikipedia.org/wiki/Quicksort#Hoare_partition_scheme
void sortHaystack(int[] haystack) {
  int store;
  int l = haystack.length;
  for (int i = l; i >= 0; i--) {
    for (int j = 0; j < l - 1; j++) {
      if (haystack[j] > haystack[j+1]) {
        store = haystack[j];
        haystack[j] = haystack[j+1];
        haystack[j+1] = store;
      }
    }
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
  int max = 1000;
  
  for (int e = 1; max/e > 0; e *= 10)
    countSort(haystack, max, e);
}

/*
//this needs to be a recursive binary search
boolean searchHaystack(int needle, int[] haystack) {
  for (int i=0; i < haystack.length; i++) {
    if (haystack[i] == needle)
      return(true);
  }
  return(false);
  
  // YOUR CODE GOES HERE
}*/