/*
You are given an array of strings equations that represent relationships between variables where each string equations[i] is of length 4 and takes one of two different forms: "xi==yi" or "xi!=yi".Here, xi and yi are lowercase letters (not necessarily different) that represent one-letter variable names.

Return true if it is possible to assign integers to variable names so as to satisfy all the given equations, or false otherwise.



Example 1:

Input: equations = ["a==b","b!=a"]
Output: false
Explanation: If we assign say, a = 1 and b = 1, then the first equation is satisfied, but not the second.
There is no way to assign the variables to satisfy both equations.
Example 2:

Input: equations = ["b==a","a==b"]
Output: true
Explanation: We could assign a = 1 and b = 1 to satisfy both equations.


Constraints:

1 <= equations.length <= 500
equations[i].length == 4
equations[i][0] is a lowercase letter.
equations[i][1] is either '=' or '!'.
equations[i][2] is '='.
equations[i][3] is a lowercase letter.
*/

/*
Solution 1:
UF (union find)

since the equation parameter is all lowercase character
can simple map them into 26 integer array

for all equal equations, link them together
then for non-equal equations, if find two param is equal, return false

Time Complexity: O(n^2)
Space Complexity: O(1)
*/
class Solution {
    func equationsPossible(_ equations: [String]) -> Bool {
        let n = equations.count

        // all of != equations
        var notEqual = [String]()
        var doEqual = [String]()
        for e in equations {
            if getChar(e, 1) == Character("!") {
                notEqual.append(e)
            } else {
                doEqual.append(e)
            }
        }

        let asciia = Character("a").asciiValue!

        // build equal UF
        let uf = UF(26)

        // for all equals, union them together
        for e in doEqual {
            uf.union(getIndex(getChar(e, 0)), getIndex(getChar(e, 3)))
        }

        for e in notEqual {
            // if two parent is equal,
            // means there is a equal function
            if uf.find(getIndex(getChar(e, 0))) == uf.find(getIndex(getChar(e, 3))) {
                // has both equal and not equal function
                return false
            }
        }
        return true
    }

    // help quick find index
    // a,b,c,d,e -> 0,1,2,3,4
    func getIndex(_ c: Character) -> Int {
        return Int(c.asciiValue! - Character("a").asciiValue!)
    }

    // give integer, return str[integer]'s character
    func getChar(_ str: String, _ index: Int) -> Character {
        return str[str.index(str.startIndex, offsetBy: index)]
    }
}

class UF {
    var parent: [Int]
    init(_ n: Int) {
        parent = Array(0..<n)
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func union(_ x: Int, _ y: Int) {
        if find(x) != find(y) {
            parent[find(x)] = find(y)
        }
    }
}
