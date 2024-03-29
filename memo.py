# int char
chr(97) # int to char 'a'
ord('a') # 97 char to int
int("12") # convert string to int
str(1) # convert int to string

sys.maxsize # int64 max
-sys.maxsize - 1 # int64 min
2**31-1 # int32 max
-2**31-1 #int32 min

# String
s.split(' ') # split string by space\
c = 'a'
c.isupper() # is upper case
c1.islower()
c.isnumeric()
c1.lower() # convert to lower char
str.join(sequence) # join sequence by str, could use to join char array
''.join(list(reversed(word))) # reverse string
str[::-1] # reverse string
str[i:j:] # return substring of s[i..<j]
max(str) # return its maximum digit, if str = "32", it will return 3
res = res[:-1] # drop last character

# List / array
# https://docs.python.org/3/tutorial/introduction.html#lists
len(array) # length of array
dp = [[0 for i in range(n)] for j in range(n)] # 2D array init
list.pop(i) # remove ith index element from list
list.insert(index, element) # insert element at index
pop(-1) # remove last element
arr.reverse() # reverse array in place
a, b = b, a # swap two element
nums[index+1:len(nums)] = nums[index+1:len(nums)][::-1] # reverse partial array
list.copy() # make copy of list without reference
bisect.bisect_left(a, x, lo=0, hi=len(a), *, key=None) # binary search, locate insertion point at left

# heap
import heapq
heapq.heapify(list) # convert list to heap (min heap), heappop, heappush,
heappush(list, 1) # push element in heap
heappop(list) # pop element from heap
list[0] # always return the smallest element
A = [-1 * a for a in A] # max heap
class Node(object):
    def __init__(self, val: int):
        self.val = val

    def __repr__(self):
        return f'Node value: {self.val}'

    def __lt__(self, other):
        return self.val < other.val

heap = [Node(2), Node(0), Node(1), Node(4), Node(2)]
heapq.heapify(heap)
print(heap) # custom heap

# Stack
stack = [(root, root.val)] # init stack with pair of <TreeNode, Int>
while stack # can use to check stack is empty or not
stack.pop() # use to pop stack value
stack.append((node, 23)) # push element into stack

# Set
startSet = set([0])
startSet.add(3) # add into set
startSet.discard(3) # if element exist in set, remove, otherwise do nothing
3 in startSet # check if element in set
if len(startSet) > len(endSet):
    startSet, endSet = endSet, startSet # quick switch element

# map
graph = {}
for i in range(n):
    if arr[i] in graph:
        graph[arr[i]].append(i)
    else:
        graph[arr[i]] = [i]
graph[arr[cur]].clear() # remove key from graph
graph.keys() # get all keys from graph
graph.values() # get all values from graph
graph.items() # get (key, val) pair
numMap[numSum] = numMap.get(numSum, 0) + 1 # get or default
if key in mydict # check key exist or not
Counter(nums) # convert nums to counter
sortedFreq = sorted(freq.items(), key=lambda x:(-x[1],x[0])) # sort map by descending value, ascending key
graph.pop(key) # remove key from graph

# others
range(1, 10) # range of 1..<10
range(0, -10, -1) # [0, -1, -2, -3, -4, -5, -6, -7, -8, -9] last one is step
a // 2 # 取整除 - 向下取接近商的整数 9//2 is 4
random.randint(0, 3) # random int of 0...3
@lru_cache(None) # cache function
"变量1" if a>b else "变量2"
math.ceil(0.1) # ceil math function
round(x, 2) # round number to only leave 2 decimal points
nonlocal res, a #  bind to the nearest non-global variable also called res, a
hA is hB # check if two object have same reference

# sort by comparator
def compare(p1, p2) -> bool:
    return p1[1] - p2[1]
points = sorted(points, key=cmp_to_key(compare))
points.sort(key = lambda x : x[1])
satisfaction.sort(key = cmp_to_key(lambda s1, s2 : s2-s1))

# map list element's names
list(map(lambda x: x[0], weaker))
