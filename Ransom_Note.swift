/*
Given two stings ransomNote and magazine, return true if ransomNote can be constructed from magazine and false otherwise.

Each letter in magazine can only be used once in ransomNote.



Example 1:

Input: ransomNote = "a", magazine = "b"
Output: false
Example 2:

Input: ransomNote = "aa", magazine = "ab"
Output: false
Example 3:

Input: ransomNote = "aa", magazine = "aab"
Output: true


Constraints:

1 <= ransomNote.length, magazine.length <= 105
ransomNote and magazine consist of lowercase English letters.
*/

/*
Solution 2:
use charArr

Time Complexity: O(n)
- n is max(magazine.count, ransomNote.count)
Space Complexity: O(1)
*/
class Solution {
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        if ransomNote.count > magazine.count { return false }

        let asciia = Character("a").asciiValue!
        var arr = Array(repeating: 0, count: 26)
        for c in magazine {
            let index = Int(c.asciiValue! - asciia)
            arr[index] += 1
         }

        for c in ransomNote {
            let index = Int(c.asciiValue! - asciia)
            arr[index] -= 1
            if arr[index] < 0 {
                return false
            }
        }
        return true
    }
}

/*
Solution 1:
use map to record if there is any char out of limit

Time Complexity: O(n)
Space Complexity: O(1) - will at most have 26 chars

n is max(ransomNote.count, magazine.count)
*/
class Solution {
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var map = [Character: Int]()
        for c in magazine {
            map[c, default: 0] += 1
        }
        for c in ransomNote {
            map[c, default: 0] -= 1
            if map[c]! < 0 { return false }
        }
        return true
    }
}