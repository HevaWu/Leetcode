/*
Given a positive integer n, return the number of positive integers less than or equal to n that have at least 1 repeated digit.



Example 1:

Input: n = 20
Output: 1
Explanation: The only positive number (<= 20) with at least 1 repeated digit is 11.
Example 2:

Input: n = 100
Output: 10
Explanation: The positive numbers (<= 100) with atleast 1 repeated digit are 11, 22, 33, 44, 55, 66, 77, 88, 99, and 100.
Example 3:

Input: n = 1000
Output: 262


Note:

1 <= n <= 109
*/

/*
Solution 1:
Transform N + 1 to arrayList
Count the number with digits < n
Count the number with same prefix
For example,
if N = 8765, L = [8,7,6,6],
the number without repeated digit can the the following format:
XXX
XX
X
1XXX ~ 7XXX
80XX ~ 86XX
870X ~ 875X
8760 ~ 8765

Time Complexity:
the number of permutations A(m,n) is O(1)
We count digit by digit, so it's O(logN)
*/
class Solution {
    func numDupDigitsAtMostN(_ n: Int) -> Int {
        var arr = [Int]()
        // transform n+1 to arr
        var num = n+1
        while num > 0 {
            arr.insert(num % 10, at: 0)
            num /= 10
        }
        if arr.count == 1 { return 0 }

        var res = 0
        // number with digits < n
        for i in 1..<arr.count {
            res += 9 * A(9, i-1)
        }

        // number with same prefix
        var visited = Set<Int>()
        for i in 0..<arr.count {
            var j = i > 0 ? 0 : 1
            while j < arr[i] {
                if !visited.contains(j) {
                    res += A(9-i, arr.count-i-1)
                }
                j += 1
            }
            if visited.contains(arr[i]) { break }
            visited.insert(arr[i])
        }
        return n - res
    }

    func A(_ m: Int, _ n: Int) -> Int {
        return n == 0 ? 1 : A(m, n-1) * (m-n+1)
    }
}