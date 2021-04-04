/*
You are given two positive integer arrays nums1 and nums2, both of length n.

The absolute sum difference of arrays nums1 and nums2 is defined as the sum of |nums1[i] - nums2[i]| for each 0 <= i < n (0-indexed).

You can replace at most one element of nums1 with any other element in nums1 to minimize the absolute sum difference.

Return the minimum absolute sum difference after replacing at most one element in the array nums1. Since the answer may be large, return it modulo 109 + 7.

|x| is defined as:

x if x >= 0, or
-x if x < 0.


Example 1:

Input: nums1 = [1,7,5], nums2 = [2,3,5]
Output: 3
Explanation: There are two possible optimal solutions:
- Replace the second element with the first: [1,7,5] => [1,1,5], or
- Replace the second element with the third: [1,7,5] => [1,5,5].
Both will yield an absolute sum difference of |1-2| + (|1-3| or |5-3|) + |5-5| = 3.
Example 2:

Input: nums1 = [2,4,6,8,10], nums2 = [2,4,6,8,10]
Output: 0
Explanation: nums1 is equal to nums2 so no replacement is needed. This will result in an
absolute sum difference of 0.
Example 3:

Input: nums1 = [1,10,4,4,2,7], nums2 = [9,3,5,1,7,4]
Output: 20
Explanation: Replace the first element with the second: [1,10,4,4,2,7] => [10,10,4,4,2,7].
This yields an absolute sum difference of |10-9| + |10-3| + |4-5| + |4-1| + |2-7| + |7-4| = 20


Constraints:

n == nums1.length
n == nums2.length
1 <= n <= 105
1 <= nums1[i], nums2[i] <= 105
*/

/*
Solution 1:
since we can only replace at most 1 element in nums1
- count curDiff (diff by using original nums1 and nums2)
- for each nums1[i], see if there is another proper replaceable number in nums1 can minimize abs diff

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func minAbsoluteSumDiff(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let n = nums1.count
        let mod = Int(1e9 + 7)

        var sortedNums1 = nums1.sorted()
        var curDiff = 0

        // find all diff
        for i in 0..<n {
            curDiff = (curDiff + abs(nums1[i]-nums2[i])) % mod
        }

        var minDiff = curDiff

        // compare and see if each single replace can minimize minDiff
        for i in 0..<n {
            if nums1[i] == nums2[i] { continue }
            minDiff = min(
                minDiff,
                (curDiff - (abs(nums1[i] - nums2[i])) + insert(sortedNums1, n, nums2[i])) % mod
            )
            // print(minDiff, curDiff)
        }
        return minDiff
    }

    // return minimum abs diff if insert target in arr
    func insert(_ arr: [Int], _ n: Int, _ target: Int) -> Int {
        var left = 0
        var right = n-1
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] < target {
                left = mid+1
            } else {
                right = mid
            }
        }

        var minDiff = abs(arr[left] - target)
        if left > 0 {
            minDiff = min(minDiff, abs(arr[left-1] - target))
        }
        if left < n-1 {
            minDiff = min(minDiff, abs(arr[left+1] - target))
        }

        // print(target, minDiff)
        return minDiff
    }
}