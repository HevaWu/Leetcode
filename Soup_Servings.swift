/*
There are two types of soup: type A and type B. Initially, we have n ml of each type of soup. There are four kinds of operations:

Serve 100 ml of soup A and 0 ml of soup B,
Serve 75 ml of soup A and 25 ml of soup B,
Serve 50 ml of soup A and 50 ml of soup B, and
Serve 25 ml of soup A and 75 ml of soup B.
When we serve some soup, we give it to someone, and we no longer have it. Each turn, we will choose from the four operations with an equal probability 0.25. If the remaining volume of soup is not enough to complete the operation, we will serve as much as possible. We stop once we no longer have some quantity of both types of soup.

Note that we do not have an operation where all 100 ml's of soup B are used first.

Return the probability that soup A will be empty first, plus half the probability that A and B become empty at the same time. Answers within 10-5 of the actual answer will be accepted.



Example 1:

Input: n = 50
Output: 0.62500
Explanation: If we choose the first two operations, A will become empty first.
For the third operation, A and B will become empty at the same time.
For the fourth operation, B will become empty first.
So the total probability of A becoming empty first plus half the probability that A and B become empty at the same time, is 0.25 * (1 + 1 + 0.5 + 0) = 0.625.
Example 2:

Input: n = 100
Output: 0.71875


Constraints:

0 <= n <= 109
*/

/*
Solution 2:
clean up of Solution 1

Time Complexity: O(200 * 200)
Space Complexity: O(200 * 200)
*/
class Solution {
    func soupServings(_ n: Int) -> Double {
        // When N = 4800, the result = 0.999994994426
        // When N = 4801, the result = 0.999995382315
        if n >= 4800 { return 1.0 }

        var res: Double = check((n+24)/25, (n+24)/25)
        res = Double(Int(res * 100_000)) / 100_000.0
        return res
    }

    // key is [A, B]
    // res is possibility
    var cache = [[Int]: Double]()
    func check(_ A: Int, _ B: Int) -> Double {
        let key = [A, B]
        if let val = cache[key] { return val }

        if A <= 0, B <= 0 { return 0.5 }
        if A <= 0 { return 1 }
        if B <= 0 { return 0 }

        var val: Double = 0.25 * (check(A - 4, B) + check(A-3, B-1) + check(A-2, B-2) + check(A-1, B-3))
        cache[key] = val
        return val
    }
}

/*
Solution 1:
backtracking with memorization
*/
class Solution {
    func soupServings(_ n: Int) -> Double {
        // When N = 4800, the result = 0.999994994426
        // When N = 4801, the result = 0.999995382315
        if n >= 4800 { return 1.0 }

        var res: Double = check(n, n)
        res = Double(Int(res * 100_000)) / 100_000.0
        return res
    }

    // key is [A, B]
    // res is possibility
    var cache = [[Int]: Double]()
    func check(_ A: Int, _ B: Int) -> Double {
        let key = [A, B]
        if let val = cache[key] { return val }

        var val: Double = 0

        val += 0.25 * canWin(A - 100, B)
        val += 0.25 * canWin(A - 75, B - 25)
        val += 0.25 * canWin(A - 50, B - 50)
        val += 0.25 * canWin(A - 25, B - 75)

        cache[key] = Double(Int(val * 100_000_000)) / 100_000_000
        return val
    }

    func canWin(_ newA: Int, _ newB: Int) -> Double {
        var val: Double = 0
        if newA <= 0 {
            // A can empty in this turn
            if newB <= 0 {
                // both A and B can empty
                val = 0.5
            } else {
                // only A can empty
                val = 1
            }
        } else {
            if newB > 0 {
                val = check(newA, newB)
            }
        }
        return val
    }
}