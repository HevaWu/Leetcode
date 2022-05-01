/*
You are given a string s, and an array of pairs of indices in the string pairs where pairs[i] = [a, b] indicates 2 indices(0-indexed) of the string.

You can swap the characters at any pair of indices in the given pairs any number of times.

Return the lexicographically smallest string that s can be changed to after using the swaps.



Example 1:

Input: s = "dcab", pairs = [[0,3],[1,2]]
Output: "bacd"
Explaination:
Swap s[0] and s[3], s = "bcad"
Swap s[1] and s[2], s = "bacd"
Example 2:

Input: s = "dcab", pairs = [[0,3],[1,2],[0,2]]
Output: "abcd"
Explaination:
Swap s[0] and s[3], s = "bcad"
Swap s[0] and s[2], s = "acbd"
Swap s[1] and s[2], s = "abcd"
Example 3:

Input: s = "cba", pairs = [[0,1],[1,2]]
Output: "abc"
Explaination:
Swap s[0] and s[1], s = "bca"
Swap s[1] and s[2], s = "bac"
Swap s[0] and s[1], s = "abc"


Constraints:

1 <= s.length <= 10^5
0 <= pairs.length <= 10^5
0 <= pairs[i][0], pairs[i][1] < s.length
s only contains lower case English letters.
*/

/*
Solution 1 :
Union Find

TLE

Time Complexity: O((E+V)⋅α(V)+VlogV)
Space Complexity: O(n)
*/
class Solution {
    func smallestStringWithSwaps(_ s: String, _ pairs: [[Int]]) -> String {
        var s = Array(s)

        let uf = UF(s.count)
        for pair in pairs {
            uf.union(pair[0], pair[1])
        }

        var group = [Int: [Int]]()
        for i in 0..<s.count {
            group[uf.find(i), default: [Int]()].append(i)
        }

        for list in group.values {
            var charList: [Character] = list.map { s[$0] }
            charList.sort()

            // put sorted lexicographically char back to s
            for i in 0..<list.count {
                s[list[i]] = charList[i]
            }
        }

        // convert char array back to string
        return String(s)
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
        let px = find(x)
        let py = find(y)
        if px != py {
            parent[px] = py
        }
    }
}