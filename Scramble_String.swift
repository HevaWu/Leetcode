/*
We can scramble a string s to get a string t using the following algorithm:

If the length of the string is 1, stop.
If the length of the string is > 1, do the following:
Split the string into two non-empty substrings at a random index, i.e., if the string is s, divide it to x and y where s = x + y.
Randomly decide to swap the two substrings or to keep them in the same order. i.e., after this step, s may become s = x + y or s = y + x.
Apply step 1 recursively on each of the two substrings x and y.
Given two strings s1 and s2 of the same length, return true if s2 is a scrambled string of s1, otherwise, return false.



Example 1:

Input: s1 = "great", s2 = "rgeat"
Output: true
Explanation: One possible scenario applied on s1 is:
"great" --> "gr/eat" // divide at random index.
"gr/eat" --> "gr/eat" // random decision is not to swap the two substrings and keep them in order.
"gr/eat" --> "g/r / e/at" // apply the same algorithm recursively on both substrings. divide at ranom index each of them.
"g/r / e/at" --> "r/g / e/at" // random decision was to swap the first substring and to keep the second substring in the same order.
"r/g / e/at" --> "r/g / e/ a/t" // again apply the algorithm recursively, divide "at" to "a/t".
"r/g / e/ a/t" --> "r/g / e/ a/t" // random decision is to keep both substrings in the same order.
The algorithm stops now and the result string is "rgeat" which is s2.
As there is one possible scenario that led s1 to be scrambled to s2, we return true.
Example 2:

Input: s1 = "abcde", s2 = "caebd"
Output: false
Example 3:

Input: s1 = "a", s2 = "a"
Output: true


Constraints:

s1.length == s2.length
1 <= s1.length <= 30
s1 and s2 consist of lower-case English letters.
*/

/*
Solution 2:
using cache to space memorize previous checked strings

Time Complexity: O(2^n)
Space Complexity: O(n^4)
*/
class Solution {
    let ascii_a = Character("a").asciiValue!

    var cache = [[[[Bool?]]]]()
    var s1 = [Character]()
    var s2 = [Character]()

    func isScramble(_ s1: String, _ s2: String) -> Bool {
        let n = s1.count
        cache = Array(
            repeating: Array(
                repeating: Array(
                    repeating: Array(
                        repeating: nil,
                        count: n
                    ),
                    count: n
                ),
                count: n
            ),
            count: n
        )

        self.s1 = Array(s1)
        self.s2 = Array(s2)

        return dfs(0, n-1, 0, n-1)
    }

    func dfs(_ s1s: Int, _ s1e: Int, _ s2s: Int, _ s2e: Int) -> Bool {
        if let val = cache[s1s][s1e][s2s][s2e] {
            return val
        }

        var res = true
        if s1[s1s...s1e] == s2[s2s...s2e] {
            res = true
        } else {
            var arr = Array(repeating: 0, count: 26)
            let len = s1e - s1s
            for i in 0...len {
                arr[Int(s1[s1s+i].asciiValue! - ascii_a)] += 1
                arr[Int(s2[s2s+i].asciiValue! - ascii_a)] -= 1
            }

            for i in 0..<26 {
                if arr[i] != 0 {
                    res = false
                    break
                }
            }

            if res {
                var temp = false

                for i in 1...len {
                    if dfs(s1s, s1s+i-1, s2s, s2s+i-1)
                    && dfs(s1s+i, s1e, s2s+i, s2e) {
                        temp = true
                        break
                    }

                    if dfs(s1s, s1s+i-1, s2e-i+1, s2e)
                    && dfs(s1s+i, s1e, s2s, s2e-i) {
                        temp = true
                        break
                    }
                }

                if !temp {
                    res = false
                }
            }
        }

        cache[s1s][s1e][s2s][s2e] = res
        return res
    }
}

/*
Solution 1:
Time Limit Exceeded
recursively checking

Time Complexity: O()
*/
class Solution {
    func isScramble(_ s1: String, _ s2: String) -> Bool {
        return _isScramble(Array(s1), Array(s2))
    }

    let ascii_a = Character("a").asciiValue!
    func _isScramble(_ s1: [Character], _ s2: [Character]) -> Bool {
        if s1 == s2 { return true }
        let n = s1.count

        var arr = Array(repeating: 0, count: 26)
        for i in 0..<n {
            arr[Int(s1[i].asciiValue! - ascii_a)] += 1
            arr[Int(s2[i].asciiValue! - ascii_a)] -= 1
        }

        for i in 0..<26 {
            if arr[i] != 0 { return false }
        }

        for i in 1..<n {
            if _isScramble(Array(s1[0..<i]), Array(s2[0..<i]))
            && _isScramble(Array(s1[i...]), Array(s2[i...])) {
                return true
            }
            if _isScramble(Array(s1[0..<i]), Array(s2[(n-i)...]))
            && _isScramble(Array(s1[i...]), Array(s2[0..<(n-i)])) {
                return true
            }
        }
        return false
    }
}