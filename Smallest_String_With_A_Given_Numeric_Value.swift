/*
The numeric value of a lowercase character is defined as its position (1-indexed) in the alphabet, so the numeric value of a is 1, the numeric value of b is 2, the numeric value of c is 3, and so on.

The numeric value of a string consisting of lowercase characters is defined as the sum of its characters' numeric values. For example, the numeric value of the string "abe" is equal to 1 + 2 + 5 = 8.

You are given two integers n and k. Return the lexicographically smallest string with length equal to n and numeric value equal to k.

Note that a string x is lexicographically smaller than string y if x comes before y in dictionary order, that is, either x is a prefix of y, or if i is the first position such that x[i] != y[i], then x[i] comes before y[i] in alphabetic order.

 

Example 1:

Input: n = 3, k = 27
Output: "aay"
Explanation: The numeric value of the string is 1 + 1 + 25 = 27, and it is the smallest string with such a value and length equal to 3.
Example 2:

Input: n = 5, k = 73
Output: "aaszz"
 

Constraints:

1 <= n <= 105
n <= k <= 26 * n

Hint 1: 
Think greedily.

Hint 2:
If you build the string from the end to the beginning, it will always be optimal to put the highest possible character at the current index.
*/

/*
Solution 2:
greedy

initial assign n "a" 
k = k-n
while k > 0, temp = min(k, 25), replace res[i] = Character(UnicodeScalar(UInt8(temp) + aAscii))
k -= temp

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func getSmallestString(_ n: Int, _ k: Int) -> String {
        let aAscii = Character("a").asciiValue!
        
        var res: [Character] = Array(repeating: Character("a"), count: n)
        var k = k - n
        
        var i = n-1
        while k > 0 {
            let temp = min(k, 25)
            res[i] = Character(UnicodeScalar(UInt8(temp) + aAscii))
            k -= temp
            i -= 1
        }
        
        return String(res)
    }
}

/*
Solution 1:
greedy

1. check (k-n) / 26
2. if k == n, String(repeating: Character("a"), count: k) + res
   if k < n, String(repeating: Character("a"), count: n-1) + String(UnicodeScalar(aAscii + UInt8(k-n))) + res
*/
class Solution {
    func getSmallestString(_ n: Int, _ k: Int) -> String {
        let aAscii = Character("a").asciiValue!
        var res: String = ""
        
        var n = n
        var k = k
        
        // use k-n to check 26
        let zVal = (k-n) / 26
        if zVal > 0 {
            res += String(repeating: Character("z"), count: zVal)
            k -= (zVal * 26)
            n -= zVal
        }
        
        if k == n {
            res = String(repeating: Character("a"), count: k) + res
        } else {
            // use aAscii + UInt8(k-n)
            let next = Character(UnicodeScalar(aAscii + UInt8(k-n)))
            res = String(repeating: Character("a"), count: n-1) + String(UnicodeScalar(aAscii + UInt8(k-n))) + res
        }
        
        return res
    }
}