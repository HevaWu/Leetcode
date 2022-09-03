/*
Return all non-negative integers of length n such that the absolute difference between every two consecutive digits is k.

Note that every number in the answer must not have leading zeros. For example, 01 has one leading zero and is invalid.

You may return the answer in any order.



Example 1:

Input: n = 3, k = 7
Output: [181,292,707,818,929]
Explanation: Note that 070 is not a valid number, because it has leading zeroes.
Example 2:

Input: n = 2, k = 1
Output: [10,12,21,23,32,34,43,45,54,56,65,67,76,78,87,89,98]
Example 3:

Input: n = 2, k = 0
Output: [11,22,33,44,55,66,77,88,99]
Example 4:

Input: n = 2, k = 2
Output: [13,20,24,31,35,42,46,53,57,64,68,75,79,86,97]


Constraints:

2 <= n <= 9
0 <= k <= 9

*/

/*
Solution 1:
backtracking with memorizing

k == 0 special case
f(n, d) means n digit number, with last digit is d and satisfy adjacent 2 digit diff is k
we can build f(n,d) from f(n-1,d-k) and f(n-1,d+k)
the base case is n==2

Time Complexity: O(9*2^n)
Space Complexity: O(9*2^n)
*/
class Solution {
    func numsSameConsecDiff(_ n: Int, _ k: Int) -> [Int] {
        // k == 0 special case
        if k == 0 {
            var res = [Int]()
            for i in 1...9 {
                var num = i
                for j in 1..<n {
                    num = num*10 + i
                }
                res.append(num)
            }
            return res
        }

        // cache[n][d] represent possible num with n digit, last digit is d
        cache = Array(
            repeating: Array(
                repeating: nil,
                count: 10
            ),
            count: n+1
        )

        var res = [Int]()
        for i in 0...9 {
            res.append(contentsOf: check(n, i, k))
        }
        return res
    }

    // n size
    // d last digit in number
    // [Int]
    var cache = [[[Int]?]]()
    func check(_ n: Int, _ d: Int, _ k: Int) -> [Int] {
        // print(n, d, k, cache.count)
        if let val = cache[n][d] {
            return val
        }

        var val = [Int]()
        if n == 2 {
            if d-k > 0 {
                val.append((d-k)*10 + d)
            }
            if d+k <= 9 {
                val.append((d+k)*10 + d)
            }
        } else if n > 2 {
            if d-k >= 0 {
                let first = check(n-1, d-k, k)
                for num in first {
                    val.append(num*10 + d)
                }
            }
            if d+k <= 9 {
                let second = check(n-1, d+k, k)

                for num in second {
                    val.append(num*10 + d)
                }
            }
        }
        cache[n][d] = val
        return val
    }
}

/*
Another coding way
backtrack without memorization

Time Complexity: O(9*2^n)
Space Complexity: O(9*2^n)
*/
class Solution {
    func numsSameConsecDiff(_ n: Int, _ k: Int) -> [Int] {
        var diff = [Int]()
        for i in 1...9 {
            check(i, n-1, i, k, &diff)
        }
        return diff
    }

    func check(_ curDigit: Int, _ remain: Int,
               _ curNum: Int, _ k: Int,
               _ diff: inout [Int]) {
        if remain == 0 {
            diff.append(curNum)
            return
        }

        if curDigit + k >= 0, curDigit + k <= 9 {
            check(curDigit+k, remain - 1, curNum * 10 + curDigit + k, k, &diff)
        }
        if k != 0, curDigit - k >= 0, curDigit - k <= 9 {
            check(curDigit-k, remain - 1, curNum * 10 + curDigit - k, k, &diff)
        }
    }
}
