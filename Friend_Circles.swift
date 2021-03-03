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
bfs

bfs find all connected cities, then mark them as visited

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func findCircleNum(_ isConnected: [[Int]]) -> Int {
        let n = isConnected.count
        
        var visited = Array(repeating: false, count: n)
        
        var provinces = 0
        for i in 0..<n {
            // start from i, include itself counting
            for j in i..<n {
                if isConnected[i][j] == 1, !visited[i] {
                    provinces += 1
                    visited[i] = true
                    check(i, j, isConnected, &visited, n)
                }
            }
        }
        return provinces
    }
    
    func check(_ i: Int, _ j: Int, 
               _ isConnected: [[Int]], _ visited: inout [Bool], 
               _ n: Int) {
        // bfs find mark all connected cities as visited
        var queue: [Int] = [i]
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            
            // need to check all cities here
            // there might be case that, 1 -> 3 -> 2, but 1->2 is 0
            for city in 0..<n {
                if isConnected[cur][city] == 1, !visited[city] {
                    visited[city] = true
                    queue.append(city)
                }
            }
        }
    }
}