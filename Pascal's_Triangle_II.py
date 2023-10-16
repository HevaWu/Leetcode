'''
Given an integer rowIndex, return the rowIndexth row of the Pascal's triangle.

Notice that the row index starts from 0.


In Pascal's triangle, each number is the sum of the two numbers directly above it.

Follow up:

Could you optimize your algorithm to use only O(k) extra space?



Example 1:

Input: rowIndex = 3
Output: [1,3,3,1]
Example 2:

Input: rowIndex = 0
Output: [1]
Example 3:

Input: rowIndex = 1
Output: [1,1]


Constraints:

0 <= rowIndex <= 33

'''

'''
Solution 2:
Iterative

build tri array
Time Complexity: O(n^2)
Space Complexity: O(n^2)
'''
class Solution:
    def getRow(self, rowIndex: int) -> List[int]:
        if rowIndex == 0: return [1]
        tri = [[] for _ in range(rowIndex+1)]
        tri[0] = [1]
        for i in range(1, rowIndex+1):
            tri[i] = [1 for _ in range(i+1)]
            for j in range(1, i):
                tri[i][j] = tri[i-1][j-1] + tri[i-1][j]
        return tri[rowIndex]
