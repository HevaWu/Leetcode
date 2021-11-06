/*
Given an integer array nums, in which exactly two elements appear only once and all the other elements appear exactly twice. Find the two elements that appear only once. You can return the answer in any order.

You must write an algorithm that runs in linear runtime complexity and uses only constant extra space.



Example 1:

Input: nums = [1,2,1,3,2,5]
Output: [3,5]
Explanation:  [5, 3] is also a valid answer.
Example 2:

Input: nums = [-1,0]
Output: [-1,0]
Example 3:

Input: nums = [0,1]
Output: [1,0]


Constraints:

2 <= nums.length <= 3 * 104
-231 <= nums[i] <= 231 - 1
Each integer in nums will appear twice, only two integers will appear once.
*/

/*
Solution 3:
some changes of Solution 2
*/
class Solution {
    func singleNumber(_ nums: [Int]) -> [Int] {
        var bitMask = 0
        for num in nums {
            bitMask ^= num
        }

        var diffBit = bitMask & (-bitMask)
        var a = 0
        for num in nums {
            if diffBit & num == 0 {
                a ^= num
            }
        }
        return [a, bitMask ^ a]
    }
}

/*
Solution 2:
1. using XOR operation, get the result of two elements XOR, there must be a bit'1' in the XOR result, find any set bit, eg. choose the rightmost set bit
2. divide into two groups, one has this bit set, one did not have, using XOR in each group,
we can find two elements

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func singleNumber(_ nums: [Int]) -> [Int] {
        var res = [0, 0]
        var diffBit = 0
        for num in nums {
            diffBit ^= num
        }

        diffBit &= ~(diffBit-1)
        for num in nums {
            if diffBit & num == 0 {
                res[0] ^= num
            } else {
                res[1] ^= num
            }
        }
        return res
    }
}

/*
Solution 1:
Set
Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func singleNumber(_ nums: [Int]) -> [Int] {
        var set = Set<Int>()
        for num in nums {
            if set.contains(num) {
                set.remove(num)
            } else {
                set.insert(num)
            }
        }
        return Array(set)
    }
}