/*
Given a string s and an integer k, return the length of the longest substring of s such that the frequency of each character in this substring is greater than or equal to k.

 

Example 1:

Input: s = "aaabb", k = 3
Output: 3
Explanation: The longest substring is "aaa", as 'a' is repeated 3 times.
Example 2:

Input: s = "ababbc", k = 2
Output: 5
Explanation: The longest substring is "ababb", as 'a' is repeated 2 times and 'b' is repeated 3 times.
 

Constraints:

1 <= s.length <= 104
s consists of only lowercase English letters.
1 <= k <= 105
*/

/*
Solution 2:
recursive 

filter invalid, then check all valid sub part

Time Compexitly: O(n^2)
Space Compexitly: O(n)
*/
class Solution {
    func longestSubstring(_ s: String, _ k: Int) -> Int {
        var s = Array(s)
        let n = s.count
        
        var freq = [Character: Int]()
        for c in s {
            freq[c, default: 0] += 1
        }
        
        var invalid = Set<Character>()
        for (key, val) in freq {
            if val < k {
                invalid.insert(key)
            }
        }
        
        if invalid.isEmpty { return n }
        
        var sub = 0
        var index = 0
        
        for (i, c) in s.enumerated() {
            if invalid.contains(c) {
                if index != i {
                    sub = max(sub, longestSubstring(String(s[index..<i]), k))
                }
                index = i + 1
            }
        }
        
        if index < n {
            sub = max(sub, longestSubstring(String(s[index..<n]), k))
        }
        
        return sub
    }
}

/*
Solution 1:
sliding window

- count maxUnique char first
- then by checking curUnique to find longest substring

Time Complexity: O(maxUnique * N)
Space Complexity: O(1)
*/
class Solution {
    func longestSubstring(_ s: String, _ k: Int) -> Int {
        var s = Array(s)
        let n = s.count
        
        var sub = 0
        
        let maxUnique = getMaxUnique(s)
        
        var map = [Character: Int]()
        for curUnique in 1...maxUnique {
            // reset map
            map = [Character: Int]()
            
            var left = 0
            var right = 0
            var unique = 0
            var countAtLeastK = 0
            while right < n {
                if unique <= curUnique {
                    if map[s[right]] == nil {
                        unique += 1
                    }
                    map[s[right], default: 0] += 1
                    if map[s[right]] == k {
                        countAtLeastK += 1
                    }
                    right += 1
                } else {
                    if map[s[left]] == k {
                        countAtLeastK -= 1
                    }
                    map[s[left]]! -= 1
                    if map[s[left]] == 0 {
                        map[s[left]] = nil
                        unique -= 1
                    }
                    left += 1
                }
                
                if unique == curUnique, 
                unique == countAtLeastK {
                    sub = max(sub, right-left)
                }
            }
        }
        return sub
    }
    
    func getMaxUnique(_ s: [Character]) -> Int {
        var set = Set<Character>()
        var maxUnique = 0
        for c in s {
            if !set.contains(c) {
                maxUnique += 1
                set.insert(c)
            }
        }
        return maxUnique
    }
}