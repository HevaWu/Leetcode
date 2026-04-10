/*
You are given an integer array nums.

A tuple (i, j, k) of 3 distinct indices is good if nums[i] == nums[j] == nums[k].

The distance of a good tuple is abs(i - j) + abs(j - k) + abs(k - i), where abs(x) denotes the absolute value of x.

Return an integer denoting the minimum possible distance of a good tuple. If no good tuples exist, return -1.



Example 1:

Input: nums = [1,2,1,1,3]

Output: 6

Explanation:

The minimum distance is achieved by the good tuple (0, 2, 3).

(0, 2, 3) is a good tuple because nums[0] == nums[2] == nums[3] == 1. Its distance is abs(0 - 2) + abs(2 - 3) + abs(3 - 0) = 2 + 1 + 3 = 6.

Example 2:

Input: nums = [1,1,2,3,2,1,2]

Output: 8

Explanation:

The minimum distance is achieved by the good tuple (2, 4, 6).

(2, 4, 6) is a good tuple because nums[2] == nums[4] == nums[6] == 2. Its distance is abs(2 - 4) + abs(4 - 6) + abs(6 - 2) = 2 + 2 + 4 = 8.

Example 3:

Input: nums = [1]

Output: -1

Explanation:

There are no good tuples. Therefore, the answer is -1.



Constraints:

1 <= n == nums.length <= 100
1 <= nums[i] <= n
*/

/*
Solution
record the num to index map

Time Complexity: O(n^3)
Space Complexity: O(n)
*/
class Solution {
    func minimumDistance(_ nums: [Int]) -> Int {
        var numToIndex = [Int: [Int]]()
        let n = nums.count
        for i in 0..<n {
            numToIndex[nums[i], default: [Int]()].append(i)
        }

        var dis = 3 * n
        for (k, v) in numToIndex {
            let len = v.count
            if len < 3 { continue }
            // print(k, v)
            for i in 0...(len-3) {
                for j in (i+1)...(len-2) {
                    for k in (j+1)...(len-1) {
                        dis = min(dis, abs(v[i]-v[j]) + abs(v[j]-v[k]) + abs(v[k]-v[i]))
                    }
                }
            }
        }
        return dis == 3 * n ? -1 : dis
    }
}
