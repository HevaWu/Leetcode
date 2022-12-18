'''
Given a list of daily temperatures T, return a list such that, for each day in the input, tells you how many days you would have to wait until a warmer temperature. If there is no future day for which this is possible, put 0 instead.

For example, given the list of temperatures T = [73, 74, 75, 71, 69, 72, 76, 73], your output should be [1, 1, 4, 2, 1, 1, 0, 0].

Note: The length of temperatures will be in the range [1, 30000]. Each temperature will be an integer in the range [30, 100].
'''

'''
Solution 1:
Stack

prepare stack: [(index, temperature)]
start from end of T array.
if stack is not empty, try to find if there is any element is larger than current

- Time Complexity: O(n), each index gets pushed and popped at most once from the stack
- Space Complexity: O(W), w is the number of allowed values for T[i]. Size of stack is bounded as it represents stictly increasing temperatures
'''
class Solution:
    def dailyTemperatures(self, temperatures: List[int]) -> List[int]:
        mystack = []
        n = len(temperatures)
        res = [0 for i in range(n)]
        for i in range(n-1, -1, -1):
            while mystack and mystack[-1][0] <= temperatures[i]:
                mystack.pop(-1)
            res[i] = (mystack[-1][1] - i) if mystack else 0
            mystack.append([temperatures[i], i])
        return res
