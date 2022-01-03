/*
In a town, there are n people labeled from 1 to n. There is a rumor that one of these people is secretly the town judge.

If the town judge exists, then:

The town judge trusts nobody.
Everybody (except for the town judge) trusts the town judge.
There is exactly one person that satisfies properties 1 and 2.
You are given an array trust where trust[i] = [ai, bi] representing that the person labeled ai trusts the person labeled bi.

Return the label of the town judge if the town judge exists and can be identified, or return -1 otherwise.



Example 1:

Input: n = 2, trust = [[1,2]]
Output: 2
Example 2:

Input: n = 3, trust = [[1,3],[2,3]]
Output: 3
Example 3:

Input: n = 3, trust = [[1,3],[2,3],[3,1]]
Output: -1


Constraints:

1 <= n <= 1000
0 <= trust.length <= 104
trust[i].length == 2
All the pairs of trust are unique.
ai != bi
1 <= ai, bi <= n
*/

/*
Solution 3:
use check array
person who trust people will - 1
person who be trusted will + 1
should only have one person got n-1 score, which means trust by everyone else

Time Complexity: O(n + m)
- m is trust.count
Space Complexity: O(n)
*/
class Solution {
    func findJudge(_ n: Int, _ trust: [[Int]]) -> Int {
        var check = Array(repeating: 0, count: n+1)
        for t in trust {
            check[t[0]] -= 1
            check[t[1]] += 1
        }
        for i in 1...n {
            if check[i] == n-1 {
                return i
            }
        }
        return -1
    }
}

/*
Solution 2:
Make trustSet to filter person who trust nobody
then loop trust again to check if everyone trust judge

Time Complexity: O(m)
Space Complexity: O(n)
*/
class Solution {
    func findJudge(_ n: Int, _ trust: [[Int]]) -> Int {
        // person who trust nobody
        var trustSet = Set<Int>(1...n)
        for t in trust {
            trustSet.remove(t[0])
        }

        // should only have one judge
        guard trustSet.count == 1 else { return -1 }
        let judge = trustSet.removeFirst()

        // person who trust judge
        trustSet = Set<Int>(1...n)
        for t in trust {
            if t[1] == judge {
                trustSet.remove(t[0])
            }
        }
        // should only left one person which is judge itself
        guard trustSet.count == 1 else { return -1 }
        return judge
    }
}

/*
Solution 1:
make trustMap
key is people, value is set of person this people trust

1. build trustMap
2. find town judge (only person who trust nobody)
3. check if everyone except judge, trust the judge

Time Complexity: O(m + n)
- m is trust.count
Space Complexity: O(n^2)
*/
class Solution {
    func findJudge(_ n: Int, _ trust: [[Int]]) -> Int {
        if trust.isEmpty {
            return n == 1 ? 1 : -1
        }

        var trustMap = Array(repeating: Set<Int>(), count: n+1)
        for t in trust {
            trustMap[t[0]].insert(t[1])
        }

        var judge = -1
        for i in 1...n {
            if trustMap[i].count == 0 {
                if judge == -1 {
                    judge = i
                } else {
                    // 2 more people trust nobody
                    return -1
                }
            }
        }

        // check if everyone is trust town judge
        for i in 1...n where i != judge {
            if !trustMap[i].contains(judge) {
                // find people not trust judge
                return -1
            }
        }
        return judge
    }
}