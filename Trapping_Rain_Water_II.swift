/*
Given an m x n integer matrix heightMap representing the height of each unit cell in a 2D elevation map, return the volume of water it can trap after raining.



Example 1:


Input: heightMap = [[1,4,3,1,3,2],[3,2,1,3,2,4],[2,3,3,2,3,1]]
Output: 4
Explanation: After the rain, water is trapped between the blocks.
We have two small pounds 1 and 3 units trapped.
The total volume of water trapped is 4.
Example 2:


Input: heightMap = [[3,3,3,3,3],[3,2,2,2,3],[3,2,1,2,3],[3,2,2,2,3],[3,3,3,3,3]]
Output: 10


Constraints:

m == heightMap.length
n == heightMap[i].length
1 <= m, n <= 200
0 <= heightMap[i][j] <= 2 * 104

*/

/*
Solution 1:
priority queue

everytime pick smalles cell, then check its surrounding cell,
if its neighbors is less it, we can trap water,
if not, do not trap it,
then add neighbors cell into queue

Time Complexity: O(mn*log(mn))
Space Complexity: O(mn)
*/
class Solution {
    func trapRainWater(_ heightMap: [[Int]]) -> Int {
        let m = heightMap.count
        let n = heightMap[0].count

        // sort by cell.height
        var queue = [Cell]()
        var visited = Array(
            repeating: Array(repeating: false, count: n),
            count: m
        )

        for i in 0..<m {
            visited[i][0] = true
            visited[i][n-1] = true
            insert(Cell(i, 0, heightMap[i][0]), &queue)
            insert(Cell(i, n-1, heightMap[i][n-1]), &queue)
        }

        for j in 0..<n {
            visited[0][j] = true
            visited[m-1][j] = true
            insert(Cell(0, j, heightMap[0][j]), &queue)
            insert(Cell(m-1, j, heightMap[m-1][j]), &queue)
        }

        let dir = [0, 1, 0, -1, 0]
        var res = 0

        // from the borders, pick the shortest cell visited and check its neighbors:
        // if the neighbor is shorter, collect the water it can trap and update its height as its height plus the water trapped
       // add all its neighbors to the queue.
        while !queue.isEmpty {
            let cell = queue.removeFirst()

            for d in 0..<4 {
                let r = cell.r + dir[d]
                let c = cell.c + dir[d+1]
                if r >= 0, r < m, c >= 0, c < n, !visited[r][c] {
                    visited[r][c] = true
                    res += max(0, cell.height - heightMap[r][c])
                    insert(Cell(r, c, max(heightMap[r][c], cell.height)), &queue)
                }
            }
        }
        return res
    }

    func insert(_ cell: Cell, _ queue: inout [Cell]) {
        if queue.isEmpty {
            queue.append(cell)
            return
        }

        var left = 0
        var right = queue.count-1
        while left < right {
            let mid = left + (right-left)/2
            if queue[mid].height < cell.height {
                left = mid + 1
            } else {
                right = mid
            }
        }
        queue.insert(cell, at: queue[left].height < cell.height ? left+1 : left)
    }
}

struct Cell {
    let r: Int
    let c: Int
    let height: Int

    init(_ r: Int, _ c: Int, _ height: Int) {
        self.r = r
        self.c = c
        self.height = height
    }
}