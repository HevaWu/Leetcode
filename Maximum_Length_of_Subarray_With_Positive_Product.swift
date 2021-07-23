/*
Given an array of integers nums, find the maximum length of a subarray where the product of all its elements is positive.

A subarray of an array is a consecutive sequence of zero or more values taken out of that array.

Return the maximum length of a subarray with positive product.



Example 1:

Input: nums = [1,-2,-3,4]
Output: 4
Explanation: The array nums already has a positive product of 24.
Example 2:

Input: nums = [0,1,-2,-3,-4]
Output: 3
Explanation: The longest subarray with positive product is [1,-2,-3] which has a product of 6.
Notice that we cannot include 0 in the subarray since that'll make the product 0 which is not positive.
Example 3:

Input: nums = [-1,-2,-3,0,1]
Output: 2
Explanation: The longest subarray with positive product is [-1,-2] or [-2,-3].
Example 4:

Input: nums = [-1,2]
Output: 1
Example 5:

Input: nums = [1,2,3,5,-6,4,0,10]
Output: 4


Constraints:

1 <= nums.length <= 10^5
-10^9 <= nums[i] <= 10^9

*/


/*
Solution 2:

Split the whole array into subarrays by zeroes since a subarray with positive product cannot contain any zero.
If the subarray has even number of negative numbers, the whole subarray has positive product.
Otherwise, we have two choices, either - remove the prefix till the first negative element in this subarray, or remove the suffix starting from the last negative element in this subarray.

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func getMaxLen(_ nums: [Int]) -> Int {
        let n = nums.count

        // convert ArraySlices to Array
        var split = nums.split(separator: 0).map { Array($0) }
        // print(split)

        var len = 0
        for s in split {
            var firstNegIndex = -1
            var lastNegIndex = -1
            var negCount = 0
            for i in 0..<s.count {
                if s[i] < 0 {
                    negCount += 1
                    if firstNegIndex == -1 {
                        firstNegIndex = i
                    }
                    lastNegIndex = i
                }
            }

            if negCount % 2 == 0 {
                len = max(len, s.count)
            } else {
                // s.count-1 - firstNeg
                len = max(len, max(
                    s.count-1-firstNegIndex,
                    lastNegIndex
                ))
            }
        }
        return len
    }
}


/*
Solution 1:
two pointer + shift

using two pointer to help finding the consecutive array is positive product
using left to right shift and right to left shift to make sure result is accurately

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func getMaxLen(_ nums: [Int]) -> Int {
        let n = nums.count

        // check from left -> right, and right->left
        // for avoiding (-1, 2), left will return 0, right will return 1
        return max(check(nums, n), check(nums.reversed(), n))
    }

    func check(_ nums: [Int], _ n: Int) -> Int {
        var left = -1
        var right = 0

        var len = 0

        // record until pre,
        // true if current result is positive,
        // false if current resutl is negative
        var pre: Bool? = nil
        while right < n {
            if nums[right] == 0 {
                // reset
                left = right
                pre = nil
            } else if nums[right] > 0 {
                pre = pre == nil ? true : pre
            } else {
                pre = pre == nil ? false : !(pre!)
            }

            if pre == true {
                len = max(len, right-left)
            }
            right += 1
        }
        return len
    }
}
