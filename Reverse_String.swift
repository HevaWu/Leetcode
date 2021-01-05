/*
Write a function that reverses a string. The input string is given as an array of characters char[].

Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.

You may assume all the characters consist of printable ascii characters.

 

Example 1:

Input: ["h","e","l","l","o"]
Output: ["o","l","l","e","h"]
Example 2:

Input: ["H","a","n","n","a","h"]
Output: ["h","a","n","n","a","H"]

Hint 1:
The entire logic for reversing a string is based on using the opposite directional two-pointer approach!
*/

/*
Solution 3:
use default reverse function
*/
class Solution {
    func reverseString(_ s: inout [Character]) {
        s.reverse()
    }
}

/*
Solution 2: 
use default swapAt function
*/
class Solution {
    func reverseString(_ s: inout [Character]) {
        for i in 0..<s.count/2 {
            s.swapAt(i, s.count-1-i)
        }
    }
}

/*
Solution 1: 
recursive swap start & end character
*/
class Solution {
    func reverseString(_ s: inout [Character]) {
        func _reverse(_ start: Int, _ end: Int) {
            if start >= end { return }
            s.swapAt(start, end)
            _reverse(start+1, end-1)
        }
        _reverse(0, s.count-1)
    }
}