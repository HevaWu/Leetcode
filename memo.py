# int char
chr(97) # int to char 'a'
ord('a') # 97 char to int

# List / array
# https://docs.python.org/3/tutorial/introduction.html#lists
len(array) # length of array
dp = [[0 for i in range(n)] for j in range(n)] # 2D array init

# Stack
stack = [(root, root.val)] # init stack with pair of <TreeNode, Int>
while stack # can use to check stack is empty or not
stack.pop() # use to pop stack value
stack.append((node, 23)) # push element into stack

# others
range(1, 10) # range of 1..<10
range(0, -10, -1) # [0, -1, -2, -3, -4, -5, -6, -7, -8, -9] last one is step
a // 2 # 取整除 - 向下取接近商的整数 9//2 is 4
random.randint(0, 3) # random int of 0...3
@lru_cache(None) # cache function
"变量1" if a>b else "变量2"