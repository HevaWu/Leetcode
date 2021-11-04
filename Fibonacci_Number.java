/*
The Fibonacci numbers, commonly denoted F(n) form a sequence, called the Fibonacci sequence, such that each number is the sum of the two preceding ones, starting from 0 and 1. That is,

F(0) = 0, F(1) = 1
F(n) = F(n - 1) + F(n - 2), for n > 1.
Given n, calculate F(n).



Example 1:

Input: n = 2
Output: 1
Explanation: F(2) = F(1) + F(0) = 1 + 0 = 1.
Example 2:

Input: n = 3
Output: 2
Explanation: F(3) = F(2) + F(1) = 1 + 1 = 2.
Example 3:

Input: n = 4
Output: 3
Explanation: F(4) = F(3) + F(2) = 2 + 1 = 3.


Constraints:

0 <= n <= 30
*/

/*
Solution 1:
iterative from 2 to n

Time Complexity: O(n)
Space Complexity: O(n)
*/

class Solution {
    public int fib(int n) {
        if (n <= 1) { return n; }

        Map<Integer, Integer> map = new HashMap<>();

        map.put(0, 0);
        map.put(1, 1);

        for (int i = 2; i <= n; i++) {
            map.put(i, map.getOrDefault(i-1, 0) + map.getOrDefault(i-2, 0));
        }
        return map.getOrDefault(n, 0);
    }
}