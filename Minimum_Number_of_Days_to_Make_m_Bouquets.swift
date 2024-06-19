/*
You are given an integer array bloomDay, an integer m and an integer k.

You want to make m bouquets. To make a bouquet, you need to use k adjacent flowers from the garden.

The garden consists of n flowers, the ith flower will bloom in the bloomDay[i] and then can be used in exactly one bouquet.

Return the minimum number of days you need to wait to be able to make m bouquets from the garden. If it is impossible to make m bouquets return -1.



Example 1:

Input: bloomDay = [1,10,3,10,2], m = 3, k = 1
Output: 3
Explanation: Let us see what happened in the first three days. x means flower bloomed and _ means flower did not bloom in the garden.
We need 3 bouquets each should contain 1 flower.
After day 1: [x, _, _, _, _]   // we can only make one bouquet.
After day 2: [x, _, _, _, x]   // we can only make two bouquets.
After day 3: [x, _, x, _, x]   // we can make 3 bouquets. The answer is 3.
Example 2:

Input: bloomDay = [1,10,3,10,2], m = 3, k = 2
Output: -1
Explanation: We need 3 bouquets each has 2 flowers, that means we need 6 flowers. We only have 5 flowers so it is impossible to get the needed bouquets and we return -1.
Example 3:

Input: bloomDay = [7,7,7,7,12,7,7], m = 2, k = 3
Output: 12
Explanation: We need 2 bouquets each should have 3 flowers.
Here is the garden after the 7 and 12 days:
After day 7: [x, x, x, x, _, x, x]
We can make one bouquet of the first three flowers that bloomed. We cannot make another bouquet from the last three flowers that bloomed because they are not adjacent.
After day 12: [x, x, x, x, x, x, x]
It is obvious that we can make two bouquets in different ways.


Constraints:

bloomDay.length == n
1 <= n <= 105
1 <= bloomDay[i] <= 109
1 <= m <= 106
1 <= k <= n
*/

/*
Solution 2:
binary search

Time Complexity: O(nlogn)
Space Complexity: O(1)
*/
class Solution {
    func minDays(_ bloomDay: [Int], _ m: Int, _ k: Int) -> Int {
        let n = bloomDay.count
        // Out the flower limitation
        if m * k > n { return -1 }
        var l = 1
        var r = Int(1e9)
        while l < r {
            let mid = l + (r-l) / 2
            if (canMake(bloomDay, m, k, n, mid)) {
                r = mid
            } else {
                l = mid + 1
            }
        }
        return l
    }

    func canMake(_ bloomDay: [Int], _ m: Int, _ k: Int, _ n: Int, _ day: Int) -> Bool {
        var bouquet = 0

        var index = 0
        while index < n {
            var flower = 0
            while flower < k, index < n, bloomDay[index] <= day {
                flower += 1
                index += 1
            }
            if flower == k {
                bouquet += 1
                index -= 1
            }
            // print(flower, bouquet)
            if bouquet >= m {
                return true
            }
            index += 1
        }
        return false
    }
}

/*
Solution 1:
TLE
backtrack

Time Complexity: O(n^m)
Space Complexity: O(n)
*/
class Solution {
    func minDays(_ bloomDay: [Int], _ m: Int, _ k: Int) -> Int {
        let n = bloomDay.count
        // Out the flower limitation
        if m * k > n { return -1 }
        var curMinDay = -1
        var minDay = -1
        check(bloomDay, 0, n, m, k, curMinDay, &minDay)
        return minDay
    }

    func check(_ bloomDay: [Int], _ startIndex: Int, _ n: Int, _ remainBouquets: Int, _ k: Int, _ curMinDay: Int, _ minDay: inout Int) {
        if remainBouquets == 0 {
            if minDay == -1 {
                minDay = curMinDay
            } else {
                minDay = min(minDay, curMinDay)
            }
            return
        }

        // skip useless check
        if minDay > -1, curMinDay > minDay { return }
        if startIndex < (n-k+1) {
            for i in startIndex..<(n-k+1) {
                var tmpMinDay = curMinDay
                for j in i..<(i+k) {
                    tmpMinDay = max(tmpMinDay, bloomDay[j])
                }
                // print(i, tmpMinDay)
                check(bloomDay, i+k, n, remainBouquets-1, k, tmpMinDay, &minDay)
            }
        }
    }
}
