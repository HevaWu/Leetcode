'''
Write an efficient algorithm that searches for a value target in an m x n integer matrix matrix. This matrix has the following properties:

Integers in each row are sorted from left to right.
The first integer of each row is greater than the last integer of the previous row.


Example 1:


Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
Output: true
Example 2:


Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
Output: false


Constraints:

m == matrix.length
n == matrix[i].length
1 <= m, n <= 100
-104 <= matrix[i][j], target <= 104
'''
class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        m = len(matrix)
        n = len(matrix[0])

        low = 0
        high = m-1
        while low <= high:
            mid = low + (high - low) // 2
            if matrix[mid][0] > target:
                high = mid - 1
            else:
                if matrix[mid][n-1] < target:
                    low = mid + 1
                else:
                    low1 = 0
                    high1 = n-1
                    while low1 <= high1:
                        mid1 = low1 + (high1 - low1) // 2
                        if matrix[mid][mid1] == target:
                            return True
                        else:
                            if matrix[mid][mid1] < target:
                                low1 = mid+1
                            else:
                                high1 = mid-1
                    return False

        return False
