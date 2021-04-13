/*
Given two integers n and k, you need to construct a list which contains n different positive integers ranging from 1 to n and obeys the following requirement:
Suppose this list is [a1, a2, a3, ... , an], then the list [|a1 - a2|, |a2 - a3|, |a3 - a4|, ... , |an-1 - an|] has exactly k distinct integers.

If there are multiple answers, print any of them.

Example 1:
Input: n = 3, k = 1
Output: [1, 2, 3]
Explanation: The [1, 2, 3] has three different positive integers ranging from 1 to 3, and the [1, 1] has exactly 1 distinct integer: 1.
Example 2:
Input: n = 3, k = 2
Output: [1, 3, 2]
Explanation: The [1, 3, 2] has three different positive integers ranging from 1 to 3, and the [2, 1] has exactly 2 distinct integers: 1 and 2.
Note:
The n and k are in the range 1 <= k < n <= 104.
*/

/*
Solution 2:

As before, write [1, 2, ..., n-k-1] first.
The remaining k+1 elements to be written are [n-k, n-k+1, ..., n],
and we'll write them in alternating head and tail order.

When we are writing the i th element from the remaining k+1,
every even i is going to be chosen from the head, and will have value n-k + i//2.
Every odd i is going to be chosen from the tail, and will have value n - i//2.

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func constructArray(_ n: Int, _ k: Int) -> [Int] {
        var res = Array(repeating: 0, count: n)
        var index = 0
        for i in 1..<n-k {
            res[index] = i
            index += 1
        }
        for i in 0...k {
            res[index] = (i%2 == 0) ? (n-k+i/2) : (n-i/2)
            index += 1
        }
        return res
    }
}

/*
Solution 1:
use set to help checking already appended num

Idea:
- when k != 0, use pre to calculate next
  - first set next as (pre-k), if next <= 0 || set.contains(next), set next to pre+k
    - we can guarantee at this part, we will always find a valid number append to array
  - update pre, append next to res, insert next to set
- check if res is match n count, if so, return res
- if not, go through 1...n, check which num is not append, then added to res

Time Complexity: O(k+n)
Space Complexity: O(n)
*/
class Solution {
    func constructArray(_ n: Int, _ k: Int) -> [Int] {
        if k == 1 { return Array(1...n) }
        var res = [1]
        var set = Set<Int>()
        set.insert(1)

        var k = k
        var pre = 1
        while k != 0 {
            var next = pre-k
            if pre-k <= 0 || set.contains(next) {
                next = pre+k
            }

            res.append(next)
            pre = next
            set.insert(next)
            k -= 1
        }

        if res.count == n { return res }
        for i in 1...n {
            if !set.contains(i) {
                res.append(i)
            }
        }
        return res
    }
}