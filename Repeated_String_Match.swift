// Given two strings A and B, find the minimum number of times A has to be repeated such that B is a substring of it. If no such solution, return -1.

// For example, with A = "abcd" and B = "cdabcdab".

// Return 3, because by repeating A three times (“abcdabcdabcd”), B is a substring of it; and B is not a substring of A repeated two times ("abcdabcd").

// Note:
// The length of A and B will be between 1 and 10000.

// Solution 1: brute force
// 
// Time Complexity: O(N*(N+M))O(N∗(N+M)), where M, NM,N are the lengths of strings A, B. We create two strings A * q, A * (q+1) which have length at most O(M+N). When checking whether B is a substring of A, this check takes naively the product of their lengths.
// Space complexity: As justified above, we created strings that used O(M+N)O(M+N) space.
class Solution {
    func repeatedStringMatch(_ A: String, _ B: String) -> Int {
        if A.isEmpty, B.isEmpty { return 0 }
        guard !A.isEmpty, !B.isEmpty else { return -1 }
        
        var num = 1
        var str = A
        while str.count < B.count {
            str.append(A)
            num += 1
        }
        
        if hasSubstr(str, B) { return num }
        str.append(A)
        if hasSubstr(str, B) { return num + 1 }
        return -1
    }
    
    // return true if first contains second
    func hasSubstr(_ first: String, _ second: String) -> Bool {
        var index = first.startIndex
        while index < first.endIndex, String(first[index...]).count >= second.count {
            if first[index] == second.first!, String(first[index...]).hasPrefix(second) {
                return true
            } else {
                index = first.index(after: index)
            }
        }
        return false
    }
}

// Solution 2: robin Karp
// For strings SS, consider each S[i]S[i] as some integer ASCII code. Then for some prime pp, consider the following function modulo some prime modulus \mathcal{M}M:
// \text{hash}(S) = \sum_{0 \leq i < len(S)} p^i * S[i]
// Notably, \text{hash}(S[1:] + x) = \frac{(\text{hash}(S) - S[0])}{p} + p^{n-1} x. This shows we can get the hash of every substring of A * q in time complexity linear to it's size. (We will also use the fact that p^{-1} = p^{\mathcal{M}-2} \mod \mathcal{M}
// However, hashes may collide haphazardly. To be absolutely sure in theory, we should check the answer in the usual way. The expected number of checks we make is in the order of 1 + \frac{s}{\mathcal{M}}where ss is the number of substrings we computed hashes for (assuming the hashes are equally distributed), which is effectively 1.

