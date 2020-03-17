// Given a string S, check if the letters can be rearranged so that two characters that are adjacent to each other are not the same.

// If possible, output any possible result.  If not possible, return the empty string.

// Example 1:

// Input: S = "aab"
// Output: "aba"
// Example 2:

// Input: S = "aaab"
// Output: ""
// Note:

// S will consist of lowercase letters and have length in range [1, 500].

// Solution 1: Sort by count
// If we should make no two 'a's adjacent, it is natural to write "aXaXaXa..." where "X" is some letter. For now, let's assume that the task is possible (ie. the answer is not "".)
// Let's sort the string S, so all of the same kind of letter occur in continuous blocks. Then when writing in the following interleaving pattern, like S[3], S[0], S[4], S[1], S[5], S[2], adjacent letters never touch. (The specific interleaving pattern is that we start writing at index 1 and step by 2; then start from index 0 and step by 2.)
// The exception to this rule is if N is odd, and then when interleaving like S[2], S[0], S[3], S[1], S[4], we might fail incorrectly if there is a block of the same 3 letters starting at S[0] or S[1]. To prevent failing erroneously in this case, we need to make sure that the most common letters all occur at the end.
// Finally, it is easy to see that if N is the length of the string, and the count of some letter is greater than (N+1) / 2, the task is impossible.
// 
// Find the count of each character, and use it to sort the string by count.
// If at some point the number of occurrences of some character is greater than (N + 1) / 2, the task is impossible.
// Otherwise, interleave the characters in the order described above.
// 
// Time Complexity: O(\mathcal{A}(N + \log{\mathcal{A}}))O(A(N+logA)), where NN is the length of SS, and \mathcal{A}A is the size of the alphabet. In Java, our implementation is O(N + \mathcal{A} \log {\mathcal{A}})O(N+AlogA). If \mathcal{A}A is fixed, this complexity is O(N)O(N).
// Space Complexity: O(N)O(N). In Java, our implementation is O(N + \mathcal{A})O(N+A).
class Solution {
    func reorganizeString(_ S: String) -> String {
        guard !S.isEmpty else { return String() }
        let n = S.count
        var map = [Character: Int]()
        for c in S {
            map[c, default: 0] += 100
        }
        
        let asciia = Character("a").asciiValue!
        for key in map.keys {
            map[key] = map[key]! + Int(key.asciiValue! - asciia)
        }
        
        var arr = map.values.sorted(by: >)
        var charArr: [Character] = Array(repeating: Character("*"), count: n)
        var indexArr = 0
        for num in arr {
            let count = num / 100
            let char = Character(Unicode.Scalar(asciia + UInt8(num % 100)))
            
            if count > (n+1)/2 { 
                // repeat count larger than half of n, impossible
                return String() 
            }
            for i in 0..<count {
                if indexArr >= n { indexArr = 1 }
                charArr[indexArr] = char
                indexArr += 2
            }
        }
        
        return String(charArr)
    }
}