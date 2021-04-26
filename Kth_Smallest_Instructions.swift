/*
Bob is standing at cell (0, 0), and he wants to reach destination: (row, column). He can only travel right and down. You are going to help Bob by providing instructions for him to reach destination.

The instructions are represented as a string, where each character is either:

'H', meaning move horizontally (go right), or
'V', meaning move vertically (go down).
Multiple instructions will lead Bob to destination. For example, if destination is (2, 3), both "HHHVV" and "HVHVH" are valid instructions.

However, Bob is very picky. Bob has a lucky number k, and he wants the kth lexicographically smallest instructions that will lead him to destination. k is 1-indexed.

Given an integer array destination and an integer k, return the kth lexicographically smallest instructions that will take Bob to destination.



Example 1:



Input: destination = [2,3], k = 1
Output: "HHHVV"
Explanation: All the instructions that reach (2, 3) in lexicographic order are as follows:
["HHHVV", "HHVHV", "HHVVH", "HVHHV", "HVHVH", "HVVHH", "VHHHV", "VHHVH", "VHVHH", "VVHHH"].
Example 2:



Input: destination = [2,3], k = 2
Output: "HHVHV"
Example 3:



Input: destination = [2,3], k = 3
Output: "HHVVH"


Constraints:

destination.length == 2
1 <= row, column <= 15
1 <= k <= nCr(row + column, row), where nCr(a, b) denotes a choose b​​​​​.
*/

/*
Solution 1:

nCr(a, b), or "a choose b" as they put it, is the number of ways that you can select b elements from a set of a unique elements. Let's consider nCr(3, 2) for example: that means we have 3 unique elements - 000. Let 1 represent an element that we've selected: there are three ways to select exactly 2 elements, shown below:
- 011
- 101
- 110
You don't need the formula for nCr(a, b) since your language most likely has it as a library, but here it is if you're interested (! is the factorial function):
- nCr(a, b) = (a!) / ((b!) * (a - b)!)

If we have r + c total elements and r of those elements are "V", then we have nCr(r + c, r) possible instruction sets that Bob can walk. At each of his r + c total steps, we have two options:
- Walk right one column, which will leave us with the same number of "V"'s
- Walk down one row, which will decrease our number of "V"'s by 1 (remember that we only have r of these!)

If we choose to walk down a row when we have N more steps and R possible rows left to walk down (including the current step), then we're cutting out the number of combinations of (N - 1) steps with R rows to walk down, because all of those combinations would result in a lexicographically smaller instruction set.

for each step where we have N more possible steps (including the current step), calculate nCr(N - 1, R). If k is less than or equal to this number, travel horizontally. Otherwise, subtract that number from k, decrease the number of vertical movements we're allowed to make, and then travel vertically.
*/

class Solution {
    func kthSmallestPath(_ destination: [Int], _ k: Int) -> String {
        let r = destination[0]
        let c = destination[1]

        var res = String()
        var remainDown = r
        var k = k

        for i in 0..<(r+c) {
            let remainSteps = r + c - (i+1)
            let combination = getCombination(remainSteps, remainDown)
            // print("loop", i, remainSteps, remainDown, k, combination)
            if combination >= k {
                // can go right
                res.append("H")
            } else {
                // for keep lexicographically order
                // go down
                remainDown -= 1
                k -= combination
                res.append("V")
            }
        }
        return res
    }

    // factorial cache
    // use Decimal to avoid factorial number overflow
    var cacheF: [Int: Decimal] = [
        0: 1,
        1: 1
    ]
    func factorial(_ num: Int) -> Decimal {
        if let val = cacheF[num] { return val }
        cacheF[num] = Decimal(num) * factorial(num-1)
        return cacheF[num]!
    }

    // a! / (b! * (a-b)!)
    func getCombination(_ a: Int, _ b: Int) -> Int {
        // combinatino, when b > a, return 0
        // https://en.wikipedia.org/wiki/Combination
        if b > a { return 0 }
        let decimal = factorial(a) / (factorial(b) * factorial(a-b))
        // convert Decimal to Int
        return NSDecimalNumber(decimal: decimal).intValue
    }
}