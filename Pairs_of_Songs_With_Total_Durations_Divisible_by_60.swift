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
    func numPairsDivisibleBy60(_ time: [Int]) -> Int {
        var pair = 0
        var tarr = Array(repeating: 0, count: 60)
        for t in time {
            tarr[t % 60] += 1
        }

        for i in 0..<60 where tarr[i] > 0 {
            let freq = tarr[i]

            // check if itself can make any pair
            if i == 0 || i == 30 {
                pair += (freq * (freq - 1)) / 2
            }

            // check i and 60 - i can build pair or not
            if i > 0, i < 30, tarr[60 - i] > 0 {
                pair += freq * tarr[60 - i]
            }
        }
        return pair
    }
}

/*
Solution 1:
Map
convert array to map, key is unique time, value is unique time frequency
go through the map.keys, check if there is any pair which is divisible by 60
- first check if key + key is divisible by 60
- second check if key + other key is divisible by 60

We only need to consider each song length modulo 60.

Time Complexity: O(n + m^2)
- where m is map.keys.count
Space Complexity: O(m)
*/
class Solution {
    func numPairsDivisibleBy60(_ time: [Int]) -> Int {
        var tmap = [Int: Int]()
        for t in time {
            // store % 60 is enough
            tmap[t % 60, default: 0] += 1
        }

        let tkey: [Int] = Array(tmap.keys)
        var pair = 0
        for i in 0..<tkey.count {
            let t1 = tkey[i]
            // check if t1 + t1 is divisible by 60
            if let v1 = tmap[t1], v1 > 1, (t1 + t1) % 60 == 0 {
                pair += (v1 * (v1 - 1)) / 2
            }

            for j in (i+1)..<tkey.count {
                // check if t1 + t2 is divisible by 60
                let t2 = tkey[j]
                if (t1 + t2) % 60 == 0 {
                    pair += tmap[t1, default: 0] * tmap[t2, default: 0]
                }
            }
        }
        return pair
    }
}