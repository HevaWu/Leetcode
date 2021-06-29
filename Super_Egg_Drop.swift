/*
You are given k identical eggs and you have access to a building with n floors labeled from 1 to n.

You know that there exists a floor f where 0 <= f <= n such that any egg dropped at a floor higher than f will break, and any egg dropped at or below floor f will not break.

Each move, you may take an unbroken egg and drop it from any floor x (where 1 <= x <= n). If the egg breaks, you can no longer use it. However, if the egg does not break, you may reuse it in future moves.

Return the minimum number of moves that you need to determine with certainty what the value of f is.



Example 1:

Input: k = 1, n = 2
Output: 2
Explanation:
Drop the egg from floor 1. If it breaks, we know that f = 0.
Otherwise, drop the egg from floor 2. If it breaks, we know that f = 1.
If it does not break, then we know f = 2.
Hence, we need at minimum 2 moves to determine with certainty what the value of f is.
Example 2:

Input: k = 2, n = 6
Output: 3
Example 3:

Input: k = 3, n = 14
Output: 4


Constraints:

1 <= k <= 100
1 <= n <= 104

*/

/*
Solution 3:
f(T,K)=1+f(T−1,K−1)+f(T−1,K)
f(t,1)=t when t≥1, and f(1, k) = 1 when k≥1.

f(T,K−1)=1+f(T−1,K−2)+f(T−1,K−1)

g(t,k)=g(t−1,k)+g(t−1,k−1)
f(t,k)= 1≤x≤K∑ g(t,x)=∑(xt)

Time Complexity: O(k logn)
Space Complexity: O(1)
*/
class Solution {
    func superEggDrop(_ k: Int, _ n: Int) -> Int {
        if k == 1 { return n }

        var left = 1
        var right = n
        while left < right {
            let mid = left + (right-left)/2
            if f(mid, k, n) < n {
                left = mid+1
            } else {
                right = mid
            }
        }
        return left
    }

    func f(_ x: Int, _ k: Int, _ n: Int) -> Int {
        var res = 0
        var r = 1
        for i in 1...k {
            r *= (x-i+1)
            r /= i
            res += r
            if res >= n { break }
        }
        return res
    }
}

/*
Solution 2:

As in Approach 1, we try to speed up our O(KN^2) algorithm. Again, for a state of K eggs and N floors, where dp(K,N) is the answer for that state, we have:

dp(K,N)= 1≤X≤Nmin (max(dp(K−1,X−1),dp(K,N−X)))

Now, X∅=opt(K,N) is the smallest X for which that minimum is attained: that is, the smallest value for which

dp(K,N)=(max(dp(K−1,X∅−1),dp(K,N−X∅)))

The key insight that we will develop below, is that opt(K,N) is an increasing function in N.

Time Complexity: O(nk)
Space Complexity: O(n)
*/
class Solution {
    func superEggDrop(_ k: Int, _ n: Int) -> Int {
        if k == 1 { return n }

        var dp = Array(repeating: 0, count: n+1)
        for i in 1...n {
            dp[i] = i
        }

        for t in 2...k {
            var temp = Array(repeating: 0, count: n+1)
            var x = 1
            for i in 1...n {
                while x < i, max(dp[x-1], temp[i-x]) > max(dp[x], temp[i-x-1]) {
                    x += 1
                }

                temp[i] = 1 + max(dp[x-1], temp[i-x])
            }

            dp = temp
        }
        return dp[n]
    }
}

/*
Solution 1:
DP

It's natural to attempt dynamic programming, as we encounter similar subproblems. Our state is (K, N): K eggs and N floors left. When we drop an egg from floor X, it either survives and we have state (K, N-X), or it breaks and we have state (K-1, X-1).

This approach would lead to a O(K N^2) algorithm, but this is not efficient enough for the given constraints. However, we can try to speed it up. Let dp(K, N) be the maximum number of moves needed to solve the problem in state (K, N). Then, by our reasoning above, we have:

dp(K,N)= 1≤X≤Nmin (max(dp(K−1,X−1),dp(K,N−X)))

Now for the key insight: Because dp(K,N) is a function that is increasing on NN, the first term T1=dp(K−1,X−1) in our max expression is an increasing function on XX, and the second term T2=dp(K,N−X) is a decreasing function on X. This means that we do not need to check every X to find the minimum -- instead, we can binary search for the best X.

Time Complexity: O(nlogn k)
Space Complexity: O(nk)
*/
class Solution {
    func superEggDrop(_ k: Int, _ n: Int) -> Int {
        var moves: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: k+1),
            count: n+1
        )

        return check(n, k, &moves)
    }

    func check(_ n: Int, _ k: Int, _ moves: inout [[Int?]]) -> Int {
        if let val = moves[n][k] { return val }
        var val = 0

        if n == 0 {
            val = 0
        } else if k == 1 {
            val = n
        } else {
            var left = 1
            var right = n

            while left+1 < right {
                let mid = left + (right-left)/2

                let t1 = check(mid-1, k-1, &moves)
                let t2 = check(n-mid, k, &moves)

                if t1 < t2 {
                    left = mid
                } else if t1 > t2 {
                    right = mid
                } else {
                    left = mid
                    right = mid
                }
            }

            val = 1 + min(
                max(check(left-1, k-1, &moves), check(n-left, k, &moves)),
                max(check(right-1, k-1, &moves), check(n-right, k, &moves))
            )
        }

        moves[n][k] = val
        return val
    }
}