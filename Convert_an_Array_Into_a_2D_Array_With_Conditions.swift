/*
You are given an integer array nums. You need to create a 2D array from nums satisfying the following conditions:

The 2D array should contain only the elements of the array nums.
Each row in the 2D array contains distinct integers.
The number of rows in the 2D array should be minimal.
Return the resulting array. If there are multiple answers, return any of them.

Note that the 2D array can have a different number of elements on each row.



Example 1:

Input: nums = [1,3,4,1,2,3,1]
Output: [[1,3,4,2],[1,3],[1]]
Explanation: We can create a 2D array that contains the following rows:
- 1,3,4,2
- 1,3
- 1
All elements of nums were used, and each row of the 2D array contains distinct integers, so it is a valid answer.
It can be shown that we cannot have less than 3 rows in a valid array.
Example 2:

Input: nums = [1,2,3,4]
Output: [[4,3,2,1]]
Explanation: All elements of the array are distinct, so we can keep all of them in the first row of the 2D array.


Constraints:

1 <= nums.length <= 200
1 <= nums[i] <= nums.length
*/

/*
Solution 1:
use num frequency to decide which row this num should be added into

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func findMatrix(_ nums: [Int]) -> [[Int]] {
        let n = nums.count
        var matrix = [[Int]]()
        var freq = [Int: Int]()
        for num in nums {
            let numPreFreq = freq[num, default: 0]
            if matrix.count == numPreFreq {
                matrix.append([Int]())
            }
            matrix[numPreFreq].append(num)
            freq[num] = numPreFreq + 1
        }
        return matrix
    }
}
