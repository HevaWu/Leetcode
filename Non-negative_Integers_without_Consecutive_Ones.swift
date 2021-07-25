/*
Given a positive integer n, return the number of the integers in the range [0, n] whose binary representations do not contain consecutive ones.



Example 1:

Input: n = 5
Output: 5
Explanation:
Here are the non-negative integers <= 5 with their corresponding binary representations:
0 : 0
1 : 1
2 : 10
3 : 11
4 : 100
5 : 101
Among them, only integer 3 disobeys the rule (two consecutive ones) and the other 5 satisfy the rule.
Example 2:

Input: n = 1
Output: 2
Example 3:

Input: n = 2
Output: 3


Constraints:

1 <= n <= 109
*/

/*
Solution 1:
bit manipulation

- f[i] gives the count of such binary numbers with i bits.
    - if we know the value of f[n−1] and f[n-2], in order to generate the required binary numbers with nn bits, we can append a 0 to all the binary numbers contained in f[n-1] without creating an invalid number. These numbers give a factor of f[n-1] to be included in f[n]. But, we can't append a 1 to all these numbers, since it could lead to the presence of two consecutive ones in the newly generated numbers. Thus, for the currently generated numbers to end with a 1, we need to ensure that the second last position is always 0. Thus, we need to fix a 01 at the end of all the numbers contained in f[n-2]. This gives a factor of f[n-2] to be included in f[n].
- f[n]=f[n−1]+f[n−2].

ex:
- num=1010100(7 bit number). Now, we'll see how we can find the numbers lesser than num with no two consecutive 1's. We start off with the MSB of nums. If we fix a 0 at the MSB position, and find out the count of 6 bit numbers(corresponding to the 6 LSBs) with no two consecutive 1's, these 6-bit numbers will lie in the range 0000000−>0111111. For finding this count we can make use of f[6] which we'll have already calculated based on the discussion above.
- But, even after doing this, all the numbers in the required range haven't been covered yet. Now, if we try to fix 1 at the MSB, the numbers considered will lie in the range 1000000−>1111111. As we can see, this covers the numbers in the range \textbf{1}\text{000000} -> \textbf{1}\text{010100}1000000−>1010100, but it covers the numbers in the range beyond limit as well. Thus, we can't fix \text{1}1 at the MSB and consider all the 6-bit numbers at the LSBs.
- For covering the pending range, we fix \text{1}1 at the MSB, and move forward to proceed with the second digit(counting from MSB). Now, since we've already got a \text{0}0 at this position, we can't substitute a \text{1}1 here, since doing so will lead to generation of numbers exceeding numnum. Thus, the only option left here is to substitute a \text{0}0 at the second position. But, if we do so, and consider the 5-bit numbers(at the 5 LSBs) with no two consecutive 1's, these new numbers will fall in the range 1000000−>1011111. But, again we can observe that considering these numbers leads to exceeding the required range. Thus, we can't consider all the 5-bit numbers for the required count by fixing 0 at the second position.
- Thus, now, we fix \text{0}0 at the second position and proceed further. Again, we encounter a \text{1}1 at the third position. Thus, as discussed above, we can fix a \text{0}0 at this position and find out the count of 4-bit consecutive numbers with no two consecutive 1's(by varying only the 4 LSB bits). We can obtain this value from f[4]. Thus, now the numbers in the range 1000000−>1001111 have been covered up.
- Again, as discussed above, now we fix a \text{1}1 at the third position, and proceed with the fourth bit. It is a \text{0}0. So, we need to fix it as such as per the above discussion, and proceed with the fifth bit. It is a \text{1}1. So, we fix a \text{0}0 here and consider all the numbers by varying the two LSBs for finding the required count of numbers in the range \textbf{10101}\text{00} -> \textbf{10101}\text{11}1010100−>1010111. Now, we proceed to the sixth bit, find a \text{0}0 there. So, we fix \text{0}0 at the sixth position and proceed to the seventh bit which is again \text{0}0. So, we fix a \text{0}0 at the seventh position as well.
- Now, we can see, that based on the above procedure, the numbers in the range \textbf{1}\text{000000} -> \textbf{1}\text{111111}1000000−>1111111, \textbf{100}\text{0000} -> \textbf{100}\text{1111}1000000−>1001111, \textbf{100}\text{0000} -> \textbf{100}\text{1111}1000000−>1001111 have been considered and the counts for these ranges have been obtained as f[6]f[6], f[4]f[4] and f[2]f[2] respectively. Now, only \text{1010100}1010100 is pending to be considered in the required count. Since, it doesn't contain any consecutive 1's, we add a 1 to the total count obtained till now to consider this number. Thus, the result returned is f[6]+f[4]+f[2]+1.
- Current 2 / 12
- Now, we look at the case, where numnum contains some consecutive 1's. The idea will be the same as the last example, with the only exception taken when the two consecutive 1's are encountered. Let's say, num = \text{1011010}num=1011010(7 bit number). Now, as per the last discussion, we start with the MSB. We find a \text{1}1 at this position. Thus, we initially fix a \text{0}0 at this position to consider the numbers in the range \textbf{0}\text{000000} -> \textbf{0}\text{111111}0000000−>0111111, by varying the 6 LSB bits only. The count of the required numbers in this range is again given by f[6]f[6].
- Now, we fix a \text{1}1 at the MSB and move on to the second bit. It is a \text{0}0, so we have no choice but to fix \text{0}0 at this position and to proceed with the third bit. It is a \text{1}1, so we fix a \text{0}0 here, considering the numbers in the range \textbf{100}\text{0000} -> \textbf{100}\text{1111}1000000−>1001111. This accounts for a factor of f[4]f[4]. Now, we fix a \text{1}1 at the third positon, and proceed with the fourth bit. It is a \text{1}1(consecutive to the previous \text{1}1). Now, initially we fix a \text{0}0 at the fourth position, considering the numbers in the range \textbf{1010}\text{000} -> \textbf{1010}\text{111}1010000−>1010111. This adds a factor of f[3]f[3] to the required count.
- Now, we can see that till now the numbers in the range \textbf{0}\text{000000} -> \textbf{0}\text{111111}0000000−>0111111, \textbf{100}\text{0000} -> \textbf{100}\text{1111}1000000−>1001111, \textbf{1010}\text{000} -> \textbf{1010}\text{111}1010000−>1010111 have been considered. But, if we try to consider any number larger than \text{1010111}1010111, it leads to the presence of two consecutive 1's in the new number at the third and fourth position. Thus, all the valid numbers upto numnum have been considered with this, giving a resultant count of f[6] + f[4] + f[3]f[6]+f[4]+f[3].
- Current 1 / 8

Thus, summarizing the above discussion, we can say that we
- start scanning the given number num from its MSB.
- For every 1 encountered at the ith bit position(counting from 0 from LSB), we add a factor of f[i]f[i] to the resultant count.
- For every 0 encountered, we don't add any factor. We also keep a track of the last bit checked.
  - If we happen to find two consecutive 1's at any time, we add the factors for the positions of both the 1's and stop the traversal immediately.
  - If we don't find any two consecutive 1's, we proceed till reaching the LSB and add an extra 1 to account for the given number num as well, since the procedure discussed above considers numbers up to num without including itself.

Time complexity : O(log_2(max\_int)=32). One loop to fill ff array and one loop to check all bits of num.
Space complexity : O(log_2(max\_int)=32). ff array of size 32 is used.
*/
class Solution {
    func findIntegers(_ n: Int) -> Int {
        var f = Array(repeating: 0, count: 32)
        f[0] = 1
        f[1] = 2
        for i in 2..<32 {
            f[i] = f[i-1] + f[i-2]
        }
        var i = 30
        var sum = 0
        var pre_bit = 0

        while i >= 0 {
            if n & (1<<i) != 0 {
                sum += f[i]
                if pre_bit == 1 {
                    sum -= 1
                    break
                }
                pre_bit = 1
            } else {
                pre_bit = 0
            }
            i -= 1
        }

        return sum + 1
    }
}