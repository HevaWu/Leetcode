/*
You have an inventory of different colored balls, and there is a customer that wants orders balls of any color.

The customer weirdly values the colored balls. Each colored ball's value is the number of balls of that color you currently have in your inventory. For example, if you own 6 yellow balls, the customer would pay 6 for the first yellow ball. After the transaction, there are only 5 yellow balls left, so the next yellow ball is then valued at 5 (i.e., the value of the balls decreases as you sell more to the customer).

You are given an integer array, inventory, where inventory[i] represents the number of balls of the ith color that you initially own. You are also given an integer orders, which represents the total number of balls that the customer wants. You can sell the balls in any order.

Return the maximum total value that you can attain after selling orders colored balls. As the answer may be too large, return it modulo 109 + 7.



Example 1:


Input: inventory = [2,5], orders = 4
Output: 14
Explanation: Sell the 1st color 1 time (2) and the 2nd color 3 times (5 + 4 + 3).
The maximum total value is 2 + 5 + 4 + 3 = 14.
Example 2:

Input: inventory = [3,5], orders = 6
Output: 19
Explanation: Sell the 1st color 2 times (3 + 2) and the 2nd color 4 times (5 + 4 + 3 + 2).
The maximum total value is 3 + 2 + 5 + 4 + 3 + 2 = 19.
Example 3:

Input: inventory = [2,8,4,10,6], orders = 20
Output: 110
Example 4:

Input: inventory = [1000000000], orders = 1000000000
Output: 21
Explanation: Sell the 1st color 1000000000 times for a total value of 500000000500000000. 500000000500000000 modulo 109 + 7 = 21.


Constraints:

1 <= inventory.length <= 105
1 <= inventory[i] <= 109
1 <= orders <= min(sum(inventory[i]), 109)

*/

/*
Solution 3:
Greedy

Time Complexity: O(nlogn)
Space Complexity: O(1)
*/
class Solution {
    func maxProfit(_ inventory: [Int], _ orders: Int) -> Int {
        let mod = Int(1e9 + 7)

        var inventory = inventory.sorted(by: >)
        let n = inventory.count

        var orders = orders
        var cur = inventory[0]
        var profit = 0
        var i = 0
        while orders > 0 {
            while i < n, inventory[i] == cur {
                i += 1
            }

            let next = i == n ? 0 : inventory[i]
            var diff = cur - next
            var remain = 0
            var count = min(orders, i * diff)

            if orders < i * diff {
                diff = orders / i
                remain = orders % i
            }

            let val = cur - diff
            profit = (profit + (cur + val + 1) * diff / 2 * i + val * remain) % mod

            orders -= count
            cur = next
        }

        return profit
    }
}

/*
Solution 2:
binary + map
*/
class Solution {
    func maxProfit(_ inventory: [Int], _ orders: Int) -> Int {
        let mod = Int(1e9 + 7)

        var l = 0
        var r = 0

        // num: freq
        var map = [Int: Int]()
        for i in inventory {
            map[i, default: 0] += 1
            r = max(r, i)
        }

        while l+1 < r {
            let mid = l+(r-l)/2
            if valid(mid, orders, map) {
                l = mid
            } else {
                r = mid
            }
        }

        // print(l, r)

        var profit = 0
        var orders = orders
        for (k, v) in map {
            if k <= r { break }
            orders -= v * (k - r)
            profit = (profit + (k+r+1) * (k-r) / 2 * v) % mod
        }

        if orders > 0 {
            profit = (profit + r * orders) % mod
        }
        return profit
    }

    func valid(_ mid: Int, _ orders: Int, _ map: [Int: Int]) -> Bool {
        var orders = orders
        for (k, v) in map {
            if k <= mid { break }
            orders -= (v * (k - mid))
            if orders <= 0 { return true }
        }
        return orders <= 0
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func maxProfit(_ inventory: [Int], _ orders: Int) -> Int {
        var inventory = inventory.sorted(by: >)
        let n = inventory.count

        let mod = Int(1e9 + 7)
        var orders = orders

        if n == 1 {
            if orders >= inventory[0] {
                // sale all balls
                return ((inventory[0] * (inventory[0] + 1)) / 2 ) % mod
            } else {
                let remain = inventory[0] - orders
                return ((inventory[0] * (inventory[0] + 1)) / 2 - (remain * (remain + 1)) / 2) % mod
            }
        }

        var profit = 0
        while orders > 0, inventory[0] > 0 {
            var l = 0
            var r = 0
            while r < n, inventory[l] == inventory[r] {
                r += 1
            }

            let next = r < n ? inventory[r] : 0
            let count = r-l
            let diff = inventory[l] - next

            let take = diff * count
            if orders >= take {
                let maxP = count * ((inventory[l] * (inventory[l] + 1)) - (next * (next + 1))) / 2
                orders -= take
                profit = (profit + maxP) % mod

                inventory[l..<r] = Array(repeating: next, count: count)[0...]
            } else {
                var cur = inventory[l]
                while orders > 0, cur > next {
                    if count < orders {
                        profit = (profit + cur * count) % mod
                        orders -= count
                    } else {
                        profit = (profit + cur * orders) % mod
                        orders = 0
                    }

                    cur -= 1
                }
                if orders > 0 {
                    inventory[l..<r] = Array(repeating: cur, count: count)[0...]
                }
            }
        }

        return profit
    }
}