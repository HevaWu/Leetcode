// Given a string s , find the length of the longest substring t  that contains at most 2 distinct characters.

// Example 1:

// Input: "eceba"
// Output: 3
// Explanation: t is "ece" which its length is 3.
// Example 2:

// Input: "ccaabbb"
// Output: 5
// Explanation: t is "aabbb" which its length is 5.

// Solution 1: Sliding window
// set pointer left & right as window's boundaries
// The idea is to set both pointers in the position 0 and then move right pointer to the right while the window contains not more than two distinct characters. If at some point we've got 3 distinct characters, let's move left pointer to keep not more than 2 distinct characters in the window.
// There is just one more question to reply - how to move the left pointer to keep only 2 distinct characters in the string?
// Step
// Return N if the string length N is smaller than 3.
// Set both set pointers in the beginning of the string left = 0 and right = 0 and init max substring length max_len = 2.
// While right pointer is less than N:
// If hashmap contains less than 3 distinct characters, add the current character s[right] in the hashmap and move right pointer to the right.
// If hashmap contains 3 distinct characters, remove the leftmost character from the hashmap and move the left pointer so that sliding window contains again 2 distinct characters only.
// Update max_len.
// 
// Time complexity : O(N) where N is a number of characters in the input string.
// Space complexity : O(1) since additional space is used only for a hashmap with at most 3 elements.
class Solution {
    func lengthOfLongestSubstringTwoDistinct(_ s: String) -> Int {
        guard !s.isEmpty else { return 0 }
        guard s.count >= 3 else { return s.count }
        var s = Array(s)
        
        var dis = 0
        
        var left = 0
        var right = 0

        // key is char, value is the index of string
        var dic = [Character: Int]()
        
        while right < s.count {
            // update dic for right char
            dic[s[right]] = right
            right += 1
            
            if dic.keys.count == 3 {
                // remove the smallest index char
                let smallestValue = dic.values.min()!
                dic.removeValue(forKey: s[smallestValue]) // dic[s[smallest]] = nil
                left = smallestValue + 1
            }
            dis = max(dis, right - left)
        }
        return dis
    }
}
