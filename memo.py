# int char
chr(97) # int to char 'a'
ord('a') # 97 char to int
int("12") # convert string to int

sys.maxsize # int64 max
-sys.maxsize - 1 # int64 min
2**31-1 # int32 max

# String
s.split(' ') # split string by space\
c = 'a'
c.isupper() # is upper case
str.join(sequence) # join sequence by str, could use to join char array

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

# heap
import heapq
heapq.heapify(list) # convert list to heap, heappop, heappush

# Stack
stack = [(root, root.val)] # init stack with pair of <TreeNode, Int>
while stack # can use to check stack is empty or not
stack.pop() # use to pop stack value
stack.append((node, 23)) # push element into stack

# Set
startSet = set([0])
startSet.add(3) # add into set
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
numMap[numSum] = numMap.get(numSum, 0) + 1 # get or default
if key in mydict # check key exist or not

# others
range(1, 10) # range of 1..<10
range(0, -10, -1) # [0, -1, -2, -3, -4, -5, -6, -7, -8, -9] last one is step
a // 2 # 取整除 - 向下取接近商的整数 9//2 is 4
random.randint(0, 3) # random int of 0...3
@lru_cache(None) # cache function
"变量1" if a>b else "变量2"
math.ceil(0.1) # ceil math function
round(x, 2) # round number to only leave 2 decimal points

# sort by comparator
def compare(p1, p2) -> bool:
    return p1[1] - p2[1]
points = sorted(points, key=cmp_to_key(compare))
points.sort(key = lambda x : x[1])

# map list element's names
list(map(lambda x: x[0], weaker))
