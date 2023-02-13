'''
Given two non-negative integers low and high. Return the count of odd numbers between low and high (inclusive).



Example 1:

Input: low = 3, high = 7
Output: 3
Explanation: The odd numbers between 3 and 7 are [3,5,7].
Example 2:

Input: low = 8, high = 10
Output: 1
Explanation: The odd numbers between 8 and 10 are [9].


Constraints:

0 <= low <= high <= 10^9
'''

'''
Solution 1:
count odd number for [0...high] - [0..<low]

Time Complexity: O(1)
Space Complexity: O(1)
'''
class Solution:
    def countOdds(self, low: int, high: int) -> int:
        def countOddNumber(num: int) -> int:
            return num//2 if num%2 == 0 else num//2+1
        return countOddNumber(high) - countOddNumber(low-1 if low>0 else 0)
