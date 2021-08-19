/*
You are given an n x n integer matrix board where the cells are labeled from 1 to n2 in a Boustrophedon style starting from the bottom left of the board (i.e. board[n - 1][0]) and alternating direction each row.

You start on square 1 of the board. In each move, starting from square curr, do the following:

Choose a destination square next with a label in the range [curr + 1, min(curr + 6, n2)].
This choice simulates the result of a standard 6-sided die roll: i.e., there are always at most 6 destinations, regardless of the size of the board.
If next has a snake or ladder, you must move to the destination of that snake or ladder. Otherwise, you move to next.
The game ends when you reach the square n2.
A board square on row r and column c has a snake or ladder if board[r][c] != -1. The destination of that snake or ladder is board[r][c]. Squares 1 and n2 do not have a snake or ladder.

Note that you only take a snake or ladder at most once per move. If the destination to a snake or ladder is the start of another snake or ladder, you do not follow the subsequent snake or ladder.

For example, suppose the board is [[-1,4],[-1,3]], and on the first move, your destination square is 2. You follow the ladder to square 3, but do not follow the subsequent ladder to 4.
Return the least number of moves required to reach the square n2. If it is not possible to reach the square, return -1.



Example 1:


Input: board = [[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,35,-1,-1,13,-1],[-1,-1,-1,-1,-1,-1],[-1,15,-1,-1,-1,-1]]
Output: 4
Explanation:
In the beginning, you start at square 1 (at row 5, column 0).
You decide to move to square 2 and must take the ladder to square 15.
You then decide to move to square 17 and must take the snake to square 13.
You then decide to move to square 14 and must take the ladder to square 35.
You then decide to move to square 36, ending the game.
This is the lowest possible number of moves to reach the last square, so return 4.
Example 2:

Input: board = [[-1,-1],[-1,3]]
Output: 1


Constraints:

n == board.length == board[i].length
2 <= n <= 20
grid[i][j] is either -1 or in the range [1, n2].
The squares labeled 1 and n2 do not have any ladders or snakes.

*/

/*
Solution 1:
BFS

visited to record which cell we already checked its 1...6 dices
queue, record current same step cell list

BFS checking,
- get all of current step cell
- try to check if any cell is == target, if so, return current step
- find next in [cur+1...min(cur+6, n*n)], if board[next] == -1, directly append [nextR, nextC]
- if board[next] != -1, append [desR, desC] of this board destination RC

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func snakesAndLadders(_ board: [[Int]]) -> Int {
        let n = board.count
        let target = n*n

        // bfs
        var visited = Array(
            repeating: Array(repeating: false, count: n),
            count: n
        )

        var queue = [(r: Int, c: Int)]()
        queue.append((n-1, 0))

        var step = 0

        while !queue.isEmpty {
            let size = queue.count

            for i in 0..<size {
                let (r, c) = queue.removeFirst()

                guard !visited[r][c] else { continue }
                visited[r][c] = true

                let num = getNumFrom(r, c, n)
                // print(r, c, num)

                if num == target { return step }

                for next in (num+1)...min(num+6, target) {
                    let (nextR, nextC) = getRCFrom(next, n)
                    if board[nextR][nextC] == -1 {
                        queue.append((nextR, nextC))
                    } else {
                        // check destination
                        let (desR, desC) = getRCFrom(board[nextR][nextC], n)
                        queue.append((desR, desC))
                    }
                }
            }

            step += 1
        }
        return -1
    }

    func getNumFrom(_ r: Int, _ c: Int, _ n: Int) -> Int {
        return (n-1-r) * n + ((n-1-r) % 2 == 0 ? c+1 : n-c)
    }

    func getRCFrom(_ num: Int, _ n: Int) -> (r: Int, c: Int) {
        var r =  (num-1) / n
        var c = (num-1) % n

        if r % 2 == 1 {
            c = n-1-c
        }
        r = n-1-r
        return (r, c)
    }
}