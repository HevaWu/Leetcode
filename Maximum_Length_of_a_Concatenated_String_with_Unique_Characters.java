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
    int maxLen = 0;

    public int maxLength(List<String> arr) {
        int n = arr.size();
        int[] bitArr = new int[n];
        for (int i = 0; i < n; i++) {
            bitArr[i] = convertToInt(arr.get(i));
        }

        check(0, n, 0, 0, bitArr, arr);
        return maxLen;
    }

    public void check(int index, int n, int curVal, int curLen, int[] bitArr, List<String> arr) {
        if (index == n) {
            maxLen = Math.max(maxLen, curLen);
            return;
        }

        // can concat
        if (bitArr[index] != -1 && ((curVal & bitArr[index]) == 0)) {
            check(index + 1, n, curVal | bitArr[index], curLen + arr.get(index).length(), bitArr, arr);
        }

        // not concat
        check(index + 1, n, curVal, curLen, bitArr, arr);
    }

    public int convertToInt(String str) {
        int bitVal = 0;
        for (int i = 0; i < str.length(); i++) {
            int val = 1 << (str.charAt(i) - 'a');
            if ((bitVal & val) != 0) {
                return -1;
            }
            bitVal |= val;
        }
        return bitVal;
    }
}
