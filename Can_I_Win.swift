/*
In the "100 game" two players take turns adding, to a running total, any integer from 1 to 10. The player who first causes the running total to reach or exceed 100 wins.

What if we change the game so that players cannot re-use integers?

For example, two players might take turns drawing from a common pool of numbers from 1 to 15 without replacement until they reach a total >= 100.

Given two integers maxChoosableInteger and desiredTotal, return true if the first player to move can force a win, otherwise, return false. Assume both players play optimally.



Example 1:

Input: maxChoosableInteger = 10, desiredTotal = 11
Output: false
Explanation:
No matter which integer the first player choose, the first player will lose.
The first player can choose an integer from 1 up to 10.
If the first player choose 1, the second player can only choose integers from 2 up to 10.
The second player will win by choosing 10 and get a total = 11, which is >= desiredTotal.
Same with other integers chosen by the first player, the second player will always win.
Example 2:

Input: maxChoosableInteger = 10, desiredTotal = 0
Output: true
Example 3:

Input: maxChoosableInteger = 10, desiredTotal = 1
Output: true


Constraints:

1 <= maxChoosableInteger <= 20
0 <= desiredTotal <= 300
*/

class Solution {
    func canIWin(_ maxChoosableInteger: Int, _ desiredTotal: Int) -> Bool {
        if desiredTotal <= maxChoosableInteger { return true }
        if maxChoosableInteger * (maxChoosableInteger+1) / 2 < desiredTotal { return false }

        var cache = [Int: Bool]()
        print(cache)
        return check(desiredTotal, maxChoosableInteger, 0, &cache)
    }

    func check(_ target: Int, _ maxChoosableInteger: Int,
               _ state: Int, _ cache: inout [Int: Bool]) -> Bool {
        if let val = cache[state] { return val }

        for i in 1...maxChoosableInteger {
            if state & (1<<(i-1)) != 0 { continue }
            // another player lose at target - i,
            // which means first player win at target
            if target <= i
            || !check(target-i, maxChoosableInteger, state | (1<<(i-1)), &cache) {
                cache[state] = true
                return true
            }
        }
        cache[state] = false
        return false
    }
}