/*
In a garden represented as an infinite 2D grid, there is an apple tree planted at every integer coordinate. The apple tree planted at an integer coordinate (i, j) has |i| + |j| apples growing on it.

You will buy an axis-aligned square plot of land that is centered at (0, 0).

Given an integer neededApples, return the minimum perimeter of a plot such that at least neededApples apples are inside or on the perimeter of that plot.

The value of |x| is defined as:

x if x >= 0
-x if x < 0


Example 1:


Input: neededApples = 1
Output: 8
Explanation: A square plot of side length 1 does not contain any apples.
However, a square plot of side length 2 has 12 apples inside (as depicted in the image above).
The perimeter is 2 * 4 = 8.
Example 2:

Input: neededApples = 13
Output: 16
Example 3:

Input: neededApples = 1000000000
Output: 5040


Constraints:

1 <= neededApples <= 1015

*/

/*
Solution 2:
math
sum formular

2*(a1+an)/2
*/
class Solution {
    func minimumPerimeter(_ neededApples: Int) -> Int {
        var f = [Int: Int]()
        f[0] = 0
        f[1] = 2*4 + 1*4 + f[0, default: 0]

        var i = 1
        while f[i, default: 0] < neededApples {
            // enlarge the square
            let next = i + 1
            // 8 * (next-1) * (1+next + next-1+next)/2
            var val = next*4 + next * 2 * 4 + 4*3*next*(next-1)
            // for j in 1..<next {
            //     val += (j+next)*8
            // }
            f[next] = val + f[i, default: 0]
            i = next
            // print(f[i, default: 0], i, val)
        }
        return i * 2 * 4
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func minimumPerimeter(_ neededApples: Int) -> Int {
        var f = [Int: Int]()
        f[0] = 0
        f[1] = 2*4 + 1*4 + f[0, default: 0]

        var i = 1
        while f[i, default: 0] < neededApples {
            // enlarge the square
            let next = i + 1
            var val = next*4 + next * 2 * 4
            for j in 1..<next {
                val += (j+next)*8
            }
            f[next] = val + f[i, default: 0]
            i = next
            // print(f[i, default: 0], i, val)
        }
        return i * 2 * 4
    }
}