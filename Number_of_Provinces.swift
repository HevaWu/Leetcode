/*
There are n cities. Some of them are connected, while some are not. If city a is connected directly with city b, and city b is connected directly with city c, then city a is connected indirectly with city c.

A province is a group of directly or indirectly connected cities and no other cities outside of the group.

You are given an n x n matrix isConnected where isConnected[i][j] = 1 if the ith city and the jth city are directly connected, and isConnected[i][j] = 0 otherwise.

Return the total number of provinces.



Example 1:


Input: isConnected = [[1,1,0],[1,1,0],[0,0,1]]
Output: 2
Example 2:


Input: isConnected = [[1,0,0],[0,1,0],[0,0,1]]
Output: 3


Constraints:

1 <= n <= 200
n == isConnected.length
n == isConnected[i].length
isConnected[i][j] is 1 or 0.
isConnected[i][i] == 1
isConnected[i][j] == isConnected[j][i]
*/

/*
Solution 1:
UF

union find to build connection for 2 connected cities
then use set to find all same cities

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func findCircleNum(_ isConnected: [[Int]]) -> Int {
        let n = isConnected.count
        let uf = UF(n)
        for i in 1..<n {
            for j in 0..<i {
                if isConnected[i][j] == 1 {
                    uf.union(i, j)
                }
            }
        }

        var province = Set<Int>()
        for i in 0..<n {
            province.insert(uf.find(i))
        }
        return province.count
    }
}

class UF {
    var parent: [Int]
    init (_ n: Int) {
        parent = Array(0..<n)
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func union(_ x: Int, _ y: Int) {
        let px = find(x)
        let py = find(y)
        if px != py {
            parent[px] = py
        }
    }
}
