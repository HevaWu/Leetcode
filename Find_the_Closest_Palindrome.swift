/*
Given a string n representing an integer, return the closest integer (not including itself), which is a palindrome. If there is a tie, return the smaller one.

The closest is defined as the absolute difference minimized between two integers.



Example 1:

Input: n = "123"
Output: "121"
Example 2:

Input: n = "1"
Output: "0"
Explanation: 0 and 2 are the closest palindromes but we return the smallest which is 0.


Constraints:

1 <= n.length <= 18
n consists of only digits.
n does not have leading zeros.
n is representing an integer in the range [1, 1018 - 1].
*/

/*
Solution 1:

If the final answer has the same number of digits as the input string S, then the answer must be the middle digits + (-1, 0, or 1) flipped into a palindrome. For example, 23456 had middle part 234, and 233, 234, 235 flipped into a palindrome yields 23332, 23432, 23532. Given that we know the number of digits, the prefix 235 (for example) uniquely determines the corresponding palindrome 23532, so all palindromes with larger prefix like 23732 are strictly farther away from S than 23532 >= S.

If the final answer has a different number of digits, it must be of the form 999....999 or 1000...0001, as any palindrome smaller than 99....99 or bigger than 100....001 will be farther away from S.

Time Complexity: O(size/2)
Space Complexity: O(1)
*/
class Solution {
    func nearestPalindromic(_ n: String) -> String {
        let size = n.count
        if size == 1 { return String(Int(n)!-1) }

        // first add different digit width possible candidate
        var candidates = getInitCandidates(size)
        var s = Array(n)

        var half = Int(String(s[0..<(size+1)/2]))!
        for leftHalf in [half-1, half, half+1] {
            var temp = leftHalf
            var even = leftHalf * 10 + temp%10
            var odd = leftHalf

            temp /= 10
            while temp != 0 {
                even = even*10 + temp%10
                odd = odd*10 + temp%10

                temp /= 10
            }

            candidates.append(even)
            candidates.append(odd)
        }

        // sort to make sure minimum value
        candidates.sort()

        var nearStr = String()
        let val = Int(n)!
        var minDiff = Int.max
        for c in candidates {
            if c == val { continue }
            let diff = abs(c-val)
            if diff < minDiff {
                minDiff = diff
                nearStr = String(c)
            }
        }
        return nearStr
    }

    func getInitCandidates(_ n: Int) -> [Int] {
        var res = [Int]()
        let tempN = Int(pow(Double(10), Double(n)))
        let tempN1 = Int(pow(Double(10), Double(n-1)))
        res.append(tempN1-1)
        res.append(tempN1+1)
        res.append(tempN-1)
        res.append(tempN+1)
        return res
    }
}