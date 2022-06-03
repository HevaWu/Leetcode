'''
Given a 2D matrix matrix, find the sum of the elements inside the rectangle defined by its upper left corner (row1, col1) and lower right corner (row2, col2).

Range Sum Query 2D
The above rectangle (with the red border) is defined by (row1, col1) = (2, 1) and (row2, col2) = (4, 3), which contains sum = 8.

Example:
Given matrix = [
  [3, 0, 1, 4, 2],
  [5, 6, 3, 2, 1],
  [1, 2, 0, 1, 5],
  [4, 1, 0, 1, 7],
  [1, 0, 3, 0, 5]
]

sumRegion(2, 1, 4, 3) -> 8
sumRegion(1, 1, 2, 2) -> 11
sumRegion(1, 2, 2, 4) -> 12
Note:
You may assume that the matrix does not change.
There are many calls to sumRegion function.
You may assume that row1 ≤ row2 and col1 ≤ col2.
'''

'''
Solution 2: directly create sum[i+1][j+1] for i,j element
Note that the region Sum(OA)Sum(OA) is covered twice by both Sum(OB)Sum(OB) and Sum(OC)Sum(OC). We could use the principle of inclusion-exclusion to calculate Sum(ABCD)Sum(ABCD) as following:
Sum(ABCD) = Sum(OD) - Sum(OB) - Sum(OC) + Sum(OA)Sum(ABCD)=Sum(OD)−Sum(OB)−Sum(OC)+Sum(OA)

Time complexity : O(1)O(1) time per query, O(mn)O(mn) time pre-computation. The pre-computation in the constructor takes O(mn)O(mn) time. Each sumRegion query takes O(1)O(1) time.
Space complexity : O(mn)O(mn). The algorithm uses O(mn)O(mn) space to store the cumulative region sum.
'''
class NumMatrix:

    def __init__(self, matrix: List[List[int]]):
        m = len(matrix)
        n = len(matrix[0])
        self.sumMatrix = [[0 for j in range(n+1)] for i in range(m+1)]

        for i in range(m):
            for j in range(n):
                self.sumMatrix[i+1][j+1] = self.sumMatrix[i][j+1] + self.sumMatrix[i+1][j] - self.sumMatrix[i][j] + matrix[i][j]

    def sumRegion(self, row1: int, col1: int, row2: int, col2: int) -> int:
        return self.sumMatrix[row2+1][col2+1] - self.sumMatrix[row1][col2+1] - self.sumMatrix[row2+1][col1] + self.sumMatrix[row1][col1]



# Your NumMatrix object will be instantiated and called as such:
# obj = NumMatrix(matrix)
# param_1 = obj.sumRegion(row1,col1,row2,col2)