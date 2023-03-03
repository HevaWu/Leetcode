/*
Given two strings needle and haystack, return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.



Example 1:

Input: haystack = "sadbutsad", needle = "sad"
Output: 0
Explanation: "sad" occurs at index 0 and 6.
The first occurrence is at index 0, so we return 0.
Example 2:

Input: haystack = "leetcode", needle = "leeto"
Output: -1
Explanation: "leeto" did not occur in "leetcode", so we return -1.


Constraints:

1 <= haystack.length, needle.length <= 104
haystack and needle consist of only lowercase English characters.
*/


/*
Solution 1:
iterate two string, compare current char is equal or not

Time Complexity: O(n1 * n2)
Space Complexity: O(1)
*/
class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        var haystack = Array(haystack)
        var needle = Array(needle)

        var i1 = 0 // index of haystack
        var i2 = 0 // index of needle
        let n1 = haystack.count
        let n2 = needle.count
        while i1 < n1, i2 < n2 {
            if haystack[i1] == needle[i2] {
                i1 += 1
                i2 += 1
                if i2 == n2 {
                    return i1 - i2
                }
            } else {
                i1 = i1 - i2 + 1
                i2 = 0
            }
        }
        return -1
    }
}
