/*
You are given two positive integers n and limit.

Return the total number of ways to distribute n candies among 3 children such that no child gets more than limit candies.



Example 1:

Input: n = 5, limit = 2
Output: 3
Explanation: There are 3 ways to distribute 5 candies such that no child gets more than 2 candies: (1, 2, 2), (2, 1, 2) and (2, 2, 1).
Example 2:

Input: n = 3, limit = 3
Output: 10
Explanation: There are 10 ways to distribute 3 candies such that no child gets more than 3 candies: (0, 0, 3), (0, 1, 2), (0, 2, 1), (0, 3, 0), (1, 0, 2), (1, 1, 1), (1, 2, 0), (2, 0, 1), (2, 1, 0) and (3, 0, 0).


Constraints:

1 <= n <= 106
1 <= limit <= 106

Seen this question in a real interview before?
1/5
Yes
No
Accepted
44,187/88.9K
Acceptance Rate
49.7%
Topics
icon
Companies
Hint 1
We can enumerate the number of candies of one particular child, let it be i which means 0 <= i <= min(limit, n).
Hint 2
Suppose the 2nd child gets j candies. Then 0 <= j <= limit and i + j <= n.
Hint 3
The 3rd child will hence get n - i - j candies and we should have 0 <= n - i - j <= limit.
Hint 4
After some transformations, for each i, we have max(0, n - i - limit) <= j <= min(limit, n - i), each j corresponding to a solution. So the number of solutions for some i is max(min(limit, n - i) - max(0, n - i - limit) + 1, 0). Sum the expression for every i in [0, min(n, limit)].
*/

class Solution {
    func distributeCandies(_ n: Int, _ limit: Int) -> Int {
        // 1st children i, 0 <= i <= min(limit, n)
        // 2nd children j, 0 <= j <= limit, i+j <= n
        // 3rd children n-i-j, 0 <= n-i-j <= limit
        // for each i, max(0, n-i-limit) <= j <= min(limit, n-i)
        var res = 0
        for i in 0...min(n, limit) {
            res += max(0, min(limit, n-i) - max(0, n-i-limit) + 1)
        }
        return res
    }
}
