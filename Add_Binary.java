/*
Given two binary strings a and b, return their sum as a binary string.



Example 1:

Input: a = "11", b = "1"
Output: "100"
Example 2:

Input: a = "1010", b = "1011"
Output: "10101"


Constraints:

1 <= a.length, b.length <= 104
a and b consist only of '0' or '1' characters.
Each string does not contain leading zeros except for the zero itself.
*/

/*
Solution 3:
from end to start, check each char

Time Complexity: O(max(na, nb))
Space Complexity: O(max(na, nb))
*/
class Solution {
    public String addBinary(String a, String b) {
        int i = a.length() - 1;
        int j = b.length() - 1;
        StringBuilder builder = new StringBuilder();
        int current = 0;
        while (i >= 0 || j >= 0) {
            current += (i >= 0 ? a.charAt(i)-'0' : 0) + (j >= 0 ? b.charAt(j)-'0' : 0);
            builder.insert(0, String.valueOf(current % 2));
            current /= 2;
            if (i >= 0) {
                i -= 1;
            }
            if (j >= 0) {
                j -= 1;
            }
        }
        if (current > 0) {
            builder.insert(0, '1');
        }
        return builder.toString();
    }
}