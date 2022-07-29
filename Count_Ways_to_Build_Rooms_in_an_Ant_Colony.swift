/*
You are an ant tasked with adding n new rooms numbered 0 to n-1 to your colony. You are given the expansion plan as a 0-indexed integer array of length n, prevRoom, where prevRoom[i] indicates that you must build room prevRoom[i] before building room i, and these two rooms must be connected directly. Room 0 is already built, so prevRoom[0] = -1. The expansion plan is given such that once all the rooms are built, every room will be reachable from room 0.

You can only build one room at a time, and you can travel freely between rooms you have already built only if they are connected. You can choose to build any room as long as its previous room is already built.

Return the number of different orders you can build all the rooms in. Since the answer may be large, return it modulo 109 + 7.



Example 1:


Input: prevRoom = [-1,0,1]
Output: 1
Explanation: There is only one way to build the additional rooms: 0 → 1 → 2
Example 2:


Input: prevRoom = [-1,0,0,1,2]
Output: 6
Explanation:
The 6 ways are:
0 → 1 → 3 → 2 → 4
0 → 2 → 4 → 1 → 3
0 → 1 → 2 → 3 → 4
0 → 1 → 2 → 4 → 3
0 → 2 → 1 → 3 → 4
0 → 2 → 1 → 4 → 3


Constraints:

n == prevRoom.length
2 <= n <= 105
prevRoom[0] == -1
0 <= prevRoom[i] < n for all 1 <= i < n
Every room is reachable from room 0 once all the rooms are built.
*/

/*
Solution 1:

view the ant colony as a tree.

Define dfs(cur) as the number of ways to build rooms if we start at node cur. The base case is simply dfs(leaf) = 1, but the recursive step is kind of tricky.

- First think of a simple scenairo where a node has two branches and each branch is a chain (dfs(child) = 1). What is dfs(cur)? This is equivalent to count the number of ways to combine two arrays and maintain their original order. Say the lengths of these two arrays are l and r, the answer is math.comb(l+r, l). Another way of thinking this is to put l items into l+r spots and fill the remaining spots with the other r items.
- Next, what if the branch is not a chain? Say dfs(left_child)=x and dfs(right_child)=y. We just multiply them together. So the solution becomes x * y * math.comb(l+r, l).
- Finally, what if there are many branches? We can combine them one by one: take the leftmost two branches first, get the merged branch, merge it with the third branch, and so on.
*/
class Solution {
    func waysToBuildRooms(_ prevRoom: [Int]) -> Int {
        let n = prevRoom.count
        countFact(n)
        print(fact)

        var pre = Array(repeating: [Int](), count: n)
        // skip 0 room, its prev is -1
        for i in 1..<n {
            pre[prevRoom[i]].append(i)
        }

        func dfs(_ cur: Int) -> (ways: Double, next: Int) {
            if pre[cur].isEmpty {
                return (1, 1)
            }
            var ways: Double = 1
            var left = 0
            for next in pre[cur] {
                let (temp, right) = dfs(next)
                ways = (ways * temp * C(left+right, right)).truncatingRemainder(dividingBy: mod)
                left += right
            }
            return (ways, left+1)
        }

        print(dfs(0).ways)
        return Int(dfs(0).ways.truncatingRemainder(dividingBy: mod))
    }

    func countFact(_ n: Int) {
        fact = Array(repeating: 0, count: n+1)
        fact[0] = 1.0
        for i in 1...n {
            fact[i] = (fact[i-1] * Double(i)).truncatingRemainder(dividingBy: mod)
        }
    }

    var fact = [Double]()
    let mod: Double = 1e9 + 7
    // (n, k) = n! / (k! * (n-k)!)
    func C(_ n: Int, _ k: Int) -> Double {
        let b = (fact[k] * fact[n-k]).truncatingRemainder(dividingBy: mod)
        let a = fact[n]

        // need to find a proper way to calculate this
        let val = (a / b).truncatingRemainder(dividingBy: mod)
        // defer {
        //     print(n, k, val)
        // }
        return val
    }
}

/*
without consider Double
*/
class Solution {
    func waysToBuildRooms(_ prevRoom: [Int]) -> Int {
        let n = prevRoom.count
        countFact(n)
        // print(fact)

        var pre = Array(repeating: [Int](), count: n)
        // skip 0 room, its prev is -1
        for i in 1..<n {
            pre[prevRoom[i]].append(i)
        }

        func dfs(_ cur: Int) -> (ways: Int, next: Int) {
            if pre[cur].isEmpty {
                return (1, 1)
            }
            var ways = 1
            var left = 0
            for next in pre[cur] {
                let (temp, right) = dfs(next)
                ways = (ways * temp * C(left+right, right)) % mod
                left += right
            }
            return (ways, left+1)
        }

        return dfs(0).ways
    }

    func countFact(_ n: Int) {
        fact = Array(repeating: 0, count: n+1)
        fact[0] = 1
        for i in 1...n {
            fact[i] = fact[i-1] * i
        }
    }

    var fact = [Int]()
    let mod = Int(1e9 + 7)
    func C(_ n: Int, _ k: Int) -> Int {
        return fact[n] / (fact[k] * fact[n-k])
    }
}