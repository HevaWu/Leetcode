/*
There are buckets buckets of liquid, where exactly one of the buckets is poisonous. To figure out which one is poisonous, you feed some number of (poor) pigs the liquid to see whether they will die or not. Unfortunately, you only have minutesToTest minutes to determine which bucket is poisonous.

You can feed the pigs according to these steps:

Choose some live pigs to feed.
For each pig, choose which buckets to feed it. The pig will consume all the chosen buckets simultaneously and will take no time.
Wait for minutesToDie minutes. You may not feed any other pigs during this time.
After minutesToDie minutes have passed, any pigs that have been fed the poisonous bucket will die, and all others will survive.
Repeat this process until you run out of time.
Given buckets, minutesToDie, and minutesToTest, return the minimum number of pigs needed to figure out which bucket is poisonous within the allotted time.



Example 1:

Input: buckets = 1000, minutesToDie = 15, minutesToTest = 60
Output: 5
Example 2:

Input: buckets = 4, minutesToDie = 15, minutesToTest = 15
Output: 2
Example 3:

Input: buckets = 4, minutesToDie = 15, minutesToTest = 30
Output: 2


Constraints:

1 <= buckets <= 1000
1 <= minutesToDie <= minutesToTest <= 100
*/

/*
Solution 2:
math log

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func poorPigs(_ buckets: Int, _ minutesToDie: Int, _ minutesToTest: Int) -> Int {
        // tests
        let t = Double(minutesToTest / minutesToDie + 1)
        var buckets = Double(buckets)
        let pigs = Int(log10(buckets) / log10(t))

        return pow(t, Double(pigs)) == buckets
        ? pigs
        : pigs + 1
    }
}


/*
Solution 1:
math pow

with x pigs and T tests
Find minimum x such that (T+1)^x >= N

With 2 pigs, poison killing in 15 minutes, and having 60 minutes, we can find the poison in up to 25 buckets in the following way. Arrange the buckets in a 5×5 square:

 1  2  3  4  5
 6  7  8  9 10
11 12 13 14 15
16 17 18 19 20
21 22 23 24 25
Now use one pig to find the row (make it drink from buckets 1, 2, 3, 4, 5, wait 15 minutes, make it drink from buckets 6, 7, 8, 9, 10, wait 15 minutes, etc). Use the second pig to find the column (make it drink 1, 6, 11, 16, 21, then 2, 7, 12, 17, 22, etc).

Having 60 minutes and tests taking 15 minutes means we can run four tests. If the row pig dies in the third test, the poison is in the third row. If the column pig doesn't die at all, the poison is in the fifth column (this is why we can cover five rows/columns even though we can only run four tests).

With 3 pigs, we can similarly use a 5×5×5 cube instead of a 5×5 square and again use one pig to determine the coordinate of one dimension. So 3 pigs can solve up to 125 buckets.

In general, we can solve up to (⌊minutesToTest / minutesToDie⌋ + 1)^pigs buckets this way, so just find the smallest sufficient number of pigs

(⌊minutesToTest / minutesToDie⌋ + 1)^pigs buckets
*/
class Solution {
    func poorPigs(_ buckets: Int, _ minutesToDie: Int, _ minutesToTest: Int) -> Int {
        // tests
        let t = Double(minutesToTest / minutesToDie + 1)

        // number of pigs,
        // start from 0 to caculate 1,1,1 exactly
        var pigs = Double(0)
        var buckets = Double(buckets)

        while pow(t, pigs) < buckets {
            pigs += 1
        }
        return Int(pigs)
    }
}