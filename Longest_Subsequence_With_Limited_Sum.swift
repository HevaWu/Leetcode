/*
You are given an integer array nums of length n, and an integer array queries of length m.

Return an array answer of length m where answer[i] is the maximum size of a subsequence that you can take from nums such that the sum of its elements is less than or equal to queries[i].

A subsequence is an array that can be derived from another array by deleting some or no elements without changing the order of the remaining elements.



Example 1:

Input: nums = [4,5,2,1], queries = [3,10,21]
Output: [2,3,4]
Explanation: We answer the queries as follows:
- The subsequence [2,1] has a sum less than or equal to 3. It can be proven that 2 is the maximum size of such a subsequence, so answer[0] = 2.
- The subsequence [4,5,1] has a sum less than or equal to 10. It can be proven that 3 is the maximum size of such a subsequence, so answer[1] = 3.
- The subsequence [4,5,2,1] has a sum less than or equal to 21. It can be proven that 4 is the maximum size of such a subsequence, so answer[2] = 4.
Example 2:

Input: nums = [2,3,4,5], queries = [1]
Output: [0]
Explanation: The empty subsequence is the only subsequence that has a sum less than or equal to 1, so answer[0] = 0.


Constraints:

n == nums.length
m == queries.length
1 <= n, m <= 1000
1 <= nums[i], queries[i] <= 106
*/

/*
Solution 1:
sort array
then use binary search to find largest sum <= each query
since array is sorted by increasing order, greedy find the result

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {
        let n = nums.count
        var nums = nums.sorted()
        // sumArr[i] is sum of nums[0..<i]
        var sumArr = Array(repeating: 0, count: n+1)
        for i in 0..<n {
            sumArr[i+1] = sumArr[i] + nums[i]
        }

        return queries.map { target in
            if sumArr[0] > target { return 0 }
            if sumArr[n] <= target { return n }
            // binary search find the element <= target
            var l = 0
            var r = n
            while l < r {
                let mid = l + (r-l)/2
                if sumArr[mid] <= target {
                    l = mid + 1
                } else {
                    r = mid
                }
            }
            return sumArr[l] <= target ? l : l-1
        }
    }
}

/*
Solution 1:
sort array
then use two pointer to find longest contiguous subsequence for each query

Time Complexity: O(nlogn + n^2)
Space Complexity: O(n)
*/
class Solution {
    func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {
        let n = nums.count
        var nums = nums.sorted()
        // sumArr[i] is sum of nums[0..<i]
        var sumArr = Array(repeating: 0, count: n+1)
        for i in 0..<n {
            sumArr[i+1] = sumArr[i] + nums[i]
        }

        return queries.map { target in
            var l = 0
            var r = 0
            // cur window size
            var size = 0
            // cur sum of nums[i...j]
            var cur = 0
            while l <= r, r < n {
                cur += nums[r]
                while l < r, cur > target {
                    cur -= nums[l]
                    l += 1
                }
                if cur <= target {
                    size = max(size, r-l+1)
                }
                r += 1
                // print(size, l, r)
            }
            return size
        }
    }
}
