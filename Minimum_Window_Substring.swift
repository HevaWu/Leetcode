// Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).
// 
// Example:
// 
// Input: S = "ADOBECODEBANC", T = "ABC"
// Output: "BANC"
// Note:
// 
// If there is no such window in S that covers all characters in T, return the empty string "".
// If there is such window, you are guaranteed that there will always be only one unique minimum window in S.

// Hint
// Use two pointers to create a window of letters in S, which would have all the characters from T.

// Solution 1: Sliding window
// In any sliding window based problem we have two pointers. One rightright pointer whose job is to expand the current window and then we have the leftleft pointer whose job is to contract a given window. At any point in time only one of these pointers move and the other one remains fixed.
// 
// Time Complexity: O(|S| + |T|) where |S| and |T| represent the lengths of strings S and T. In the worst case we might end up visiting every element of string S twice, once by left pointer and once by right pointer. |T| represents the length of string T.
// Space Complexity: O(|S| + |T|). |S| when the window size is equal to the entire string S. |T| when T has all unique characters.
class Solution {
    func minWindow(_ s: String, _ t: String) -> String {
        guard !s.isEmpty, !t.isEmpty else { return String() }
        
        var tdic = [Character: Int]()
        for i in t {
            tdic[i] = (tdic[i] ?? 0) + 1
        }
        
        let tcount = tdic.keys.count
        
        // left & right pointer
        var left = 0
        var right = 0
        
        // record how many characters are found
        var findedChar = 0
        
        // final window dictionay for mark characters in S
        var windowDic = [Character: Int]()
        
        // finded minWindow info, first indicate window.length, second indicate left
        var finded = [-1, 0]
        
        while right < s.count {
            // expand right pointer
            let rightIndex = s.index(s.startIndex, offsetBy: right)
            var c = s[rightIndex]
            windowDic[c] = (windowDic[c] ?? 0) + 1
            if tdic.keys.contains(c), windowDic[c] == tdic[c] {
                findedChar += 1
            }
            
            // contract left pointer
            while left <= right && findedChar == tcount {
                let leftIndex = s.index(s.startIndex, offsetBy: left)
                c = s[leftIndex]
                
                // update finded window info
                if finded[0] == -1 || right - left + 1 < finded[0] {
                    finded[0] = right - left + 1
                    finded[1] = left
                }
                
                // update finded if this character belongs to T
                windowDic[c] = windowDic[c]! - 1
                if tdic.keys.contains(c), windowDic[c]! < tdic[c]! {
                    findedChar -= 1
                }
                
                left += 1
            }

            right += 1
        }
        
        if finded[0] == -1 { return String() }
        let leftIndex = s.index(s.startIndex, offsetBy: finded[1])
        let rightIndex = s.index(leftIndex, offsetBy: finded[0])
        return String(s[leftIndex..<rightIndex])
    }
}

// Solution 2:
// A small improvement to the above approach can reduce the time complexity of the algorithm to O(2*|filtered\_S| + |S| + |T|)O(2∗∣filtered_S∣+∣S∣+∣T∣), where filtered\_Sfiltered_S is the string formed from S by removing all the elements not present in TT.
// This complexity reduction is evident when |filtered\_S| <<< |S|∣filtered_S∣<<<∣S∣.
// This kind of scenario might happen when length of string TT is way too small than the length of string SS and string SS consists of numerous characters which are not present in TT.
// 
// Time Complexity : O(|S| + |T|) where |S| and |T| represent the lengths of strings SS and TT. The complexity is same as the previous approach. But in certain cases where |filtered\_S|∣filtered_S∣ <<< |S|∣S∣, the complexity would reduce because the number of iterations would be 2*|filtered\_S| + |S| + |T|2∗∣filtered_S∣+∣S∣+∣T∣.
// Space Complexity : O(|S| + |T|)
class Solution {
    func minWindow(_ s: String, _ t: String) -> String {
        guard !s.isEmpty, !t.isEmpty else { return String() }
        
        // tdic to mark t characters
        var tdic = [Character: Int]()
        for i in t {
            tdic[i] = (tdic[i] ?? 0) + 1
        }
        let tcount = tdic.keys.count
        
        // filterS to mark only element in tdic will be stored, key is index, value is the char
        var filterS = [(index: Int, char: Character)]()
        for (i, ivalue) in s.enumerated() {
            if tdic.keys.contains(ivalue) {
                filterS.append((i, ivalue))
            }
        }
        
        // use 2 pointer to search at filterS
        var left = 0
        var right = 0
        var finded = 0
        var findedDis = -1
        var findedLeft = 0
        var windowDic = [Character: Int]()
        
        while right < filterS.count {
            // add right character into window
            var c = filterS[right].char
            windowDic[c] = (windowDic[c] ?? 0) + 1
            
            // add it into finded if this char already been found
            if windowDic[c] == tdic[c] {
                finded += 1
            }
                        
            // check finded
            while left <= right, finded == tcount {
                // contract left
                c = filterS[left].char
                                
                // update smallest until now
                if findedDis == -1 || filterS[right].index - filterS[left].index + 1 < findedDis {
                    findedDis = filterS[right].index - filterS[left].index + 1
                    findedLeft = filterS[left].index
                }
                
                // update windowDic value
                windowDic[c]! -= 1
                if windowDic[c]! < tdic[c]! {
                    // update finded value, break finded while
                    finded -= 1
                }
                left += 1
            }

            right += 1
        }

        if findedDis == -1 { return String() }
        let leftIndex = s.index(s.startIndex, offsetBy: findedLeft)
        let rightIndex = s.index(leftIndex, offsetBy: findedDis)
        return String(s[leftIndex..<rightIndex])
    }
}