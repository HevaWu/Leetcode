// Given two strings str1 and str2 of the same length, determine whether you can transform str1 into str2 by doing zero or more conversions.

// In one conversion you can convert all occurrences of one character in str1 to any other lowercase English character.

// Return true if and only if you can transform str1 into str2.

 

// Example 1:

// Input: str1 = "aabcc", str2 = "ccdee"
// Output: true
// Explanation: Convert 'c' to 'e' then 'b' to 'd' then 'a' to 'c'. Note that the order of conversions matter.
// Example 2:

// Input: str1 = "leetcode", str2 = "codeleet"
// Output: false
// Explanation: There is no way to transform str1 to str2.
 

// Note:

// 1 <= str1.length == str2.length <= 10^4
// Both str1 and str2 contain only lowercase English letters.

// Solution 1: map & set
// To realise the transformation:
// transformation of link link ,like a -> b -> c:
// we do the transformation from end to begin, that is b->c then a->b
// transformation of cycle, like a -> b -> c -> a:
// in this case we need a tmp
// c->tmp, b->c a->b and tmp->a
// Same as the process of swap two variable.
// In both case, there should at least one character that is unused,
// to use it as the tmp for transformation.
// So we need to return if the size of set of unused characters < 26.
// 
// use map to store the mapping characters
// if one character mapping failed, return false
// at the end, check distinct values count
// 
// Time complexity: O(n)
// Space complexity: O(26) contant, largest will be 26
class Solution {
    func canConvert(_ str1: String, _ str2: String) -> Bool {
        guard str1 != str2 else { return true }
        
        var map = [Character: Character]()
        for i in str1.indices {
            if let pre = map[str1[i]] {
                if str2[i] != pre {
                    return false
                }
            } else {
                map[str1[i]] = str2[i]
            }
        }
		// we should at least have one temp character for helping redirecting, so the count should < 26
        return Set(map.values).count < 26
    }
}