/*
Given an integer n, count the total number of digit 1 appearing in all non-negative integers less than or equal to n.



Example 1:

Input: n = 13
Output: 6
Example 2:

Input: n = 0
Output: 0


Constraints:

0 <= n <= 109

*/

/*
Solution 1:
math

we can see that from digit '1' at ones place repeat in group of 1 after interval of 10. Similarly, '1' at tens place repeat in group of 10 after interval of 100. This can be formulated as (n/(i*10))*i.

Also, notice that if the digit at tens place is ’1’, then the number of terms with ’1’s is increased by x+1, if the number is say "ab1x". As if digits at tens place is greater than 11, then all the 10 occurances of numbers with '1' at tens place have taken place, hence, we add 10. This is formluated as min(max((n mod (i*10))−i+1,0),i).

Time Complexity: O(log_10 n)
Space Complexity: O(1)
*/
class Solution {
    func countDigitOne(_ n: Int) -> Int {
        var digit = 0

        // check each 1's position, 1, 10, 100, 1000, ...
        var i = 1
        while i <= n {
            let divider = i * 10
            digit += Int((n/divider) * i + min(
                i,
                max(n % divider - i + 1, 0)
            ))

            // i *= 10
            i *= 10
        }

        return digit
    }
}