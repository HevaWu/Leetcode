/*
Given integer array nums, return the third maximum number in this array. If the third maximum does not exist, return the maximum number.

 

Example 1:

Input: nums = [3,2,1]
Output: 1
Explanation: The third maximum is 1.
Example 2:

Input: nums = [1,2]
Output: 2
Explanation: The third maximum does not exist, so the maximum (2) is returned instead.
Example 3:

Input: nums = [2,2,3,1]
Output: 1
Explanation: Note that the third maximum here means the third maximum distinct number.
Both numbers with value 2 are both considered as second maximum.
 

Constraints:

1 <= nums.length <= 104
-231 <= nums[i] <= 231 - 1
 

Follow up: Can you find an O(n) solution?
*/

/*
Solution 1:
keep cur3max array to recording current maximum 3 elements

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func thirdMax(_ nums: [Int]) -> Int {
        // 1stMax, 2ndMax, 3rdMax
        // use Int.min here, since nums[i] is in [-2^31, 2^31-1]
        var cur3max = [Int.min, Int.min, Int.min]
        
        for num in nums {
            if num > cur3max[0] {
                // use insert, in case we miss existing cur[0]
                cur3max.insert(num, at: 0)
                cur3max.removeLast()
            } else if num < cur3max[0], num > cur3max[1] {
                cur3max.insert(num, at: 1)
                cur3max.removeLast()
            } else if num < cur3max[1], num > cur3max[2] {
                cur3max[2] = num
            }
            // print(cur3max, num)
        }
        
        return cur3max[2] == Int.min ? cur3max[0] : cur3max[2]
    }
}