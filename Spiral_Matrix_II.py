'''
Given a positive integer n, generate an n x n matrix filled with elements from 1 to n2 in spiral order.



Example 1:


Input: n = 3
Output: [[1,2,3],[8,9,4],[7,6,5]]
Example 2:

Input: n = 1
Output: [[1]]


Constraints:

1 <= n <= 20
'''

'''
Solution 1:
build matrix element one by one
use dir to help define the direction of each element
0 right, 1 down, 2 left, 3 up

Time Complexity: O(n^2)
Space Complexity: O(n^2)
'''
class Solution:
    def generateMatrix(self, n: int) -> List[List[int]]:
        matrix = [[0 for i in range(n)] for i in range(n)]

        # 0 right, 1 down, 2 left, 3 up
        d = 0

        i = 0
        j = 0
        for val in range(1, n*n+1):
            matrix[i][j] = val
            if d == 0:
                if j+1 == n or matrix[i][j+1] != 0:
                    # change direction to down
                    d = 1
                    i += 1
                else:
                    j += 1
            elif d == 1:
                if i+1 == n or matrix[i+1][j] != 0:
                    # change direction to left
                    d = 2
                    j -= 1
                else:
                    i += 1
            elif d == 2:
                if j-1 < 0 or matrix[i][j-1] != 0:
                    # change direction to up
                    d = 3
                    i -= 1
                else:
                    j -= 1
            elif d == 3:
                if i-1 < 0 or matrix[i-1][j] != 0:
                    # change direction to right
                    d = 0
                    j += 1
                else:
                    i -= 1

        return matrix
