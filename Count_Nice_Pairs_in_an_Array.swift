/*
You are given an array nums that consists of non-negative integers. Let us define rev(x) as the reverse of the non-negative integer x. For example, rev(123) = 321, and rev(120) = 21. A pair of indices (i, j) is nice if it satisfies all of the following conditions:

0 <= i < j < nums.length
nums[i] + rev(nums[j]) == nums[j] + rev(nums[i])
Return the number of nice pairs of indices. Since that number can be too large, return it modulo 109 + 7.



Example 1:

Input: nums = [42,11,1,97]
Output: 2
Explanation: The two pairs are:
 - (0,3) : 42 + rev(97) = 42 + 79 = 121, 97 + rev(42) = 97 + 24 = 121.
 - (1,2) : 11 + rev(1) = 11 + 1 = 12, 1 + rev(11) = 1 + 11 = 12.
Example 2:

Input: nums = [13,10,35,24,76]
Output: 4


Constraints:

1 <= nums.length <= 105
0 <= nums[i] <= 109
*/

/*
Solution 1:
map

count freq of num-rev(num)

num[i] - rev[num[i]] = num[j] - rev[nums[j]]

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func countNicePairs(_ nums: [Int]) -> Int {
        let mod = Int(1e9 + 7)

        var map = [Int: Int]()
        for num in nums {
            map[num - getRev(num), default: 0] += 1
        }

        var count = 0
        for (key, val) in map {
            count = (count + (val*(val-1))/2) % mod
        }
        return count
    }

    func getRev(_ num: Int) -> Int {
        var rev = 0
        var num = num
        while num != 0 {
            rev = rev*10 + num%10
            num /= 10
        }
        return rev
    }
}