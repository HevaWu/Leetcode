// ======= Integer =======
int max = Integer.MAX_VALUE; // java integer's max value
long a = (long)3; // convert int to long
rand.nextInt(bound); // return random element in bound
Integer.parseInt(str); // convert string to int
Math.round(d * 1000) / 1000; // 3 decimal point int

// ======= Double =======
Double b = 3; // init Double from int

// ======= String =======
String str = "abc";
str.length(); // size of string
char[] arr = s.toCharArray(); //string to char array
s.substring(i) + s.substring(0, i); // substring
s1.compareTo(s2); // compare 2 strings, 0 means equal, <0 means s1 < s2, >0 means s1 > s2
s1.equals(str); // check if s1 equal to str
s.charAt(0); // return char at index
int charA = 'a'; // convert char to int
(int)'a'; // convert char to int
(char)next; // convert int to char
str.indexOf('a'); // first index appear of char a
s.trim().split("\\s+"); //split by multiple whitespace
String.join(" ", str); // join string from array
String.valueOf(3); // "3" convert int to string
Character.isUpperCase(word.charAt(i)); // check if a character is upper/capital letter
// init repeating character string
char[] chars = new char[len];
Arrays.fill(chars, ch);
String s = new String(chars);


// ======= StringBuilder =======
StringBuilder sb = new StringBuilder();
sb.append(s.substring(i+1, end+1)).append(" "); // append string
sb.toString(); // convert stringbuilder to string, can also convert substring to string
sb.reverse(); // reverse string by stringBuilder
sb.charAt(i); // access stringBuilder character
sb.insert(0, char); // insert char at 0 index
sb.deleteCharAt(0); // delete character at index 0

// ======= StringBuilder =======
Character.isDigit(c); // check if c is digit number
(s.charAt(i)-'0'); // convert char to int

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
Arrays.sort(points, new Comparator<int[]>() { // sort array
    public int compare(int[] a, int[] b) {
        return Integer.compare(a[1],b[1]);
    }
}) ;
Arrays.sort(points, (p1, p2) -> {
    if (p1[0] == p2[0]) {
        return Integer.compare(p1[1], p2[1]);
    } else {
        return Integer.compare(p1[0], p2[0]);
    }
});
boolean[] b = new boolean[3]; // init boolean array

// ======= ArrayList =======　
List<Integer> arr = new ArrayList<Integer>();
arr.get(0); // array list get element in the index
arr.add(0); // array list add element
arr.size(); // array list size
arr.subList(3, 4); // sublist of [3..<4]
Arrays.asList(1, 2, 3); // convert array to list
arr.iterator().next(); // iterate over array list
numsList.add(0, 1); // add 1 at 0 index
arr.remove(arr.size()-1); // remove last element int the list
List<Plant> copy = new ArrayList<>(list); // copy list

// ======= Queue =======　
Queue<TreeNode> q = new LinkedList<>(); // offer() insert element, poll return and remove first, peek return but not remove
q.size(); // get queue size
q.offer(ele); // add element to queue
q.poll(); //返回第一个元素，并在队列中删除
q.peek(); //返回第一个元素
Queue<Integer> queue = new PriorityQueue(Collections.reverseOrder()); // priorityQueue, heap

// ======= Stack =======　
Stack<Integer> stack = new Stack<>();
stack.peek(); // return stack first object
stack.pop(); // remove first in stack and return it
stack.push(ele); // push element into stack
stack.empty(); // check empty
Deque<Pair<TreeNode, Integer>> stack = new ArrayDeque(); // use ArrayDeque to init stack
stack.isEmpty(); // check empty

// ======= Set =======
Set<Integer> set = new HashSet<Integer>();
set.size(); // return size of set
set.contains(2); // check if hashset contains element

// ======= Map =======
Map<Integer, Integer>[] f = new Map[n]; // array of dictionary/map
map.getOrDefault(c, 0); // if key c exist, return value of c, otherwise, return 0
map.keySet(); // get map's keys
map.put(c, 0); // set key c's value as 0
map.remove(key); // remove key
map.computeIfAbsent(arr[i], v -> new LinkedList<>()).add(i); // give default value, then update the value
map.get(arr[cur]).clear(); // clear key
map.containsKey(2); // check if key exists in map
Map.Entry<Integer, Integer> entry: map.entrySet(); // return entry, can use getKey() and getValue() from it later

// ======= Math =======
Math.abs(-3); // get absolute value of one element
Math.sqrt(4); // sqrt value
Math.cell(0.3); // ceil number
(int)Math.floor(0.4); // floor number and convert to int, return 0

// ======= Random =======
Random rand = new Random();
rand.nextInt(n); // return integer in [0..<n-1]

// ======= Pair =======
Pair<String, Integer> person = new Pair<>("Sajal", 12);