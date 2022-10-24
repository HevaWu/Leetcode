/*
You are given an array of strings arr. A string s is formed by the concatenation of a subsequence of arr that has unique characters.

Return the maximum possible length of s.

A subsequence is an array that can be derived from another array by deleting some or no elements without changing the order of the remaining elements.



Example 1:

Input: arr = ["un","iq","ue"]
Output: 4
Explanation: All the valid concatenations are:
- ""
- "un"
- "iq"
- "ue"
- "uniq" ("un" + "iq")
- "ique" ("iq" + "ue")
Maximum length is 4.
Example 2:

Input: arr = ["cha","r","act","ers"]
Output: 6
Explanation: Possible longest valid concatenations are "chaers" ("cha" + "ers") and "acters" ("act" + "ers").
Example 3:

Input: arr = ["abcdefghijklmnopqrstuvwxyz"]
Output: 26
Explanation: The only string in arr has all 26 characters.


Constraints:

1 <= arr.length <= 16
1 <= arr[i].length <= 26
arr[i] contains only lowercase English letters.
*/

/*
Solution 1:
bit to store each unique char in string
then backtrack to see if this string can be cancat

when map str to bit integer, if current str contains duplicate chars, return -1

Time Complexity: O(26n + 2^n)
Space Complexity: O(n)
*/
class Solution {
    func maxLength(_ arr: [String]) -> Int {
        // convert lowercase letters str to 2^26 integer
        var bitArr = arr.map { convertToInt($0) }
        let n = arr.count
        var maxLen = 0
        check(0, n, 0, 0, &maxLen, bitArr, arr)
        return maxLen
    }

    func check(_ index: Int, _ n: Int,
    _ curVal: Int, _ curLen: Int,
    _ maxLen: inout Int, _ bitArr: [Int], _ arr: [String]) {
        guard index < n else {
            maxLen = max(maxLen, curLen)
            return
        }

        // concat arr[index]
        if bitArr[index] != -1, (curVal & bitArr[index]) == 0 {
            check(index+1, n, curVal | bitArr[index], curLen + arr[index].count, &maxLen, bitArr, arr)
        }

        // not concat arr[index]
        check(index+1, n, curVal, curLen, &maxLen, bitArr, arr)
    }

    // convert str to bit integer
    // if there is duplicate char in str, return -1
    func convertToInt(_ str: String) -> Int {
        let asciia = Character("a").asciiValue!
        var bit = 0
        for c in str {
            let val = 1 << Int(c.asciiValue! - asciia)
            if (bit & val) != 0 { return -1 }
            bit |= val
        }
        return bit
    }
}
