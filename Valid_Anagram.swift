// Given two strings s and t , write a function to determine if t is an anagram of s.

// Example 1:

// Input: s = "anagram", t = "nagaram"
// Output: true
// Example 2:

// Input: s = "rat", t = "car"
// Output: false
// Note:
// You may assume the string contains only lowercase alphabets.

// Follow up:
// What if the inputs contain unicode characters? How would you adapt your solution to such case?

// Solution 1: anagram 同字母异序词
// use map to help checking if the character exists
// 
// Time complexity: O(2n) <- search the array twice
// Space complexity: O(1). Although we do use extra space, the space complexity is O(1)O(1) because the table's size stays constant no matter how large nn is.
class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        
        var map = [Character: Int]()
        for c in s {
            map[c, default: 0] += 1
        }
        
        for c1 in t {
            if let cvalue = map[c1] {
                map[c1] = cvalue == 1 ? nil : cvalue - 1
            } else {
                return false
            }
        }
        
        return map.isEmpty
    }
}
