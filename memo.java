// ======= Integer =======
int max = Integer.MAX_VALUE; // java integer's max value
long a = (long)3; // convert int to long

// ======= Double =======
Double b = 3; // init Double from int

// ======= String =======
String str = "abc";
char[] arr = s.toCharArray(); //string to char array
s.substring(i) + s.substring(0, i); // substring
s1.compareTo(s2); // compare 2 strings, 0 means equal, <0 means s1 < s2, >0 means s1 > s2
s.charAt(0); // return char at index
int charA = 'a'; // convert char to int
(int)'a'; // convert char to int
(char)next; // convert int to char
str.indexOf('a'); // first index appear of char a

// ======= StringBuilder =======
StringBuilder sb = new StringBuilder(str);
sb.reverse(); // reverse string builder

// ======= Arrays =======　
Arrays.sort(arr); // sort array
Arrays.fill(arr, 1); // fill array
Arrays.copyOf(arr, newSize); // return a copy of arr
int[] arr = new int[3];
arr.length; // return arr's size
List<Integer> arr = new ArrayList<Integer>();
arr.isEmpty(); // check arr is empty or not
arr.add(ele); // array list add element
arr.stream().mapToInt(Integer::intValue).toArray(); // convert arrayList to array
Collections.swap(arr, i, j); // swap element in collections
int index = Arrays.binarySearch(nums, target); // binary search target, if exist, return correct index, if not return "-(should be inserted index)"

// ======= Map =======
Map<Integer, Integer>[] f = new Map[n]; // array of dictionary/map
map.getOrDefault(c, 0); // if key c exist, return value of c, otherwise, return 0
map.put(c, 0); // set key c's value as 0

// ======= Math =======
Math.abs(-3); // get absolute value of one element
