/*
Given an array of strings strs, group the anagrams together. You can return the answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

 

Example 1:

Input: strs = ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
Example 2:

Input: strs = [""]
Output: [[""]]
Example 3:

Input: strs = ["a"]
Output: [["a"]]
 

Constraints:

1 <= strs.length <= 104
0 <= strs[i].length <= 100
strs[i] consists of lower-case English letters.
*/

/*
Solution 2:
caterize by count

26 char
abbccc -> [1, 2, 3, ... , 0]

Time Complexity: O(ns)
Space Complexity: O(ns)
*/

class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var map = [[Int]: [String]]()
        
        let aAscii = Character("a").asciiValue!
        for s in strs {
            var arr = Array(repeating: 0, count: 26)
            for c in s {
                arr[Int(c.asciiValue! - aAscii)] += 1
            }
            
            map[arr, default: [String]()].append(s)
        }
        // print(map)
        return Array(map.values)
    }
}

/*
Solution 1:
map
caterize by sorted string

Time Complexity: O(n*slogs)
- n is length of strs
- k is maximum length of a string in strs
Space Complexity: O(ns)
*/
class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var map = [String: [String]]()
        for s in strs {
            map[String(s.sorted()), default: [String]()].append(s)
        }
        return Array(map.values)
    }
}