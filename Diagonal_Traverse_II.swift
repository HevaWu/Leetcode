/*
Given a 2D integer array nums, return all elements of nums in diagonal order as shown in the below images.



Example 1:


Input: nums = [[1,2,3],[4,5,6],[7,8,9]]
Output: [1,4,2,7,5,3,8,6,9]
Example 2:


Input: nums = [[1,2,3,4,5],[6,7],[8],[9,10,11],[12,13,14,15,16]]
Output: [1,6,2,8,7,3,9,4,12,10,5,13,11,14,15,16]


Constraints:

1 <= nums.length <= 105
1 <= nums[i].length <= 105
1 <= sum(nums[i].length) <= 105
1 <= nums[i][j] <= 105
*/

/*
Solution 2:
Store same diagonal element into array
then build result array

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func findDiagonalOrder(_ nums: [[Int]]) -> [Int] {
        let n = nums.count
        var size = 0
        var diagonal = [[Int]]()
        for i in 0..<n {
            size += nums[i].count
            for j in 0..<nums[i].count {
                var d = i + j
                if diagonal.count <= d {
                    diagonal.append([Int]())
                }
                diagonal[d].append(nums[i][j])
            }
        }

        var arr = Array(repeating: 0, count: size)
        var index = 0
        for i in 0..<diagonal.count {
            for j in stride(from: diagonal[i].count-1, through: 0, by: -1) {
                arr[index] = diagonal[i][j]
                index += 1
            }
        }
        return arr
    }
}

/*
Solution 1:
TLE

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func findDiagonalOrder(_ nums: [[Int]]) -> [Int] {
        var arr = [Int]()
        let n = nums.count
        var maxCol = 0
        for i in 0..<n {
            maxCol = max(maxCol, nums[i].count)
            for j in 0...i {
                if j < nums[i-j].count {
                    arr.append(nums[i-j][j])
                }
            }
        }

        for j in 0..<maxCol {
            for i in stride(from: n-1, through: 0, by: -1) {
                if (j+n-i) < nums[i].count {
                    arr.append(nums[i][j+n-i])
                }
            }
        }
        return arr
    }
}
