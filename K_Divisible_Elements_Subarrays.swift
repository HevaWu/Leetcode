/*
Given an integer array nums and two integers k and p, return the number of distinct subarrays which have at most k elements divisible by p.

Two arrays nums1 and nums2 are said to be distinct if:

They are of different lengths, or
There exists at least one index i where nums1[i] != nums2[i].
A subarray is defined as a non-empty contiguous sequence of elements in an array.



Example 1:

Input: nums = [2,3,3,2,2], k = 2, p = 2
Output: 11
Explanation:
The elements at indices 0, 3, and 4 are divisible by p = 2.
The 11 distinct subarrays which have at most k = 2 elements divisible by 2 are:
[2], [2,3], [2,3,3], [2,3,3,2], [3], [3,3], [3,3,2], [3,3,2,2], [3,2], [3,2,2], and [2,2].
Note that the subarrays [2] and [3] occur more than once in nums, but they should each be counted only once.
The subarray [2,3,3,2,2] should not be counted because it has 3 elements that are divisible by 2.
Example 2:

Input: nums = [1,2,3,4], k = 4, p = 1
Output: 10
Explanation:
All element of nums are divisible by p = 1.
Also, every subarray of nums will have at most 4 elements that are divisible by 1.
Since all subarrays are distinct, the total number of subarrays satisfying all the constraints is 10.


Constraints:

1 <= nums.length <= 200
1 <= nums[i], p <= 200
1 <= k <= nums.length


Follow up:

Can you solve this problem in O(n2) time complexity?
*/

/*
Solution 1:
hash robin

by keep the size of subarray, find all this size subarray
use hash[i] to help record element in this subarray nums[i...(i+len)]
- hash[i] = (hash[i] * 200 + nums[i+len]) % mod
use ele[i] to help tracking current divisible element in nums[i...(i+len)]

Time Complexity: O(n^2)
Space Complexity: O(1)
*/
class Solution {
    func countDistinct(_ nums: [Int], _ k: Int, _ p: Int) -> Int {
        let n = nums.count

        // number of distinct subarray which have at most k element
        // divisible by p
        var finded = 0

        // ele[i] means number of elements divisible by p
        // with starting from i
        // ele[i] will be updated based on len increase
        var ele = Array(repeating: 0, count: 201)

        // hash[i] means hash element for subarray start from i
        var hash = Array(repeating: 0, count: 201)

        let mod = Int(1e9 + 7)

        for len in 0..<n {
            var distinct = Set<Int>()

            for i in 0..<(n-len) {
                ele[i] += (nums[i+len] % p == 0 ? 1 : 0)
                if ele[i] <= k {
                    hash[i] = (hash[i] * 200 + nums[i+len]) % mod
                    guard !distinct.contains(hash[i]) else { continue }
                    distinct.insert(hash[i])
                    finded += 1
                }
            }
        }

        return finded
    }
}