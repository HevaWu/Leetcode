/*
A game is played by a cat and a mouse named Cat and Mouse.

The environment is represented by a grid of size rows x cols, where each element is a wall, floor, player (Cat, Mouse), or food.

Players are represented by the characters 'C'(Cat),'M'(Mouse).
Floors are represented by the character '.' and can be walked on.
Walls are represented by the character '#' and cannot be walked on.
Food is represented by the character 'F' and can be walked on.
There is only one of each character 'C', 'M', and 'F' in grid.
Mouse and Cat play according to the following rules:

Mouse moves first, then they take turns to move.
During each turn, Cat and Mouse can jump in one of the four directions (left, right, up, down). They cannot jump over the wall nor outside of the grid.
catJump, mouseJump are the maximum lengths Cat and Mouse can jump at a time, respectively. Cat and Mouse can jump less than the maximum length.
Staying in the same position is allowed.
Mouse can jump over Cat.
The game can end in 4 ways:

If Cat occupies the same position as Mouse, Cat wins.
If Cat reaches the food first, Cat wins.
If Mouse reaches the food first, Mouse wins.
If Mouse cannot get to the food within 1000 turns, Cat wins.
Given a rows x cols matrix grid and two integers catJump and mouseJump, return true if Mouse can win the game if both Cat and Mouse play optimally, otherwise return false.



Example 1:



Input: grid = ["####F","#C...","M...."], catJump = 1, mouseJump = 2
Output: true
Explanation: Cat cannot catch Mouse on its turn nor can it get the food before Mouse.
Example 2:



Input: grid = ["M.C...F"], catJump = 1, mouseJump = 4
Output: true
Example 3:

Input: grid = ["M.C...F"], catJump = 1, mouseJump = 3
Output: false
Example 4:

Input: grid = ["C...#","...#F","....#","M...."], catJump = 2, mouseJump = 5
Output: false
Example 5:

Input: grid = [".M...","..#..","#..#.","C#.#.","...#F"], catJump = 3, mouseJump = 1
Output: true


Constraints:

rows == grid.length
cols = grid[i].length
1 <= rows, cols <= 8
grid[i][j] consist only of characters 'C', 'M', 'F', '.', and '#'.
There is only one of each character 'C', 'M', and 'F' in grid.
1 <= catJump, mouseJump <= 8
*/

/*
Solution 1:
TLE

backtrack all of possiblities

Time Complexity: O((m * n) ^ 3 * (m + n))
- m+n because iterate all jumps
Space Complexity: O((mn) ^ 3)
*/
class Solution {
    func canMouseWin(_ grid: [String], _ catJump: Int, _ mouseJump: Int) -> Bool {
        let m = grid.count
        let n = grid[0].count

        // [[Character]]
        var grid = grid.map { Array($0) }
        var availableSteps = 0

        // get pos_m, pos_c
        var pos_m = [0, 0]
        var pos_c = [0, 0]

        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == "C" {
                    pos_c = [i, j]
                } else if grid[i][j] == "M" {
                    pos_m = [i, j]
                }

                if grid[i][j] != "#" {
                    availableSteps += 1
                }
            }
        }

        // maxTurn can be (m * n * 2)
        return check(pos_m, pos_c, 0, m, n, availableSteps * 2, grid, catJump, mouseJump)
    }

    var cache = [[Int]: [[Int]: [Int: Bool]]]()
    let dir = [0, 1, 0, -1, 0]
    func check(_ pos_m: [Int], _ pos_c: [Int],
               _ curTurn: Int, _ m: Int, _ n: Int,
               _ maxTurn: Int, _ grid: [[Character]],
               _ catJump: Int, _ mouseJump: Int) -> Bool {
        if curTurn == maxTurn * 2 {
            return false
        }

        if let val = cache[pos_m]?[pos_c]?[curTurn] {
            return val
        }

        var val = false
        if curTurn % 2 == 0 {
            // current is mouse turn
            // try to always close to food

            for d in 0..<4 {
                for jump in 0...mouseJump {
                    let r = pos_m[0] + dir[d] * jump
                    let c = pos_m[1] + dir[d+1] * jump

                    if r >= 0, r < m, c >= 0, c < n, grid[r][c] != "#" {
                        // valid position
                        if grid[r][c] == "F" || check([r, c], pos_c, curTurn+1, m, n, maxTurn, grid, catJump, mouseJump) {
                            cache[pos_m, default: [[Int]: [Int: Bool]]()][pos_c, default: [Int: Bool]()][curTurn] = true
                            return true
                        }
                    } else {
                        // step extending jump
                        break
                    }
                }
            }
            cache[pos_m, default: [[Int]: [Int: Bool]]()][pos_c, default: [Int: Bool]()][curTurn] = false
            return false

        } else {
            // current is cat turn

            val = true
            for d in 0..<4 {
                for jump in 0...catJump {
                    let r = pos_c[0] + dir[d] * jump
                    let c = pos_c[1] + dir[d+1] * jump

                    if r >= 0, r < m, c >= 0, c < n, grid[r][c] != "#" {
                        // valid position
                        if grid[r][c] == "F" || [r, c] == pos_m || !check(pos_m, [r, c], curTurn+1, m, n, maxTurn, grid, catJump, mouseJump) {
                            cache[pos_m, default: [[Int]: [Int: Bool]]()][pos_c, default: [Int: Bool]()][curTurn] = false
                            return false
                        }
                    } else {
                        // step extending jump
                        break
                    }
                }
            }

            cache[pos_m, default: [[Int]: [Int: Bool]]()][pos_c, default: [Int: Bool]()][curTurn] = true
            return true
        }
    }
}