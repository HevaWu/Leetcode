/*
Implement strStr().

Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

Clarification:

What should we return when needle is an empty string? This is a great question to ask during an interview.

For the purpose of this problem, we will return 0 when needle is an empty string. This is consistent to C's strstr() and Java's indexOf().

 

Example 1:

Input: haystack = "hello", needle = "ll"
Output: 2
Example 2:

Input: haystack = "aaaaa", needle = "bba"
Output: -1
Example 3:

Input: haystack = "", needle = ""
Output: 0
 

Constraints:

0 <= haystack.length, needle.length <= 5 * 104
haystack and needle consist of only lower-case English characters.
*/

/*
Solution 2:
use hasPrefix()
*/
class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.isEmpty { return 0 }
        
        var haystack = haystack
        var res = 0
        
        while needle.count <= haystack.count {
            if haystack.hasPrefix(needle) {
                return res
            } else {
                haystack.removeFirst()
                res += 1
            }
        }
        
        return -1
    }
}

/*
Solution 1

go through 2 string
use prei to mark pre checked haystack[i] == needle[0]

Time Complexity: O(nh)
Space Complexity: O(n + h)
*/
class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.isEmpty { return 0 }
        
        var haystack = Array(haystack)
        var needle = Array(needle)
        
        guard var i = haystack.firstIndex(of: needle[0]) else { return -1 }
        var j = 0
        let h = haystack.count
        let n = needle.count
        
        var prei = i
        while i < h {
            if j < n, haystack[i] != needle[j] {
                // find next matched haystack[i] != needle[0]
                j = 0
                
                // start from pre+1
                var k = prei+1
                while k < h {
                    if haystack[k] == needle[0] {
                        break
                    }
                    k += 1
                }
                
                if k == h { return -1 }
                i = k
                prei = i
            }
            
            if haystack[i] == needle[j] {
                if j == n-1 { return i-j }
                j += 1
                i += 1
            }
        }
        
        return -1
    }
}