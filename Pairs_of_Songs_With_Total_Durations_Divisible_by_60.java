/*
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
*/


/*
Solution 2:
array + % 60 key
We only need to consider each song length modulo 60.
We can count the number of songs with (length % 60) equal to r, and store that in an array of size 60.

Time Complexity: O(n)
Space Complexity: O(1), length of 60 array
*/
class Solution {
    public int numPairsDivisibleBy60(int[] time) {
        int pair = 0;
        int[] tarr = new int[60];

        for (int t: time) {
            tarr[t % 60] += 1;
        }

        for (int i = 0; i < 60; i++) {
            int freq = tarr[i];
            if (i == 0 || i == 30) {
                pair += (freq * (freq-1)) / 2;
            }
            if (i > 0 && i < 30 && tarr[60 - i] > 0) {
                pair += freq * tarr[60 - i];
            }
        }

        return pair;
    }
}