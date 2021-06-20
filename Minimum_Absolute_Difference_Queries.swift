/*
The minimum absolute difference of an array a is defined as the minimum value of |a[i] - a[j]|, where 0 <= i < j < a.length and a[i] != a[j]. If all elements of a are the same, the minimum absolute difference is -1.

For example, the minimum absolute difference of the array [5,2,3,7,2] is |2 - 3| = 1. Note that it is not 0 because a[i] and a[j] must be different.
You are given an integer array nums and the array queries where queries[i] = [li, ri]. For each query i, compute the minimum absolute difference of the subarray nums[li...ri] containing the elements of nums between the 0-based indices li and ri (inclusive).

Return an array ans where ans[i] is the answer to the ith query.

A subarray is a contiguous sequence of elements in an array.

The value of |x| is defined as:

x if x >= 0.
-x if x < 0.


Example 1:

Input: nums = [1,3,4,8], queries = [[0,1],[1,2],[2,3],[0,3]]
Output: [2,1,4,1]
Explanation: The queries are processed as follows:
- queries[0] = [0,1]: The subarray is [1,3] and the minimum absolute difference is |1-3| = 2.
- queries[1] = [1,2]: The subarray is [3,4] and the minimum absolute difference is |3-4| = 1.
- queries[2] = [2,3]: The subarray is [4,8] and the minimum absolute difference is |4-8| = 4.
- queries[3] = [0,3]: The subarray is [1,3,4,8] and the minimum absolute difference is |3-4| = 1.
Example 2:

Input: nums = [4,5,2,2,7,10], queries = [[2,3],[0,2],[0,5],[3,5]]
Output: [-1,1,1,3]
Explanation: The queries are processed as follows:
- queries[0] = [2,3]: The subarray is [2,2] and the minimum absolute difference is -1 because all the
  elements are the same.
- queries[1] = [0,2]: The subarray is [4,5,2] and the minimum absolute difference is |4-5| = 1.
- queries[2] = [0,5]: The subarray is [4,5,2,2,7,10] and the minimum absolute difference is |4-5| = 1.
- queries[3] = [3,5]: The subarray is [2,7,10] and the minimum absolute difference is |7-10| = 3.


Constraints:

2 <= nums.length <= 105
1 <= nums[i] <= 100
1 <= queries.length <= 2 * 104
0 <= li < ri < nums.length

*/

/*
Solution 2:

Intuition:
Since 1 <= nums[i] <= 100, we can encode a large subarray into a cnt array where cnt[i] is the frequence of number i in the subarray.

Algorithm:
Generate the prefix sum array of counts. So prefix[i+1][j] is the frequence of number j in subarray A[0..i].
For each query L = Q[i][0], R = Q[i][1], we can get a cnt array where cnt[j] = prefix[R + 1][j] - prefix[L][j].
We can calculate the minimum absolute difference using this cnt array in O(100) = O(1) time.

Time Complexity: O(n+m)
Space Complexity: O(n)
*/
class Solution {
    func minDifference(_ nums: [Int], _ queries: [[Int]]) -> [Int] {
        let n = nums.count

        var freq = Array(repeating: 0, count: 101)

        // pre[i][j], freq of j in nums[0..<i]
        var pre = Array(
            repeating: Array(repeating: 0, count: 101),
            count: n+1
        )

        for i in 0..<n {
            freq[nums[i]] += 1
            for j in 1...100 {
                pre[i+1][j] = freq[j]
            }
        }

        let m = queries.count
        var res = Array(repeating: 0, count: m)
        for i in 0..<m {
            let left = queries[i][0]
            let right = queries[i][1]

            var temp = Array(repeating: 0, count: 101)
            for j in 1...100 {
                // right+1 at here
                temp[j] = pre[right+1][j] - pre[left][j]
            }

            var diff = Int.max
            var pre = -1
            for j in 1...100 {
                if temp[j] > 0 {
                    if pre > 0, j-pre < diff {
                        diff = j-pre
                    }
                    pre = j
                }
            }
            res[i] = diff == Int.max ? -1 : diff
        }
        return res
    }
}

/*
Solution 1:
brute force
TLE
*/
class Solution {
    func minDifference(_ nums: [Int], _ queries: [[Int]]) -> [Int] {
        return queries.map { q -> Int in
            getDiff(nums, q[0], q[1])
        }
    }

    func getDiff(_ nums: [Int], _ left: Int, _ right: Int) -> Int {
        var diff = Int.max
        for i in left..<right {
            for j in (left+1)...right {
                let val = abs(nums[i] - nums[j])
                if val > 0 {
                    diff = min(diff, val)
                }
            }
        }
        return diff == Int.max ? -1 : diff
    }
}