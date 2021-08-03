/*
You are asked to cut off all the trees in a forest for a golf event. The forest is represented as an m x n matrix. In this matrix:

0 means the cell cannot be walked through.
1 represents an empty cell that can be walked through.
A number greater than 1 represents a tree in a cell that can be walked through, and this number is the tree's height.
In one step, you can walk in any of the four directions: north, east, south, and west. If you are standing in a cell with a tree, you can choose whether to cut it off.

You must cut off the trees in order from shortest to tallest. When you cut off a tree, the value at its cell becomes 1 (an empty cell).

Starting from the point (0, 0), return the minimum steps you need to walk to cut off all the trees. If you cannot cut off all the trees, return -1.

You are guaranteed that no two trees have the same height, and there is at least one tree needs to be cut off.



Example 1:


Input: forest = [[1,2,3],[0,0,4],[7,6,5]]
Output: 6
Explanation: Following the path above allows you to cut off the trees from shortest to tallest in 6 steps.
Example 2:


Input: forest = [[1,2,3],[0,0,0],[7,6,5]]
Output: -1
Explanation: The trees in the bottom row cannot be accessed as the middle row is blocked.
Example 3:

Input: forest = [[2,3,4],[0,0,5],[8,7,6]]
Output: 6
Explanation: You can follow the same path as Example 1 to cut off all the trees.
Note that you can cut off the first tree at (0, 0) before making any steps.


Constraints:

m == forest.length
n == forest[i].length
1 <= m, n <= 50
0 <= forest[i][j] <= 109
*/

/*
Solution 1:
sort + bfs

Since we have to cut trees in order of their height, we first put trees (int[] {row, col, height}) into a priority queue and sort by height.
Poll each tree from the queue and use BFS to find out steps needed.
The worst case time complexity could be O(m^2 * n^2) (m = number of rows, n = number of columns) since there are m * n trees and for each BFS worst case time complexity is O(m * n) too.

*/
class Solution {
    func cutOffTree(_ forest: [[Int]]) -> Int {
        let m = forest.count
        let n = forest[0].count

        var sortedTree = [[Int]]()
        for i in 0..<m {
            for j in 0..<n {
                if forest[i][j] > 1 {
                    insert([i, j, forest[i][j]], &sortedTree)
                }
            }
        }
        // print(sortedTree)

        var start = [0, 0]
        var step = 0
        while !sortedTree.isEmpty {
            var tree = sortedTree.removeFirst()
            let val = minStep(forest, start, tree, m, n)
            // print(start, tree, val)
            if val < 0 { return -1 }
            step += val
            start = [tree[0], tree[1]]
        }

        return step
    }

    func insert(_ e: [Int], _ sortedTree: inout [[Int]]) {
        if sortedTree.isEmpty {
            sortedTree.append(e)
            return
        }

        var left = 0
        var right = sortedTree.count-1
        while left < right {
            let mid = left + (right - left)/2
            if sortedTree[mid][2] < e[2] {
                left = mid+1
            } else {
                right = mid
            }
        }
        sortedTree.insert(e, at: sortedTree[left][2] < e[2] ? left+1 : left)
    }

    let dir = [0, 1, 0, -1, 0]
    func minStep(_ forest: [[Int]], _ start: [Int],
                 _ tree: [Int], _ m: Int, _ n: Int) -> Int {
        var step = 0
        var visited = Array(
            repeating: Array(repeating: false, count: n),
            count: m
        )

        var queue = [start]
        visited[start[0]][start[1]] = true
        while !queue.isEmpty {
            let size = queue.count
            for i in 0..<size {
                let cur = queue.removeFirst()
                if cur[0] == tree[0], cur[1] == tree[1] {
                    return step
                }

                for d in 0..<4 {
                    let r = cur[0] + dir[d]
                    let c = cur[1] + dir[d+1]
                    if r >= 0, r < m, c >= 0, c < n,
                    forest[r][c] > 0, !visited[r][c] {
                        visited[r][c] = true
                        queue.append([r, c])
                    }
                }
            }
            step += 1
        }
        return -1
    }
}