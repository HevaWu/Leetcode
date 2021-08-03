/*
A string s is nice if, for every letter of the alphabet that s contains, it appears both in uppercase and lowercase. For example, "abABB" is nice because 'A' and 'a' appear, and 'B' and 'b' appear. However, "abA" is not because 'b' appears, but 'B' does not.

Given a string s, return the longest substring of s that is nice. If there are multiple, return the substring of the earliest occurrence. If there are none, return an empty string.



Example 1:

Input: s = "YazaAay"
Output: "aAa"
Explanation: "aAa" is a nice string because 'A/a' is the only letter of the alphabet in s, and both 'A' and 'a' appear.
"aAa" is the longest nice substring.
Example 2:

Input: s = "Bb"
Output: "Bb"
Explanation: "Bb" is a nice string because both 'B' and 'b' appear. The whole string is a substring.
Example 3:

Input: s = "c"
Output: ""
Explanation: There are no nice substrings.
Example 4:

Input: s = "dDzeE"
Output: "dD"
Explanation: Both "dD" and "eE" are the longest nice substrings.
As there are multiple longest nice substrings, return "dD" since it occurs earlier.


Constraints:

1 <= s.length <= 100
s consists of uppercase and lowercase English letters.
*/

/*
Solution 2:
split string once we find a char which its lowercase or uppercase not in current s
then recursively check its left/right part and find longer substring

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func longestNiceSubstring(_ s: String) -> String {
        var s = Array(s)
        var strSet = Set(s.map{ String($0) })

        for i in 0..<s.count {
            let c = s[i]
            if strSet.contains(c.uppercased()), strSet.contains(c.lowercased()) {
                continue
            }
            // split to check its left and right part
            let left = longestNiceSubstring(String(s[..<i]))
            let right = longestNiceSubstring(String(s[(i+1)...]))
            if left.count >= right.count {
                return left
            } else {
                return right
            }
        }

        return String(s)
    }
}

/*
Solution 1:
brute force check all possible substrings

Time Complexity: O(n*n*n)
Space Complexity: O(n)
*/
class Solution {
    func longestNiceSubstring(_ s: String) -> String {
        var s = Array(s)
        let n = s.count
        var nice = [Character]()
        for i in 0..<(n-1) {
            for j in stride(from: n-1, through: i+1, by: -1) {
                if isNice(s, i, j), j-i+1 > nice.count {
                    nice = Array(s[i...j])
                    break
                }
            }
        }
        return String(nice)
    }

    func isNice(_ s: [Character], _ i: Int, _ j: Int) -> Bool {
        var lower = Set<Character>()
        var upper = Set<Character>()

        for index in i...j {
            let c = s[index]
            if c.isLowercase {
                lower.insert(c)
            } else if c.isUppercase {
                upper.insert(c)
            }
        }

        // print(i, j, lower, upper)

        var val = false
        for c in lower {
            if !upper.contains(c.uppercased().first!) {
                return false
            }
        }
        return lower.count == upper.count
    }
}