/*
Given the radius and x-y positions of the center of a circle, write a function randPoint which generates a uniform random point in the circle.

Note:

input and output values are in floating-point.
radius and x-y position of the center of the circle is passed into the class constructor.
a point on the circumference of the circle is considered to be in the circle.
randPoint returns a size 2 array containing x-position and y-position of the random point, in that order.
Example 1:

Input: 
["Solution","randPoint","randPoint","randPoint"]
[[1,0,0],[],[],[]]
Output: [null,[-0.72939,-0.65505],[-0.78502,-0.28626],[-0.83119,-0.19803]]
Example 2:

Input: 
["Solution","randPoint","randPoint","randPoint"]
[[10,5,-7.5],[],[],[]]
Output: [null,[11.52438,-8.33273],[2.46992,-16.21705],[11.13430,-12.42337]]
Explanation of Input Syntax:

The input is two lists: the subroutines called and their arguments. Solution's constructor has three arguments, the radius, x-position of the center, and y-position of the center of the circle. randPoint has no arguments. Arguments are always wrapped with a list, even if there aren't any.
*/

/*
Solution 1:
math

use sqrt() to get graph with correct random pointers
https://leetcode.com/problems/generate-random-point-in-a-circle/discuss/155650/Explanation-with-Graphs-why-using-Math.sqrt()

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    var r: Double
    var origin: (x: Double, y: Double)

    init(_ radius: Double, _ x_center: Double, _ y_center: Double) {
        self.r = radius
        self.origin = (x: x_center, y: y_center)
    }
    
    func randPoint() -> [Double] {
        let len = r*((Double.random(in: 0...1)).squareRoot())
        let degree = Double.random(in: 0...1) * 2 * Double.pi
        let x = origin.x + len*cos(degree)
        let y = origin.y + len*sin(degree)
        return [x, y]
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(radius, x_center, y_center)
 * let ret_1: [Double] = obj.randPoint()
 */