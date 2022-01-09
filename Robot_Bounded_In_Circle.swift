/*
On an infinite plane, a robot initially stands at (0, 0) and faces north. The robot can receive one of three instructions:

"G": go straight 1 unit;
"L": turn 90 degrees to the left;
"R": turn 90 degrees to the right.
The robot performs the instructions given in order, and repeats them forever.

Return true if and only if there exists a circle in the plane such that the robot never leaves the circle.



Example 1:

Input: instructions = "GGLLGG"
Output: true
Explanation: The robot moves from (0,0) to (0,2), turns 180 degrees, and then returns to (0,0).
When repeating these instructions, the robot remains in the circle of radius 2 centered at the origin.
Example 2:

Input: instructions = "GG"
Output: false
Explanation: The robot moves north indefinitely.
Example 3:

Input: instructions = "GL"
Output: true
Explanation: The robot moves from (0, 0) -> (0, 1) -> (-1, 1) -> (-1, 0) -> (0, 0) -> ...


Constraints:

1 <= instructions.length <= 100
instructions[i] is 'G', 'L' or, 'R'.
*/

/*
Solution 1:
Calculate final vector of robot and final direction after robot follow all instructions once
robot will stay in circle if
- change direction
- move 0 (0,0)

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func isRobotBounded(_ instructions: String) -> Bool {
        var pos: (row: Int, col: Int) = (0, 0)

        // current direction is [-1, 0], which is north
        var d = 0
        var dir: [[Int]] = [[-1, 0], [0, -1], [1, 0], [0, 1]]
        for instruction in instructions {
            if instruction == Character("G") {
                pos.row += dir[d][0]
                pos.col += dir[d][1]
            } else if instruction == Character("L") {
                d = (d + 1) % 4
            } else if instruction == Character("R") {
                d = (d - 1 + 4) % 4
            }
        }

        return d != 0 || pos == (0, 0)
    }
}
