/*
You are given coordinates, a string that represents the coordinates of a square of the chessboard. Below is a chessboard for your reference.



Return true if the square is white, and false if the square is black.

The coordinate will always represent a valid chessboard square. The coordinate will always have the letter first, and the number second.



Example 1:

Input: coordinates = "a1"
Output: false
Explanation: From the chessboard above, the square with coordinates "a1" is black, so return false.
Example 2:

Input: coordinates = "h3"
Output: true
Explanation: From the chessboard above, the square with coordinates "h3" is white, so return true.
Example 3:

Input: coordinates = "c7"
Output: false


Constraints:

coordinates.length == 2
'a' <= coordinates[0] <= 'h'
'1' <= coordinates[1] <= '8'
*/

/*
Solution 1:
set

Time Compelxity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func squareIsWhite(_ coordinates: String) -> Bool {
        var even: Set<Character> = Set(["a", "c", "e", "g"])
        var odd: Set<Character> = Set(["b", "d", "f", "h"])

        var coordinates = Array(coordinates)
        let num = coordinates[1].wholeNumberValue!
        if even.contains(coordinates[0]) {
            return num % 2 == 0 ? true : false
        } else if odd.contains(coordinates[0]) {
            return num % 2 == 1 ? true : false
        }

        return true
    }
}