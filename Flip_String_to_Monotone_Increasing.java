/*
A string of '0's and '1's is monotone increasing if it consists of some number of '0's (possibly 0), followed by some number of '1's (also possibly 0.)

We are given a string s of '0's and '1's, and we may flip any '0' to a '1' or a '1' to a '0'.

Return the minimum number of flips to make s monotone increasing.



Example 1:

Input: s = "00110"
Output: 1
Explanation: We flip the last digit to get 00111.
Example 2:

Input: s = "010110"
Output: 2
Explanation: We flip to get 011111, or alternatively 000111.
Example 3:

Input: s = "00011000"
Output: 2
Explanation: We flip to get 00000000.


Note:

1 <= s.length <= 20000
s only consists of '0' and '1' characters.
*/

/*
Solution 4:
constant DP

zero += (c == "0" ? 0 : 1)

zero: flip 1 to zero
one: min(flip 1->0, flip 0->1)
one = min(zero, one+1 - (c == "0" ? 0 : 1))

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    public int minFlipsMonoIncr(String s) {
        int n = s.length();
        if (n == 1) { return 0; }
        int zero = 0;
        int one = 0;
        for(int i = 0; i < n; i++) {
            zero = zero + (s.charAt(i) == '0' ? 0 : 1);
            one = Math.min(zero, one + (s.charAt(i) == '0' ? 1 : 0));
        }
        return one;
    }
}
