// ======= Integer =======
int max = Integer.MAX_VALUE; // java integer's max value
long a = (long)3; // convert int to long
rand.nextInt(bound); // return random element in bound

// ======= Double =======
Double b = 3; // init Double from int

// ======= String =======
String str = "abc";
str.length(); // size of string
char[] arr = s.toCharArray(); //string to char array
s.substring(i) + s.substring(0, i); // substring
s1.compareTo(s2); // compare 2 strings, 0 means equal, <0 means s1 < s2, >0 means s1 > s2
s.charAt(0); // return char at index
int charA = 'a'; // convert char to int
(int)'a'; // convert char to int
(char)next; // convert int to char
str.indexOf('a'); // first index appear of char a
s.trim().split("\\s+"); //split by multiple whitespace
String.join(" ", str); // join string from array

// ======= StringBuilder =======
StringBuilder str = new StringBuilder();
str.append(s.substring(i+1, end+1)).append(" "); // append string
str.toString(); // convert stringbuilder to string

// ======= StringBuilder =======
StringBuilder sb = new StringBuilder(str);
sb.reverse(); // reverse string builder

// ======= Arrays =======　
int[] dir = new int[] {0, 1, 0, -1, 0}; // array initialization
Arrays.sort(arr); // sort array
Arrays.fill(arr, 1); // fill array
Arrays.copyOf(arr, newSize); // return a copy of arr
int[] arr = new int[3];
arr.length; // return arr's size
arr.isEmpty(); // check arr is empty or not
arr.add(ele); // array list add element
arr.stream().mapToInt(Integer::intValue).toArray(); // convert arrayList to array
Arrays.asList(nums); // convert array to list
Collections.swap(arr, i, j); // swap element in collections
int index = Arrays.binarySearch(nums, target); // binary search target, if exist, return correct index, if not return "-(should be inserted index)"
Arrays.copyOfRange(nums, n-k, n); // get range of element in array
System.arraycopy(lastK, 0, nums, 0, k); // copy lastK's k elements to nums[0..<k]
Collections.reverse(Arrays.asList(str)) // reverse array

// ======= ArrayList =======　
List<Integer> arr = new ArrayList<Integer>();
arr.get(0); // array list get element in the index
arr.add(0); // array list add element
arr.size(); // array list size
Arrays.asList(1, 2, 3); // convert array to list

// ======= Queue =======　
Queue<TreeNode> q = new LinkedList<>(); // offer() insert element, poll return and remove first, peek return but not remove
q.size(); // get queue size

// ======= Stack =======　
Stack<Integer> stack = new Stack<>();
stack.peek(); // return stack first object
stack.pop(); // remove first in stack and return it
stack.push(ele); // push element into stack
stack.empty(); // check empty

// ======= Map =======
Map<Integer, Integer>[] f = new Map[n]; // array of dictionary/map
map.getOrDefault(c, 0); // if key c exist, return value of c, otherwise, return 0
map.put(c, 0); // set key c's value as 0
map.remove(key); // remove key

// ======= Math =======
Math.abs(-3); // get absolute value of one element
Math.sqrt(4); // sqrt value
Math.cell(0.3); // ceil number
(int)Math.floor(0.4); // floor number and convert to int, return 0
