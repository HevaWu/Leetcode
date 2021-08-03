/*
We are stacking blocks to form a pyramid. Each block has a color which is a one-letter string.

We are allowed to place any color block C on top of two adjacent blocks of colors A and B, if and only if ABC is an allowed triple.

We start with a bottom row of bottom, represented as a single string. We also start with a list of allowed triples allowed. Each allowed triple is represented as a string of length 3.

Return true if we can build the pyramid all the way to the top, otherwise false.



Example 1:

Input: bottom = "BCD", allowed = ["BCG","CDE","GEA","FFF"]
Output: true
Explanation:
We can stack the pyramid like this:
    A
   / \
  G   E
 / \ / \
B   C   D

We are allowed to place G on top of B and C because BCG is an allowed triple.  Similarly, we can place E on top of C and D, then A on top of G and E.
Example 2:

Input: bottom = "AABA", allowed = ["AAA","AAB","ABA","ABB","BAC"]
Output: false
Explanation:
We cannot stack the pyramid to the top.
Note that there could be allowed triples (A, B, C) and (A, B, D) with C != D.


Constraints:

2 <= bottom.length <= 8
0 <= allowed.length <= 200
allowed[i].length == 3
The letters in all input strings are from the set {'A', 'B', 'C', 'D', 'E', 'F', 'G'}.
*/

/*
Solution 2:
instead of build pyramid
only keep tracking its latest row

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func pyramidTransition(_ bottom: String, _ allowed: [String]) -> Bool {
        var map = [String: [Character]]()
        for str in allowed {
            var temp = str
            let c = temp.removeLast()
            map[temp, default: [Character]()].append(c)
        }

        let n = bottom.count
        var pre = Array(bottom)
        var cur = Array(repeating: Character("*"), count: n)

        // try to buid pyramid from 1..<n
        return build(0, n-1, pre, cur, map)
    }

    func build(_ index: Int, _ size: Int,
               _ pre: [Character], _ cur: [Character],
               _ map: [String: [Character]]) -> Bool {
        if size == 0 { return true }

        var key = String()
        key.append(pre[index])
        key.append(pre[index+1])

        if let list = map[key] {
            var cur = cur
            for char in list {
                cur[index] = char

                // try to check next
                if index < size-1 {
                    if build(index+1, size, pre, cur, map) {
                        return true
                    }
                } else if index == size-1 {
                    // check next row
                    var next = Array(repeating: Character("*"), count: size)
                    if build(0, size-1, cur, next, map) {
                        return true
                    }
                }
            }
            return false
        } else {
            // cannot find proper triple
            return false
        }
    }
}

/*
Solution 1:
build pyramid

use map to store prefix 2 chars of allowed strings
map key: prefix 2 chars of allowed strings
map value: last char of allowed string

use map we can quick find possible next char to put on top of bottom 2 adjacent cells
iteratively build possible pyramid
stop when r == -1

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func pyramidTransition(_ bottom: String, _ allowed: [String]) -> Bool {
        var map = [String: [Character]]()
        for str in allowed {
            var temp = str
            let c = temp.removeLast()
            map[temp, default: [Character]()].append(c)
        }

        let n = bottom.count
        var pyramid: [[Character]] = Array(
            repeating: Array(repeating: Character("*"), count: n),
            count: n
        )
        pyramid[n-1] = Array(bottom)

        // try to buid pyramid from 1..<n
        return build(n-2, 0, n, &pyramid, map)
    }

    func build(_ r: Int, _ c: Int, _ n: Int,
               _ pyramid: inout [[Character]],
               _ map: [String: [Character]]) -> Bool {
        // defer{ print(pyramid) }
        if r == -1 { return true }

        var key = String()
        key.append(pyramid[r+1][c])
        key.append(pyramid[r+1][c+1])

        if let list = map[key] {
            for char in list {
                pyramid[r][c] = char
                // try to check next
                if c < r {
                    if build(r, c+1, n, &pyramid, map) {
                        return true
                    }
                } else if c == r {
                    // check next row
                    if build(r-1, 0, n, &pyramid, map) {
                        return true
                    }
                }
            }
            return false
        } else {
            // cannot find proper triple
            return false
        }
    }
}