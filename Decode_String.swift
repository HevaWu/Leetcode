// Given an encoded string, return its decoded string.

// The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is being repeated exactly k times. Note that k is guaranteed to be a positive integer.

// You may assume that the input string is always valid; No extra white spaces, square brackets are well-formed, etc.

// Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, k. For example, there won't be input like 3a or 2[4].

// Examples:

// s = "3[a]2[bc]", return "aaabcbc".
// s = "3[a2[c]]", return "accaccacc".
// s = "2[abc]3[cd]ef", return "abcabccdcdcdef".

// Solution 1: Recursive dfs
// search decoded string when we met a `]`
// use brackets to mark how many `[` we already have 
// use count to mark the count we might need to repeat
// use start to mark the first `[`
// 
// Time complexity: O(n^2)
// Space complexity: O(m+n) n is string length, m is final decoded string length
class Solution {
    func decodeString(_ s: String) -> String {
        guard !s.isEmpty else { return String() }
        
        var s = Array(s)
        var brackets = 0
        var count = 0
        var start = -1
        
        var decodeStr = String() 
        
        for i in 0..<s.count {
            let char = String(s[i])
            
            if char == "[" {
                // mark position
                if brackets == 0 {
                    start = i
                }
                brackets += 1
                
            } else if char == "]" {
                brackets -= 1
                if brackets == 0, start >= 0 {
                    // append string
                    let curr = decodeString(String(s[start+1..<i]))
                    let tempStr = String(repeating: curr, count: count)
                    decodeStr.append(tempStr)
                    
                    // reset 
                    start = -1
                    count = 0
                }
                
            } else if brackets == 0 {
                // check if this is number
                if let temp = Int(char) {
                    count = count * 10 + temp
                } else {
                    // this is a str
                    decodeStr.append(char)
                }
            }
        }
        
        return decodeStr
    }
}