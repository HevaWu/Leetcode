/*
Nearly everyone has used the Multiplication Table. The multiplication table of size m x n is an integer matrix mat where mat[i][j] == i * j (1-indexed).

Given three integers m, n, and k, return the kth smallest element in the m x n multiplication table.



Example 1:


Input: m = 3, n = 3, k = 5
Output: 3
Explanation: The 5th smallest number is 3.
Example 2:


Input: m = 2, n = 3, k = 6
Output: 6
Explanation: The 6th smallest number is 6.


Constraints:

1 <= m, n <= 3 * 104
1 <= k <= m * n
*/

/*
Solution 2:
binary search

enough to check if
- if k or more values in matrix is <= target

Time Complexity: O(m * log(mn))
Space Complexity: O(1)
*/
class Solution {
    func findKthNumber(_ m: Int, _ n: Int, _ k: Int) -> Int {
        var left = 1
        var right = m*n

        while left < right {
            let mid = left + (right-left)/2
            if !enough(mid, m, n, k) {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return left
    }

    // if k or more values in matrix is <= target
    func enough(_ target: Int, _ m: Int, _ n: Int, _ k: Int) -> Bool {
        var count = 0
        for i in 1...m {
            count += min(target / i, n)
        }
        return count >= k
    }
}

/*
Solution 1:
brute force

check number from 1... m*n, reduce remaining k
by finding how many times number i appear in matrix

Time Complexity: O(k * m*n)
Space Complexity: O(1)
*/
class Solution {
    func findKthNumber(_ m: Int, _ n: Int, _ k: Int) -> Int {
        var k = k-1
        var i = 1
        while k > 0 {
            i += 1

            // at least have 1*i, i*1 in matrix
            if i <= m {
                k -= 1
            }
            if i <= n {
                k -= 1
            }

            guard min(m, n) >= 2 else { continue }
            for j in 2...min(m, n) {
                if i % j == 0 {
                    if i == j {
                        continue
                    } else if i / j <= max(m, n) {
                        k -= 1
                    }
                }
                if k <= 0 { break }
            }
            // print(i, k)
        }
        return i;
    }
}