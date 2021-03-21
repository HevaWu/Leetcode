/*
Given a string s and a non-empty string p, find all the start indices of p's anagrams(回文) in s.

Strings consists of lowercase English letters only and the length of both strings s and p will not be larger than 20,100.

The order of output does not matter.

Example 1:

Input:
s: "cbaebabacd" p: "abc"

Output:
[0, 6]

Explanation:
The substring with start index = 0 is "cba", which is an anagram of "abc".
The substring with start index = 6 is "bac", which is an anagram of "abc".
Example 2:

Input:
s: "abab" p: "ab"

Output:
[0, 1, 2]

Explanation:
The substring with start index = 0 is "ab", which is an anagram of "ab".
The substring with start index = 1 is "ba", which is an anagram of "ab".
The substring with start index = 2 is "ab", which is an anagram of "ab".
*/

/*
Solution 2:
build int array of 2 string
and compare base(p array) and cur(s array checking part)

Time Complexity: O(n_s + n_p)
Space Complexity: O(n_s + n_p)
*/
class Solution {
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        guard s.count >= p.count else { return [] }
        
        let ascii_a = Character("a").asciiValue!
        var s = s.map { Int($0.asciiValue! - ascii_a) }
        var p = p.map { Int($0.asciiValue! - ascii_a) }
        
        var base = Array(repeating: 0, count: 26)
        var cur = Array(repeating: 0, count: 26)
        
        for val in p {
            base[val] += 1
        }
        
        let n_p = p.count
        var anagram = [Int]()
        
        for right in 0..<s.count {
            let val = s[right]
            cur[val] += 1
            let start = right-n_p
            if start >= 0 {
                cur[s[start]] -= 1
            }
            
            if cur == base {
                // Note: start+1 is correct start index
                anagram.append(start+1)
            }
        }
        
        return anagram
    }
}

/*
Solution 1:
map
iterative check

- build map_p for store p's char and frequency
- 2 window check string s

Time Complexity: O(n_p + n_s ^ 2)
Space Complexity: O(n_p)
*/
class Solution {
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        guard s.count >= p.count else { return [] }
        
        var s = Array(s)
        
        // [char, freq]
        var map_p = [Character: Int]()
        for c in p {
            map_p[c, default: 0] += 1
        }
        
        let n_p = p.count
        let n_s = s.count
        
        var findMap = [Character: Int]()
        var founded = 0
        
        var left = 0
        var right = 0
        
        var anagram = [Int]()
        while right < n_s {
            let c = s[right]
            findMap[c, default: 0] += 1
            
            if map_p[c] == nil {
                // find one char not in p
                right += 1
                left = right
                findMap = [Character: Int]()
                founded = 0
                
                continue
            }
            
            if findMap[c]! <= map_p[c]! {
                founded += 1
                
                if founded == n_p {
                    // find one anagram
                    anagram.append(left)

                    findMap[s[left]]! -= 1
                    left += 1
                    founded -= 1
                }
            } else {
                // move left until findMap[s[i]] <= map_p[s[i]]
                while left <= right, s[left] != c {
                    findMap[s[left]]! -= 1
                    left += 1
                    founded -= 1
                }
                findMap[s[left]]! -= 1
                left += 1
            }
            // print(c, left, right, founded)
            right += 1
        }
        
        return anagram
    }
}