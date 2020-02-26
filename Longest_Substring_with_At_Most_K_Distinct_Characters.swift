// Given a string, find the length of the longest substring T that contains at most k distinct characters.

// Example 1:

// Input: s = "eceba", k = 2
// Output: 3
// Explanation: T is "ece" which its length is 3.
// Example 2:

// Input: s = "aa", k = 1
// Output: 2
// Explanation: T is "aa" which its length is 2.

// Solution1 : 2 pointers with map
// 
// Time complexity: O(n)
// Space complexity: O(n)
class Solution {
    func lengthOfLongestSubstringKDistinct(_ s: String, _ k: Int) -> Int {
        guard !s.isEmpty, k > 0 else { return 0 }
        
        var s = Array(s)
        var map = [Character: Int]()
        var left = 0
        var right = 0
        var dis = -1
        
        while right < s.count {
            map[s[right], default: 0] += 1
            
            while left <= right, map.keys.count > k {
                map[s[left]]! -= 1
                if map[s[left]]! == 0 {
                    map[s[left]] = nil
                }
                left += 1
            }
            dis = max(dis, right - left + 1)
            right += 1
        }
        return dis == -1 ? 0 : dis
    }
}