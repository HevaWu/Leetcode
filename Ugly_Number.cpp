/*
An ugly number is a positive integer whose prime factors are limited to 2, 3,
and 5.

Given an integer n, return true if n is an ugly number.



Example 1:

Input: n = 6
Output: true
Explanation: 6 = 2 × 3
Example 2:

Input: n = 1
Output: true
Explanation: 1 has no prime factors, therefore all of its prime factors are
limited to 2, 3, and 5. Example 3:

Input: n = 14
Output: false
Explanation: 14 is not ugly since it includes the prime factor 7.


Constraints:

-231 <= n <= 231 - 1
*/

/*
Solution 1:
keep divide n from 2 to 6
if remain n == 1 return true

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
 public:
  bool isUgly(int num) {
    for (int i = 2; i < 6 && num; i++) {
      while (num % i == 0) num /= i;
    }
    return num == 1;
  }
};
