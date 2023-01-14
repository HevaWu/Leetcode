/*
You are given two strings of the same length s1 and s2 and a string baseStr.

We say s1[i] and s2[i] are equivalent characters.

For example, if s1 = "abc" and s2 = "cde", then we have 'a' == 'c', 'b' == 'd', and 'c' == 'e'.
Equivalent characters follow the usual rules of any equivalence relation:

Reflexivity: 'a' == 'a'.
Symmetry: 'a' == 'b' implies 'b' == 'a'.
Transitivity: 'a' == 'b' and 'b' == 'c' implies 'a' == 'c'.
For example, given the equivalency information from s1 = "abc" and s2 = "cde", "acd" and "aab" are equivalent strings of baseStr = "eed", and "aab" is the lexicographically smallest equivalent string of baseStr.

Return the lexicographically smallest equivalent string of baseStr by using the equivalency information from s1 and s2.



Example 1:

Input: s1 = "parker", s2 = "morris", baseStr = "parser"
Output: "makkek"
Explanation: Based on the equivalency information in s1 and s2, we can group their characters as [m,p], [a,o], [k,r,s], [e,i].
The characters in each group are equivalent and sorted in lexicographical order.
So the answer is "makkek".
Example 2:

Input: s1 = "hello", s2 = "world", baseStr = "hold"
Output: "hdld"
Explanation: Based on the equivalency information in s1 and s2, we can group their characters as [h,w], [d,e,o], [l,r].
So only the second letter 'o' in baseStr is changed to 'd', the answer is "hdld".
Example 3:

Input: s1 = "leetcode", s2 = "programs", baseStr = "sourcecode"
Output: "aauaaaaada"
Explanation: We group the equivalent characters in s1 and s2 as [a,o,e,r,s,c], [l,p], [g,t] and [d,m], thus all letters in baseStr except 'u' and 'd' are transformed to 'a', the answer is "aauaaaaada".


Constraints:

1 <= s1.length, s2.length, baseStr <= 1000
s1.length == s2.length
s1, s2, and baseStr consist of lowercase English letters.
*/

/*
Solution 1:
UF

uf to union equal character
and always put the lower character as parent

Time Complexity: O(26 ^ 2 + n)
- n = s1.count = s2.count
Space Complexity: O(1)
*/
class Solution {
    func smallestEquivalentString(_ s1: String, _ s2: String, _ baseStr: String) -> String {
        // UF convert char to int
        let uf = UF(26)

        var s1 = Array(s1)
        var s2 = Array(s2)
        let chara = Character("a").asciiValue!
        for i in 0..<s1.count {
            // convert char to int
            let i1 = Int(s1[i].asciiValue! - chara)
            let i2 = Int(s2[i].asciiValue! - chara)
            uf.union(i1, i2)
        }

        var smallest = ""
        for i in baseStr.indices {
            let index = Int(baseStr[i].asciiValue! - chara)
            let p = uf.find(index)
            smallest.append(Character(UnicodeScalar(Int(chara) + p)!))
        }
        return smallest
    }
}

class UF {
    var parent: [Int]
    init(_ n: Int) {
        parent = Array(0..<n)
    }

    func find(_ x: Int) -> Int {
        if x != parent[x] {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func union(_ x: Int, _ y: Int) {
        let px = find(x)
        let py = find(y)
        if px != py {
            // always put set parent as lower one
            // to keep lexicographically
            if px < py {
                parent[py] = px
            } else {
                parent[px] = py
            }
        }
    }
}
