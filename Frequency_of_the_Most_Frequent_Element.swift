/*
The frequency of an element is the number of times it occurs in an array.

You are given an integer array nums and an integer k. In one operation, you can choose an index of nums and increment the element at that index by 1.

Return the maximum possible frequency of an element after performing at most k operations.



Example 1:

Input: nums = [1,2,4], k = 5
Output: 3
Explanation: Increment the first element three times and the second element two times to make nums = [4,4,4].
4 has a frequency of 3.
Example 2:

Input: nums = [1,4,8,13], k = 5
Output: 2
Explanation: There are multiple optimal solutions:
- Increment the first element three times to make nums = [4,4,8,13]. 4 has a frequency of 2.
- Increment the second element four times to make nums = [1,8,8,13]. 8 has a frequency of 2.
- Increment the third element five times to make nums = [1,4,13,13]. 13 has a frequency of 2.
Example 3:

Input: nums = [3,9,6], k = 2
Output: 1


Constraints:

1 <= nums.length <= 105
1 <= nums[i] <= 105
1 <= k <= 105
*/

/*
Solution 1:
slide window

For every new element A[j] to the sliding window,
Add it to the sum by sum += A[j].
Check if it'a valid window by
sum + k < (long)A[j] * (j - i + 1)
If not, removing A[i] from the window by
sum -= A[i] and i += 1.
Then update the res by res = max(res, j - i + 1).

Time Complexity: O(nlogn)
Space Complexity: O(1)
*/
class Solution {
    func maxFrequency(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums.sorted()
        var k = k
        var left = 0
        var right = 0
        while right < nums.count {
            k += nums[right]
            if k < nums[right] * (right - left + 1) {
                k -= nums[left]
                left += 1
            }
            right += 1
        }

        return right - left
    }
}