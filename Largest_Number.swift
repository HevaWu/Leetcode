/*
Given a list of non-negative integers nums, arrange them such that they form the largest number.

Note: The result may be very large, so you need to return a string instead of an integer.

 

Example 1:

Input: nums = [10,2]
Output: "210"
Example 2:

Input: nums = [3,30,34,5,9]
Output: "9534330"
Example 3:

Input: nums = [1]
Output: "1"
Example 4:

Input: nums = [10]
Output: "10"
 

Constraints:

1 <= nums.length <= 100
0 <= nums[i] <= 109
*/

/*
Solution 1:
sort by string

- conver each int to string
- sort string array by  concatenation

Assume that (without loss of generality), for some pair of integers aa and bb, our comparator dictates that aa should precede bb in sorted order. This means that a\frown b > b\frown aa⌢b>b⌢a (where \frown⌢ represents concatenation). For the sort to produce an incorrect ordering, there must be some cc for which bb precedes cc and cc precedes aa. This is a contradiction because a\frown b > b\frown aa⌢b>b⌢a and b\frown c > c\frown bb⌢c>c⌢b implies a\frown c > c\frown aa⌢c>c⌢a. In other words, our custom comparator preserves transitivity, so the sort is correct.

Once the array is sorted, the most "signficant" number will be at the front. There is a minor edge case that comes up when the array consists of only zeroes, so if the most significant number is 00, we can simply return 00. Otherwise, we build a string out of the sorted array and return it.

Time Complexity: O(n log n) - sort
Space Complexity: O(n)
*/
class Solution {
    func largestNumber(_ nums: [Int]) -> String {
        var nums = nums
        .map{ String($0) }
        .sorted(by: { first, second -> Bool in
            return second+first < first+second
        })
        
        // after sorting, if largest number is 0, return 0
        if nums[0] == "0" { return "0" }
        return nums.reduce(into: String()) { res, next in
            res += next
        }
    }
}