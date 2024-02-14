/*
You are given a 0-indexed integer array nums of even length consisting of an equal number of positive and negative integers.

You should rearrange the elements of nums such that the modified array follows the given conditions:

Every consecutive pair of integers have opposite signs.
For all integers with the same sign, the order in which they were present in nums is preserved.
The rearranged array begins with a positive integer.
Return the modified array after rearranging the elements to satisfy the aforementioned conditions.



Example 1:

Input: nums = [3,1,-2,-5,2,-4]
Output: [3,-2,1,-5,2,-4]
Explanation:
The positive integers in nums are [3,1,2]. The negative integers are [-2,-5,-4].
The only possible way to rearrange them such that they satisfy all conditions is [3,-2,1,-5,2,-4].
Other ways such as [1,-2,2,-5,3,-4], [3,1,2,-2,-5,-4], [-2,3,-5,1,-4,2] are incorrect because they do not satisfy one or more conditions.
Example 2:

Input: nums = [-1,1]
Output: [1,-1]
Explanation:
1 is the only positive integer and -1 the only negative integer in nums.
So nums is rearranged to [1,-1].


Constraints:

2 <= nums.length <= 2 * 105
nums.length is even
1 <= |nums[i]| <= 105
nums consists of equal number of positive and negative integers.
*/

/*
Solution 1:
list positive and negative number array
re-put them back to the nums

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func rearrangeArray(_ nums: [Int]) -> [Int] {
        let n = nums.count
        var pi = 0
        var ni = 0
        var positive = Array(repeating: 0, count: n/2)
        var negative = Array(repeating: 0, count: n/2)
        for num in nums {
            if num > 0 {
                positive[pi] = num
                pi += 1
            }
            if num < 0 {
                negative[ni] = num
                ni += 1
            }
        }
        // print(positive, negative)

        var nums = nums
        var curPositive = true
        pi = 0
        ni = 0
        for i in 0..<n {
            if curPositive {
                nums[i] = positive[pi]
                pi += 1
            } else {
                nums[i] = negative[ni]
                ni += 1
            }
            curPositive = (!curPositive)
        }

        return nums
    }
}
