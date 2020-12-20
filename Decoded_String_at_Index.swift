/*
An encoded string S is given.  To find and write the decoded string to a tape, the encoded string is read one character at a time and the following steps are taken:

If the character read is a letter, that letter is written onto the tape.
If the character read is a digit (say d), the entire current tape is repeatedly written d-1 more times in total.
Now for some encoded string S, and an index K, find and return the K-th letter (1 indexed) in the decoded string.

 

Example 1:

Input: S = "leet2code3", K = 10
Output: "o"
Explanation: 
The decoded string is "leetleetcodeleetleetcodeleetleetcode".
The 10th letter in the string is "o".
Example 2:

Input: S = "ha22", K = 5
Output: "h"
Explanation: 
The decoded string is "hahahaha".  The 5th letter is "h".
Example 3:

Input: S = "a2345678999999999999999", K = 1
Output: "a"
Explanation: 
The decoded string is "a" repeated 8301530446056247680 times.  The 1st letter is "a".
 

Constraints:

2 <= S.length <= 100
S will only contain lowercase letters and digits 2 through 9.
S starts with a letter.
1 <= K <= 10^9
It's guaranteed that K is less than or equal to the length of the decoded string.
The decoded string is guaranteed to have less than 2^63 letters.
*/

/*
Solution 2:
backforward

1. count total decoded string count
2. back forward the string S, 
- if S[i] = d is digit, N /= d, K %= N is answer
- if S[i] = c is character
  - if K == N or K == 0, return c
  - else N -= 1

If we have a decoded string like appleappleappleappleappleapple and an index like K = 24, the answer is the same if K = 4.

In general, when a decoded string is equal to some word with size length repeated some number of times (such as apple with size = 5 repeated 6 times), the answer is the same for the index K as it is for the index K % size.

We can use this insight by working backwards, keeping track of the size of the decoded string. Whenever the decoded string would equal some word repeated d times, we can reduce K to K % (word.length).

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func decodeAtIndex(_ S: String, _ K: Int) -> String {
        var S = Array(S)
        var N = 0
        var K = K
        
        for c in S {
            if let num = c.wholeNumberValue {
                N *= num
            } else {
                N += 1
            }
        }
        
        for i in stride(from: S.count-1, through: 0, by: -1) {
            if let num = S[i].wholeNumberValue {
                N /= num
                K %= N
            } else {
                if K == N || K == 0 {
                    return String(S[i])
                } else {
                    N -= 1
                }
            }
        }
        return String()
    }
}

/*
Solution 1: 
brute force

count the decode string, then get the k index
process exited with signal SIGILL
*/
class Solution {
    func decodeAtIndex(_ S: String, _ K: Int) -> String {
        var decoded: [Character] = []
        for c in S {
            if c.isLetter {
                decoded.append(c)
            } else if c.isNumber {
                guard var count = c.wholeNumberValue, !decoded.isEmpty else { continue }
                let cur = decoded
                while count > 1 {
                    decoded += cur
                    count -= 1
                }
            } else {
                continue
            }
            
            if K-1 < decoded.count {
                return String(decoded[K-1])
            }
        }
        return String()
    }
}