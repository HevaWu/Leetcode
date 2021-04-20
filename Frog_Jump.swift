/*
A frog is crossing a river. The river is divided into some number of units, and at each unit, there may or may not exist a stone. The frog can jump on a stone, but it must not jump into the water.

Given a list of stones' positions (in units) in sorted ascending order, determine if the frog can cross the river by landing on the last stone. Initially, the frog is on the first stone and assumes the first jump must be 1 unit.

If the frog's last jump was k units, its next jump must be either k - 1, k, or k + 1 units. The frog can only jump in the forward direction.



Example 1:

Input: stones = [0,1,3,5,6,8,12,17]
Output: true
Explanation: The frog can jump to the last stone by jumping 1 unit to the 2nd stone, then 2 units to the 3rd stone, then 2 units to the 4th stone, then 3 units to the 6th stone, 4 units to the 7th stone, and 5 units to the 8th stone.
Example 2:

Input: stones = [0,1,2,3,4,8,9,11]
Output: false
Explanation: There is no way to jump to the last stone as the gap between the 5th and 6th stone is too large.


Constraints:

2 <= stones.length <= 2000
0 <= stones[i] <= 231 - 1
stones[0] == 0
*/

/*
Solution 1:
DP

                +----+    +----+        +----+     +----+
stone:          | S1 |    | S2 |        | S3 |     | S4 |
            ____|____|____|____|________|____|_____|____|____________
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
position:"         0         1             3          5             "

jump size:         1     [0, 1, 2]     [1, 2, 3]

Suppose we want to know if the frog can reach stone 2 (S2),
and we know the frog must come from S1,
dist(S1->S2) = 1 - 0 = 1, and we already know the frog is able to make a jump of size 1 at S1.
Hence, the frog is able to reach S2, and the next jump would be 0, 1 or 2 units.


Then, we want to know if the frog can reach stone 3 (S3),
we know the frog must be at either S1 or S2 before reaching S3,

If the frog comes from S1, then
we know dist(S1->S3) = 3 - 0 = 3, and we know frog couldn't make a jump of size 3 at S1.
So it is not possible the frog can jump from S1 to S3.

If the frog comes from S2, then
we know dist(S2->S3) = 3 - 1 = 2, and we know frog could make a jump of size 2 at S2.
Hence, the frog is able to reach S3, and the next jump would be 1, 2 or 3 units.

If we repeat doing this for the rest stones, we'll end with something like below:
Exapme 1:

index:        0   1   2   3   4   5   6   7
            +---+---+---+---+---+---+---+---+
stone pos:  | 0 | 1 | 3 | 5 | 6 | 8 | 12| 17|
            +---+---+---+---+---+---+---+---+
k:          | 1 | 0 | 1 | 1 | 0 | 1 | 3 | 5 |
            |   | 1 | 2 | 2 | 1 | 2 | 4 | 6 |
            |   | 2 | 3 | 3 | 2 | 3 | 5 | 7 |
            |   |   |   |   | 3 | 4 |   |   |
            |   |   |   |   | 4 |   |   |   |
            |   |   |   |   |   |   |   |   |

Sub-problem and state:
let dp(i) denote a set containing all next jump size at stone i

Recurrence relation:
for any j < i,
dist = stones[i] - stones[j];
if dist is in dp(j):
    put dist - 1, dist, dist + 1 into dp(i).

Now lets make this approach more efficient.
BECAUSE
1. The number of stones is ≥ 2 and is < 1,100.
2. The frog is on the first stone and assume the first jump must be 1 unit.
3. If the frog's last jump was k units, then its next jump must be either k - 1, k, or k + 1 units,

The maximum jump size the frog can make at each stone if possible is shown as followings:
stone:      0, 1, 2, 3, 4, 5
jump size:  1, 2, 3, 4, 5, 6 (suppose frog made jump with size k + 1 at each stone)

So instead of creating a HashSet for lookup for each stone,
we can create a boolean array with size of N + 1 (N is the number of stones),
Like in the given example, at stone 2 the next jump could be 1, 2, 3,
we can use a bool array to represent this like
index:    0  1  2  3  4  5  6  7  ...
         [0, 1, 1, 1, 0, 0, 0, 0, ...]
index is jump size, boolean value represents if the frog can make this jump.

Then, the 2D array will be something like below.

index:        0   1   2   3   4   5   6   7
            +---+---+---+---+---+---+---+---+
stone pos:  | 0 | 1 | 3 | 5 | 6 | 8 | 12| 17|
            +---+---+---+---+---+---+---+---+
k:        0 | 0 | 1 | 0 | 0 | 1 | 0 | 0 | 0 |
          1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 |
          2 | 0 | 1 | 1 | 1 | 1 | 1 | 0 | 0 |
          3 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 0 |
          4 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 0 |
          5 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 |
          6 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
          7 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |

// Sub-problem and state:
let dp[i][j] denote at stone i, the frog can or cannot make jump of size j

// Recurrence relation:
for any j < i,
dist = stones[i] - stones[j];
if dp[j][dist]:
    dp[i][dist - 1] = ture
    dp[i][dist] = ture
    dp[i][dist + 1] = ture

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func canCross(_ stones: [Int]) -> Bool {
        let n = stones.count

        // dp[i][j] - at stone i, frog can/cannot make jump of size j
        var dp = Array(
            repeating: Array(repeating: false, count: n+1),
            count: n
        )
        dp[0][1] = true

        for i in 1..<n {
            for j in 0..<i {
                let diff = stones[i] - stones[j]
                // check if at stone j, can jump to stone i or not
                if diff < 0 || diff > n || !dp[j][diff] { continue }
                dp[i][diff] = true
                if diff-1 >= 0 { dp[i][diff-1] = true }
                if diff+1 <= n { dp[i][diff+1] = true }

                // can jump to n-1 stone (last stone)
                if i == n-1 { return true }
            }
        }
        return false
    }
}