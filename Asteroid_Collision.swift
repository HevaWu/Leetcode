/*
We are given an array asteroids of integers representing asteroids in a row.

For each asteroid, the absolute value represents its size, and the sign represents its direction (positive meaning right, negative meaning left). Each asteroid moves at the same speed.

Find out the state of the asteroids after all collisions. If two asteroids meet, the smaller one will explode. If both are the same size, both will explode. Two asteroids moving in the same direction will never meet.



Example 1:

Input: asteroids = [5,10,-5]
Output: [5,10]
Explanation: The 10 and -5 collide resulting in 10. The 5 and 10 never collide.
Example 2:

Input: asteroids = [8,-8]
Output: []
Explanation: The 8 and -8 collide exploding each other.
Example 3:

Input: asteroids = [10,2,-5]
Output: [10]
Explanation: The 2 and -5 collide resulting in -5. The 10 and -5 collide resulting in 10.


Constraints:

2 <= asteroids.length <= 104
-1000 <= asteroids[i] <= 1000
asteroids[i] != 0
*/


/*
Solution 1:
stack to record current in stack asteroids

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func asteroidCollision(_ asteroids: [Int]) -> [Int] {
        var stack = [Int]()
        for a in asteroids {
            if a < 0 {
                var aIsExplode = false
                while !stack.isEmpty {
                    if stack.last! < 0 {
                        // same direction asteroid, no explode happens
                        break
                    }
                    // compare last right asteroid
                    let cur = stack.removeLast()
                    if abs(cur) > abs(a) {
                        // a will explode, cur keep in stack
                        stack.append(cur)
                        aIsExplode = true
                        break
                    }
                    if abs(cur) == abs(a) {
                        // both explode
                        aIsExplode = true
                        break
                    }
                    // abs(cur) < abs(a)
                    // cur will explode, a will try to check next stack elements
                }
                if !aIsExplode {
                    stack.append(a)
                }
            } else {
                // a >= 0, add it directly since it is right forward
                stack.append(a)
            }
        }
        return stack
    }
}
