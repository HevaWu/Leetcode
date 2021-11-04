/*
The Tribonacci sequence Tn is defined as follows:

T0 = 0, T1 = 1, T2 = 1, and Tn+3 = Tn + Tn+1 + Tn+2 for n >= 0.

Given n, return the value of Tn.



Example 1:

Input: n = 4
Output: 4
Explanation:
T_3 = 0 + 1 + 1 = 2
T_4 = 1 + 1 + 2 = 4
Example 2:

Input: n = 25
Output: 1389537


Constraints:

0 <= n <= 37
The answer is guaranteed to fit within a 32-bit integer, ie. answer <= 2^31 - 1.
*/
class Solution {
    public int tribonacci(int n) {
        Map<Integer, Integer> T = new HashMap<>();
        T.put(0, 0);
        T.put(1, 1);
        T.put(2, 1);

        if (n < 3) {
            return T.getOrDefault(n, 0);
        }

        for (int i = 3; i <= n; i++) {
            T.put(i, T.getOrDefault(i-1, 0) + T.getOrDefault(i-2, 0) + T.getOrDefault(i-3, 0));
        }
        return T.getOrDefault(n, 0);
    }
}