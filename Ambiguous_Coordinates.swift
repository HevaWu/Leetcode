/*
We had some 2-dimensional coordinates, like "(1, 3)" or "(2, 0.5)".  Then, we removed all commas, decimal points, and spaces, and ended up with the string s.  Return a list of strings representing all possibilities for what our original coordinates could have been.

Our original representation never had extraneous zeroes, so we never started with numbers like "00", "0.0", "0.00", "1.0", "001", "00.01", or any other number that can be represented with less digits.  Also, a decimal point within a number never occurs without at least one digit occuring before it, so we never started with numbers like ".1".

The final answer list can be returned in any order.  Also note that all coordinates in the final answer have exactly one space between them (occurring after the comma.)

Example 1:
Input: s = "(123)"
Output: ["(1, 23)", "(12, 3)", "(1.2, 3)", "(1, 2.3)"]
Example 2:
Input: s = "(00011)"
Output:  ["(0.001, 1)", "(0, 0.011)"]
Explanation:
0.0, 00, 0001 or 00.01 are not allowed.
Example 3:
Input: s = "(0123)"
Output: ["(0, 123)", "(0, 12.3)", "(0, 1.23)", "(0.1, 23)", "(0.1, 2.3)", "(0.12, 3)"]
Example 4:
Input: s = "(100)"
Output: [(10, 0)]
Explanation:
1.0 is not allowed.


Note:

4 <= s.length <= 12.
s[0] = "(", s[s.length - 1] = ")", and the other elements in s are digits.
*/

/*
Solution 1:
string

- check place where we can insert ,
- then for left, right 2 parts, check if we can generate any possible decimal value

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func ambiguousCoordinates(_ s: String) -> [String] {
        var s = Array(s)
        s.removeFirst()
        s.removeLast()

        // s is a digit only string
        let n = s.count

        var res = [String]()

        // we can insert "," at 1...n-1 position
        for i in 1..<n {
            let first = Array(s[..<i])
            let firstTry = check(first)
            if firstTry.isEmpty { continue }

            let second = Array(s[i...])
            let secondTry = check(second)
            if secondTry.isEmpty { continue }

            for f in firstTry {
                for s in secondTry {
                    let temp = "(" + f + ", " + s + ")"
                    res.append(temp)
                }
            }
        }
        return res
    }

    // find all s can generate decimal value
    func check(_ s: [Character]) -> [String] {
        if s.count == 1 {
            return [String(s)]
        }

        var res = [String]()

        // try to check if we can add any "." to make s valid
        let m = s.count
        if s[0] == "0" {
            // first digit is 0, we can only possible append digit at 1,
            // otherwise, it might shorten digit

            if Set(s).count == 1 || s[m-1] == "0" {
                // current s only contains 0, cannot append any "."
                // current s last digit is 0, append any "." might shorten value
                return res
            }

            var temp = s
            temp.insert(".", at: 1)
            res.append(String(temp))
            return res
        }

        // for remaining, first is not 0, current s itself should be valid value
        res.append(String(s))

        if s[m-1] == "0" {
            // last digit is 0, if we add . might shorten coordinate value
            // we cannot add any "."
            return res
        }

        // all remaining should be valid with adding `.`
        for i in 1..<m {
            var temp = s
            temp.insert(".", at: i)
            res.append(String(temp))
        }
        return res
    }
}