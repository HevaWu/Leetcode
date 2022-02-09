/*
Given an array of integers nums and an integer k, return the number of unique k-diff pairs in the array.

A k-diff pair is an integer pair (nums[i], nums[j]), where the following are true:

0 <= i < j < nums.length
|nums[i] - nums[j]| == k
Notice that |val| denotes the absolute value of val.



Example 1:

Input: nums = [3,1,4,1,5], k = 2
Output: 2
Explanation: There are two 2-diff pairs in the array, (1, 3) and (3, 5).
Although we have two 1s in the input, we should only return the number of unique pairs.
Example 2:

Input: nums = [1,2,3,4,5], k = 1
Output: 4
Explanation: There are four 1-diff pairs in the array, (1, 2), (2, 3), (3, 4) and (4, 5).
Example 3:

Input: nums = [1,3,1,5,4], k = 0
Output: 1
Explanation: There is one 0-diff pair in the array, (1, 1).


Constraints:

1 <= nums.length <= 104
-107 <= nums[i] <= 107
0 <= k <= 107
*/

/*
Solution 1:
check by k == 0 or not
when k==0, use another set to help recording finded pair
when k!=0, directly check its +-k would be fine

Time Complexity: O(n)
Space Complexity: O(m)
- m is unique pair
*/
class Solution {
    func findPairs(_ nums: [Int], _ k: Int) -> Int {
        var set = Set<Int>()
        var pair = 0
        if k == 0 {
            var finded = Set<Int>()
            for num in nums {
                if set.contains(num) && !finded.contains(num) {
                    finded.insert(num)
                }
                set.insert(num)
            }
            return finded.count
        }

        for num in nums {
            if set.contains(num + k) && !set.contains(num) {
                pair += 1
            }
            if set.contains(num - k) && !set.contains(num) {
                pair += 1
            }
            set.insert(num)
        }
        return pair
    }
}