/*
Given three integers x, y, and bound, return a list of all the powerful integers that have a value less than or equal to bound.

An integer is powerful if it can be represented as xi + yj for some integers i >= 0 and j >= 0.

You may return the answer in any order. In your answer, each value should occur at most once.



Example 1:

Input: x = 2, y = 3, bound = 10
Output: [2,3,4,5,7,9,10]
Explanation:
2 = 20 + 30
3 = 21 + 30
4 = 20 + 31
5 = 21 + 31
7 = 22 + 31
9 = 23 + 30
10 = 20 + 32
Example 2:

Input: x = 3, y = 5, bound = 15
Output: [2,4,6,8,10,14]


Constraints:

1 <= x, y <= 100
0 <= bound <= 106
*/


/*
Solution 1:
Logartihmic Bounds

Idea
- find xlimit, ylimit
- see if pow sum in the bound or not

Time Complexity: O(xlimit * ylimit)
Space Complexity: O(1)
*/
class Solution {
    func powerfulIntegers(_ x: Int, _ y: Int, _ bound: Int) -> [Int] {
        var pset = Set<Int>()

        // use log10, we need to check if x == 1 or not, if so, assign it as 1
        let xlimit = x == 1 ? 1 : Int(log10(Double(bound)) / log10(Double(x)) + 1)
        let ylimit = y == 1 ? 1 : Int(log10(Double(bound)) / log10(Double(y)) + 1)

        var x = Double(x)
        var y = Double(y)

        for px in 0..<xlimit {
            for py in 0..<ylimit {
                let num = Int(pow(x, Double(px)) + pow(y, Double(py)))
                if num <= bound {
                    pset.insert(num)
                } else {
                    break
                }
            }
        }

        return Array(pset)
    }
}