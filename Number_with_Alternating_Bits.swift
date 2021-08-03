/*
Given a positive integer, check whether it has alternating bits: namely, if two adjacent bits will always have different values.



Example 1:

Input: n = 5
Output: true
Explanation: The binary representation of 5 is: 101
Example 2:

Input: n = 7
Output: false
Explanation: The binary representation of 7 is: 111.
Example 3:

Input: n = 11
Output: false
Explanation: The binary representation of 11 is: 1011.
Example 4:

Input: n = 10
Output: true
Explanation: The binary representation of 10 is: 1010.
Example 5:

Input: n = 3
Output: false


Constraints:

1 <= n <= 231 - 1
*/

/*
Solution 2:
bit operations

We can get the last bit and the rest of the bits via n % 2 and n // 2 operations. Let's remember cur, the last bit of n. If the last bit ever equals the last bit of the remaining, then two adjacent bits have the same value, and the answer is False. Otherwise, the answer is True.

Also note that instead of n % 2 and n // 2, we could have used operators n & 1 and n >>= 1 instead.

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func hasAlternatingBits(_ n: Int) -> Bool {
        var n = n
        var cur = n & 1
        n >>= 1
        while n > 0 {
            // 2 consecutive same digit
            if cur == (n & 1) { return false }
            cur = n & 1
            n >>= 1
        }
        return true
    }
}

/*
Solution 1:
binary string

Time Complexity: O(n)
- n is length of string
Space Complexity: O(1)
*/
class Solution {
    func hasAlternatingBits(_ n: Int) -> Bool {
        var str = String(n, radix: 2)
        var pre: Character? = nil
        for c in str {
            if pre == nil {
                pre = c
            } else {
                if pre == c {
                    return false
                }
                pre = c
            }
        }
        return true
    }
}