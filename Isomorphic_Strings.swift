// Given two strings s and t, determine if they are isomorphic.

// Two strings are isomorphic if the characters in s can be replaced to get t.

// All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character but a character may map to itself.

// Example 1:

// Input: s = "egg", t = "add"
// Output: true
// Example 2:

// Input: s = "foo", t = "bar"
// Output: false
// Example 3:

// Input: s = "paper", t = "title"
// Output: true
// Note:
// You may assume both s and t have the same length.


// Isomorphic 同形

// Solution 1: 2 map
// 
// Time complexity: O(1)
// Space complexity: O(2n) <- 2 map
class Solution {
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        var s2tmap = [Character: Character]()
        var t2smap = [Character: Character]()
        for i in s.indices {
            if let tc = s2tmap[s[i]] {
                if t[i] != tc {
                    return false
                }
            } else {
                s2tmap[s[i]] = t[i]
                if let sc = t2smap[t[i]] {
                    if s[i] != sc {
                        return false
                    }
                } else {
                    t2smap[t[i]] = s[i]
                }
            }
        }
        return true
    }
}

// Solution 2: one map
// 
// Time complexity: O(1)
// Space complexity: O(n)
class Solution {
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        var map = [Character: Character]()
        for i in s.indices {
            if let tc = map[s[i]] {
                if t[i] != tc {
                    return false
                }
            } else {
                if map.values.contains(t[i]) {
                    return false
                } else {
                    map[s[i]] = t[i]   
                }
            }
        }
        return true
    }
}