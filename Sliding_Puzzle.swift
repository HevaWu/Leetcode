/*
On an 2 x 3 board, there are five tiles labeled from 1 to 5, and an empty square represented by 0. A move consists of choosing 0 and a 4-directionally adjacent number and swapping it.

The state of the board is solved if and only if the board is [[1,2,3],[4,5,0]].

Given the puzzle board board, return the least number of moves required so that the state of the board is solved. If it is impossible for the state of the board to be solved, return -1.



Example 1:


Input: board = [[1,2,3],[4,0,5]]
Output: 1
Explanation: Swap the 0 and the 5 in one move.
Example 2:


Input: board = [[1,2,3],[5,4,0]]
Output: -1
Explanation: No number of moves will make the board solved.
Example 3:


Input: board = [[4,1,2],[5,0,3]]
Output: 5
Explanation: 5 is the smallest number of moves that solves the board.
An example path:
After move 0: [[4,1,2],[5,0,3]]
After move 1: [[4,1,2],[0,5,3]]
After move 2: [[0,1,2],[4,5,3]]
After move 3: [[1,0,2],[4,5,3]]
After move 4: [[1,2,0],[4,5,3]]
After move 5: [[1,2,3],[4,5,0]]
Example 4:


Input: board = [[3,2,4],[1,5,0]]
Output: 14


Constraints:

board.length == 2
board[i].length == 3
0 <= board[i][j] <= 5
Each value board[i][j] is unique.
*/

/*
Solution 1:
BFS

0 1 2
3 4 5
when 0 at index 0, index connect is [1,3]
when 0 at index 1, index connect is [0,2,4]
when 0 at index 2, index connect is [1,5]
when 0 at index 3, index connect is [0,4]
when 0 at index 4, index connect is [1,3,5]
when 0 at index 5, index connect is [2,4]

Consider each state in the board as a graph node, we just need to find out the min distance between start node and final target node "123450". Since it's a single point to single point questions, Dijkstra is not needed here. We can simply use BFS, and also count the level we passed. Every time we swap 0 position in the String to find the next state. Use a hashTable to store the visited states.

Time Complexity: O(6^6)
Space Complexity: O(6^6)
*/
class Solution {
    func slidingPuzzle(_ board: [[Int]]) -> Int {
        var start = String()
        for b in board {
            for i in b {
                start.append(String(i))
            }
        }

        var target = "123450"

        // define direction
        var dir = [[1,3], [0,2,4], [1,5], [0,4], [1,3,5], [2,4]]

        var queue = [String]()
        queue.append(start)

        var visited = Set<String>()
        visited.insert(start)

        var move = 0
        while !queue.isEmpty {
            let size = queue.count
            for i in 0..<size {
                let str = queue.removeFirst()
                if str == target {
                    return move
                }

                let cur = Array(str)

                guard let i0 = cur.firstIndex(of: "0") else { continue }
                for d in dir[i0] {
                    var next = cur
                    next.swapAt(d, i0)

                    let str = String(next)
                    if !visited.contains(str) {
                        visited.insert(str)
                        queue.append(str)
                    }
                }
            }
            // print(queue)
            move += 1
        }

        return -1
    }
}