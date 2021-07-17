/*
Given an integer n, you must transform it into 0 using the following operations any number of times:

Change the rightmost (0th) bit in the binary representation of n.
Change the ith bit in the binary representation of n if the (i-1)th bit is set to 1 and the (i-2)th through 0th bits are set to 0.
Return the minimum number of operations to transform n into 0.



Example 1:

Input: n = 0
Output: 0
Example 2:

Input: n = 3
Output: 2
Explanation: The binary representation of 3 is "11".
"11" -> "01" with the 2nd operation since the 0th bit is 1.
"01" -> "00" with the 1st operation.
Example 3:

Input: n = 6
Output: 4
Explanation: The binary representation of 6 is "110".
"110" -> "010" with the 2nd operation since the 1st bit is 1 and 0th through 0th bits are 0.
"010" -> "011" with the 1st operation.
"011" -> "001" with the 2nd operation since the 0th bit is 1.
"001" -> "000" with the 1st operation.
Example 4:

Input: n = 9
Output: 14
Example 5:

Input: n = 333
Output: 393


Constraints:

0 <= n <= 109
*/

/*
Solution 2:
1XXXXXX -> 1100000 -> 100000 -> 0

1XXXXXX -> 1100000 needs minimumOneBitOperations(1XXXXXX ^ 1100000),
because it needs same operations 1XXXXXX ^ 1100000 -> 1100000 ^ 1100000 = 0.

1100000 -> 100000 needs 1 operation.
100000 -> 0, where 100000 is 2^k, needs 2^(k+1) - 1 operations.

In total,
f(n) = f((b >> 1) ^ b ^ n) + 1 + b - 1,
where b is the maximum power of 2 that small or equals to n.

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
    func minimumOneBitOperations(_ n: Int) -> Int {
        var n = n
        var res = n

        while n > 1 {
            res ^= (((n-1) ^ n) >> 1)
            n &= (n-1)
         }
        return res
    }
}

/*
Solution 1:

1. always first find min operation convert 2^k -> 0
2. recursively `decrease` operations to next 1 bit

example:
10010
=> find min operation convert 10000 -> 0
    => 10001, 10011, 10010, 10110, 10111, 10101, 10100, 11000, 01000, ... (find way to convert 01000 => 2^3)
    => 8 + minoperation covert 01000
    => 8 + 4 + 2 + 1
=> we notice 10010 appear when we convert 10000 -> 0, we should reduce way of convert 10

Time Complexity: O(k * log k)
Space Complexity: O(1)
*/
class Solution {
    func minimumOneBitOperations(_ n: Int) -> Int {
        if n == 0 { return 0 }

        // var str = String(n, radix: 2)
        // leftmost bit is kth
        // let k = str.count-1

        let k = 64 - n.leadingZeroBitCount - 1
        return minLeftmostBit(k) - minimumOneBitOperations(n - (1<<k))
    }

    // return minimum operations to change 2^n to 0
    func minLeftmostBit(_ n: Int) -> Int {
        let val = helpPow(2, n+1) - 1
        // print(val, n)
        return val
    }

    func helpPow(_ a: Int, _ power: Int) -> Int {
        var res = 1
        var a = a
        var power = power
        while power != 0 {
            if power & 1 == 1 {
                res = res * a
            }
            power >>= 1
            a = a * a
        }
        return res
    }
}