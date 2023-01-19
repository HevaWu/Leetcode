/*
Given an integer array nums and an integer k, return the number of non-empty subarrays that have a sum divisible by k.

A subarray is a contiguous part of an array.



Example 1:

Input: nums = [4,5,0,-2,-3,1], k = 5
Output: 7
Explanation: There are 7 subarrays with a sum divisible by k = 5:
[4, 5, 0, -2, -3, 1], [5], [5, 0], [5, 0, -2, -3], [0], [0, -2, -3], [-2, -3]
Example 2:

Input: nums = [5], k = 9
Output: 0


Constraints:

1 <= nums.length <= 3 * 104
-104 <= nums[i] <= 104
2 <= k <= 104
*/

/*
Solution 2:
preMod to help quick count
previous continuous array's mod value

We start with an integer prefixMod = 0 to store the remainder when the sum of the elements of a subarray that start from index 0 is divided by k. We do not need the prefix sum array, since we only need to maintain the count of each remainder (0 to k - 1) so far. To maintain the count of the remainders, we initialize an array modGroups[k], where modGroups[R] stores the number of times R was the remainder so far.

We iterate over all the elements starting from index 0. We set prefixMod = (prefixMod + num[i] % k + k) % k for each element at index i to find the remainder of the sum of the subarray ranging from index 0 to index i when divided by k. The + k is needed to handle negative numbers. We can then add the number of subarrays previously seen having the same remainder prefixMod to cancel out the remainder. The total number of these arrays is in modGroups[prefixMod]. In the end, we increment the count of modGroups[R] by one to include the current subarray with the remainder R for future matches.

Till now, we chose some previous subarrays (if they exist) to delete the remainder from the existing array formed till index i when the sum of its elements is divided by k. What if the sum of the elements of the array till index i is divisible by k and we don't need another subarray to delete the remainder?

To count the complete subarray from index 0 to index i, we also initialize modGroups[0] = 1 at the start so that if a complete subarray from index 0 to the current index is divisible by k, we include the complete array in the count of modGroups[0]. It is set to start with 1 to cover the complete subarray case. For example, let's assume we are index i. Say, we have previously encountered three subarrays from index 0 to some index j where j < i that were divisible by 'k'. Now, assume the sum of elements in the array up to index i is also divisible by k. So, we will have 4 options to form a subarray ending at index i that is divisible by k. Three of these come from choosing the subarrays (resulting in subarray j + 1, .., i that is divisble by k) that were divisble by k and one comes from choosing the complete subarray starting from index 0 till index i.

Time Complexity: O(n)
Space Complexity: O(k)
*/
class Solution {
    func subarraysDivByK(_ nums: [Int], _ k: Int) -> Int {
        var preMod = 0
        var res = 0

        var modGroup = Array(repeating: 0, count: k)
        modGroup[0] = 1
        for num in nums {
            // plus k to avoid negtive remainder
            preMod = (preMod + num % k + k) % k
            res += modGroup[preMod]
            modGroup[preMod] += 1
        }

        return res

    }
}

/*
Solution 1:
TLE
check all possibility of continuos sub array

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func subarraysDivByK(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var sum = Array(repeating: 0, count: n)
        for i in 0..<n {
            sum[i] = nums[i] + (i-1 >= 0 ? sum[i-1] : 0)
        }
        var res = 0
        for i in 0..<n {
            for j in i..<n {
                if (sum[j] - (i-1 >= 0 ? sum[i-1] : 0)) % k == 0 {
                    res += 1
                }
            }
        }
        return res
    }
}
