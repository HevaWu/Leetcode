// Given strings S and T, find the minimum (contiguous) substring W of S, so that T is a subsequence of W.

// If there is no such window in S that covers all characters in T, return the empty string "". If there are multiple such minimum-length windows, return the one with the left-most starting index.

// Example 1:

// Input: 
// S = "abcdebdde", T = "bde"
// Output: "bcde"
// Explanation: 
// "bcde" is the answer because it occurs before "bdde" which has the same length.
// "deb" is not a smaller window because the elements of T in the window must occur in order.
 

// Note:

// All the strings in the input will only contain lowercase letters.
// The length of S will be in the range [1, 20000].
// The length of T will be in the range [1, 100].

// Solution 1: brute force(Time limited exceed)
// 
// Time complexity: O(n!)
// Space complexity: O(n!)
class Solution {
    func minWindow(_ S: String, _ T: String) -> String {
        guard S.count >= T.count else { return String() }
        
        var tIndex = T.startIndex
        if let lstart = S.firstIndex(of: T[tIndex]) {
            var left = lstart
            var finded = String()
            while left < S.endIndex {
                if S[left] == T[tIndex] {
                    tIndex = T.index(after: tIndex)
                    if tIndex == T.endIndex{
                        finded = String(S[lstart...left])
                        break
                    }
                }
                left = S.index(after: left)
            }
            if finded.isEmpty { return String() }
            
            var nextS = String(S[(S.index(after: lstart))...])
            var nextWindow = minWindow(nextS, T)
            return (nextWindow.count < finded.count && !nextWindow.isEmpty) ? nextWindow : finded
        } else {
            return String()
        }
    }
}

class Solution {
    func minWindow(_ S: String, _ T: String) -> String {
        guard S.count >= T.count else { return String() }
        
        var start = -1
        var len = S.count
        
        var sRight = 0
        var tRight = 0
        
        var arrS = Array(S)
        var arrT = Array(T)
        
        while sRight < arrS.count {
            if arrS[sRight] == arrT[tRight] {
                var sLeft = sRight
                if tRight == arrT.count - 1 {
                    // narrow the window
                    while tRight >= 0 {
                        if arrS[sLeft] == arrT[tRight] {
                            tRight -= 1
                        }
                        sLeft -= 1
                    }
                    // firstIndex of the target
                    sLeft += 1 
                    if sRight - sLeft < len {
                        len = sRight - sLeft
                        start = sLeft
                    }
                    // start from the firstIndex of the target
                    sRight = sLeft
                }
                tRight += 1
            }
            sRight += 1
        }
        return start == -1 ? String() : String(arrS[start...(start+len)])
    }
}


// Solution 2: DP
// We can precompute (for each i and letter), next[i][letter]: the index of the first occurrence of letter in S[i:], or -1 if it is not found.
// Then, we'll maintain a set of minimum windows for T[:j] as j increases. At the end, we'll take the best minimum window.
// 
class Solution {
    func minWindow(_ S: String, _ T: String) -> String {
        guard S.count >= T.count else { return String() }
        
        var arrS = Array(S)
        var arrT = Array(T)
        
        let n = S.count
        var lastS = Array(repeating: -1, count: 26)
        var nextS = Array(repeating: Array(repeating: 0, count: 26), count: n)

        let asciiA = Character("a").asciiValue!
        for i in (0..<n).reversed() {
            lastS[Int(arrS[i].asciiValue! - asciiA)] = i
            for k in 0..<26 {
                nextS[i][k] = lastS[k]
            }
        }
        
        var windows = [(Int, Int)]()
        for i in 0..<S.count {
            if arrS[i] == arrT[0] {
                windows.append((i,i))
            }
        }
        
        for j in 1..<T.count {
            let index = Int(arrT[j].asciiValue! - asciiA)
            for w in 0..<windows.count {
                if windows[w].1 < n-1 && nextS[windows[w].1+1][index] >= 0 {
                    windows[w].1 = nextS[windows[w].1 + 1][index]
                } else {
                    windows[w].0 = -1
                    windows[w].1 = -1
                    break
                }
            }
        }
        
        var minimum = (-1, S.count)
        for window in windows {
            if window.0 == -1 {
                break
            }
            if window.1 - window.0 < minimum.1 - minimum.0 {
                minimum = window
            }
        }
        
        if minimum.0 == -1 { return String() }
        let startIndex = S.index(S.startIndex, offsetBy: minimum.0)
        let endIndex = S.index(S.startIndex, offsetBy: minimum.1+1)
        return String(S[startIndex..<endIndex])
    }
}