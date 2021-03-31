/*
You are given two integer arrays nums1 and nums2 of lengths m and n respectively. nums1 and nums2 represent the digits of two numbers. You are also given an integer k.

Create the maximum number of length k <= m + n from digits of the two numbers. The relative order of the digits from the same array must be preserved.

Return an array of the k digits representing the answer.



Example 1:

Input: nums1 = [3,4,6,5], nums2 = [9,1,2,5,8,3], k = 5
Output: [9,8,6,5,3]
Example 2:

Input: nums1 = [6,7], nums2 = [6,0,4], k = 5
Output: [6,7,6,0,4]
Example 3:

Input: nums1 = [3,9], nums2 = [8,9], k = 3
Output: [9,8,9]


Constraints:

m == nums1.length
n == nums2.length
1 <= m, n <= 500
0 <= nums1[i], nums2[i] <= 9
1 <= k <= m + n


Follow up: Try to optimize your time and space complexity.
*/

/*
Solution 1:
greedy

- Create the maximum number of one array
  - Given one array of length n, create the maximum number of length k.
    - Initialize a empty stack
    - Loop through the array nums
    - pop the top of stack if it is smaller than nums[i] until
    - stack is empty
    - the digits left is not enough to fill the stack to size k
    - if stack size < k push nums[i]
    - Return stack
- Create the maximum number of two array using all of their digits.
  - We have k decisions to make, each time will just need to decide ans[i] is from which of the two. It seems obvious, we should always choose the larger one right? This is correct, but the problem is what should we do if they are equal?
  - This is not so obvious. The correct answer is we need to see what behind the two to decide.
  - First, we divide the k digits required into two parts, i and k-i. We then find the maximum number of length i in one array and the maximum number of length k-i in the other array using the algorithm in section 1. Now we combine the two results in to one array using the algorithm in section 2. After that we compare the result with the result we have and keep the larger one as final answer.

Time Complexity: O((m+n)^3)
Space Complexity: O(k)
*/
class Solution {
    func maxNumber(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [Int] {
        let m = nums1.count
        let n = nums2.count

        var res = Array(repeating: 0, count: k)
        // use max(k-n, 0)...min(k, m) at here
        // i -> k-n,0
        // k-i -> k, m
        for i in max(k-n, 0)...min(k, m) {
            let temp = merge(getMaxArr(nums1, i), getMaxArr(nums2, k-i), k)
            if larger(temp, 0, res, 0) {
                res = temp
            }
        }
        return res
    }

    func merge(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [Int] {
        var res = Array(repeating: 0, count: k)
        var i = 0
        var j = 0
        for index in 0..<k {
             if larger(nums1, i, nums2, j) {
                 res[index] = nums1[i]
                 i += 1
             } else {
                 res[index] = nums2[j]
                 j += 1
             }
        }
        return res
    }

    // Given one array of length n, create the maximum number of length k
    func getMaxArr(_ nums: [Int], _ k: Int) -> [Int] {
        let n = nums.count

        var stack = [Int]()

        for i in 0..<n {
            while stack.count + n - i > k, !stack.isEmpty, stack.last! < nums[i] {
                stack.removeLast()
            }
            if stack.count < k {
                stack.append(nums[i])
            }
        }

        var remain = k-stack.count
        while remain > 0 {
            stack.insert(0, at: 0)
            remain -= 1
        }
        return stack
    }

    func larger(_ nums1: [Int], _ i1: Int, _ nums2: [Int], _ i2: Int) -> Bool {
        var i1 = i1
        var i2 = i2
        while i1 < nums1.count, i2 < nums2.count, nums1[i1] == nums2[i2] {
            i1 += 1
            i2 += 1
        }
        return i2 == nums2.count
        ? true
        : (i1 < nums1.count && nums1[i1] > nums2[i2])
    }
}