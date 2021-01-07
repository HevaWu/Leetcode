// Given a string, find the length of the longest substring without repeating characters.

// Example 1:

// Input: "abcabcbb"
// Output: 3
// Explanation: The answer is "abc", with the length of 3.
// Example 2:

// Input: "bbbbb"
// Output: 1
// Explanation: The answer is "b", with the length of 1.
// Example 3:

// Input: "pwwkew"
// Output: 3
// Explanation: The answer is "wke", with the length of 3.
//              Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

// Solution 1ß
// charDic: to record current string character position
// substrLongestLength: record current temporary substring length
// res: the result we should return
//
// For same character, get the distance from current position to previous position, if this distance shorter than the steps(substrLongestLength), reset steps length to this distance, then compare current one with the true res, res will always keep the largest length of the result substring.
//
// TimeComplexity: O(n) -> n is the length of string
class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard !s.isEmpty else { return 0 }
        guard s.length != 1 else { return 1 }

        var s = Array(s)
        var charDic: [Character: Int] = [Character: Int]()
        var substrLongestLength: Int = 0
        var res: Int = 0

        for i in s.indices {
            substrLongestLength += 1

            let currentChar = s[i]
            if let pre = charDic[currentChar] {
                let dis = i - pre
                if dis < substrLongestLength {
                    substrLongestLength = dis
                }
            }

            charDic[currentChar] = i
            if substrLongestLength > res {
                res = substrLongestLength
            }
        }

        return res
    }
}

// Solution 2: Sliding window
// Use set to help checking if current char already exist
// We use HashSet to store the characters in current window [i, j) (j = iinitially). Then we slide the index j to the right. If it is not in the HashSet, we slide jj further. Doing so until s[j] is already in the HashSet. At this point, we found the maximum size of substrings without duplicate characters start with index ii. If we do this for all ii, we get our answer.
//
// Time complexity : O(2n) = O(n). In the worst case each character will be visited twice by i and j.
// Space complexity : O(min(m, n)). Same as the previous approach. We need O(k) space for the sliding window, where k is the size of the Set. The size of the Set is upper bounded by the size of the string n and the size of the charset/alphabet m.
class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard !s.isEmpty else { return 0 }
        guard s.count > 1 else { return 1 }

        var s = Array(s)
        var set = Set<Character>()
        var len: Int = 0

        var left = 0
        var right = 0

        while left < s.count, right < s.count {
            if !set.contains(s[right]) {
                set.insert(s[right])
                right += 1
                len = max(len, right - left)
            } else {
                set.remove(s[left])
                left += 1
            }
        }

        return len
    }
}

// Solution 3:
// Optimize to only need n steps, we could define a mapping of the characters to its index. Then we can skip the characters immediately when we found a repeated character.
// We could skip all elements in the range [i, j1] and let i = jto just skip
//
// Time complexity : O(n). Index j will iterate nn times.
// Space complexity (HashMap) : O(min(m, n)). Same as the previous approach.
class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard !s.isEmpty else { return 0 }
        guard s.count > 1 else { return 1 }
        
        var s = Array(s)
        var left = 0
        var right = 0
        var dic = [Character: Int]()
        var dis = 0
        
        while left < s.count, right < s.count {
            if let index = dic[s[right]] {
                // contains, update left with larger one
                left = max(left, index)
            }
            // +1 for countind distance
            dis = max(dis, right-left+1)
            dic[s[right]] = right+1
            right += 1
        }
        return dis
    }
}