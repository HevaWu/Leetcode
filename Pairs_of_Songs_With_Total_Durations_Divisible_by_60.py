'''
You are given a list of songs where the ith song has a duration of time[i] seconds.

Return the number of pairs of songs for which their total duration in seconds is divisible by 60. Formally, we want the number of indices i, j such that i < j with (time[i] + time[j]) % 60 == 0.



Example 1:

Input: time = [30,20,150,100,40]
Output: 3
Explanation: Three pairs have a total duration divisible by 60:
(time[0] = 30, time[2] = 150): total duration 180
(time[1] = 20, time[3] = 100): total duration 120
(time[1] = 20, time[4] = 40): total duration 60
Example 2:

Input: time = [60,60,60]
Output: 3
Explanation: All three pairs have a total duration of 120, which is divisible by 60.


Constraints:

1 <= time.length <= 6 * 104
1 <= time[i] <= 500
'''

'''
Solution 2:
array + % 60 key
We only need to consider each song length modulo 60.
We can count the number of songs with (length % 60) equal to r, and store that in an array of size 60.

Time Complexity: O(n)
Space Complexity: O(1), length of 60 array
'''
class Solution:
    def numPairsDivisibleBy60(self, time: List[int]) -> int:
        pair = 0
        tarr = [0 for i in range(60)]
        for t in time:
            tarr[t % 60] += 1
        for i in range(60):
            if i == 0 or i == 30:
                pair += (tarr[i] * (tarr[i] - 1)) / 2
            if i > 0 and i < 30 and tarr[60 - i] > 0:
                pair += tarr[i] * tarr[60 - i]
        return int(pair)
