// We can rotate digits by 180 degrees to form new digits. When 0, 1, 6, 8, 9 are rotated 180 degrees, they become 0, 1, 9, 8, 6 respectively. When 2, 3, 4, 5 and 7 are rotated 180 degrees, they become invalid.

// A confusing number is a number that when rotated 180 degrees becomes a different number with each digit valid.(Note that the rotated number can be greater than the original number.)

// Given a positive integer N, return the number of confusing numbers between 1 and N inclusive.

 

// Example 1:

// Input: 20
// Output: 6
// Explanation: 
// The confusing numbers are [6,9,10,16,18,19].
// 6 converts to 9.
// 9 converts to 6.
// 10 converts to 01 which is just 1.
// 16 converts to 91.
// 18 converts to 81.
// 19 converts to 61.
// Example 2:

// Input: 100
// Output: 19
// Explanation: 
// The confusing numbers are [6,9,10,16,18,19,60,61,66,68,80,81,86,89,90,91,98,99,100].
 

// Note:

// 1 <= N <= 10^9

// Solution 1: force
// 
// Time complexity: O(n) 

// Solution 2: DFS
// backtracking each digit, with num & rotateNum
// if current num <= N, and rotateNum not equal to current num, add the count
// pending one more digit
// 
// Time complexity: 5^m , m is n digits
// Space complexity: O(1), contant map, key
class Solution {
    // key to control the later for loop
    var key = [0, 1, 6, 8, 9]
    var map = [
        0: 0, 
        1: 1, 
        6: 9, 
        8: 8, 
        9: 6
    ]
    var N = 0
    
    func confusingNumberII(_ N: Int) -> Int {
        var count = 0
        self.N = N
        backtrack(1, 1, 10, &count)
        backtrack(6, 9, 10, &count)
        backtrack(8, 8, 10, &count)
        backtrack(9, 6, 10, &count)
        return count
    }
    
    func backtrack(_ num: Int, _ rotateNum: Int, _ digit: Int, _ count: inout Int) {
        // <= N
        if num <= N, num != rotateNum { 
            count += 1
        }
        for i in key {
            if num*10 + i > N {
                return
            } else {
                // map[i] * digit + rotateNum
                backtrack(num*10+i, map[i]!*digit+rotateNum, digit*10, &count)
            }
        }
    }
}

class Solution {
    var list = [(0, 0), (1, 1), (6, 9), (8, 8), (9, 6)]
    var count = 0
    var N = 0
    
    func confusingNumberII(_ N: Int) -> Int {
        self.N = N
        backtrack(1, 1, 10)
        backtrack(6, 9, 10)
        backtrack(8, 8, 10)
        backtrack(9, 6, 10)
        return count
    }
    
    func backtrack(_ cur: Int, _ rotate: Int, _ digit: Int) {
        if cur > N { return }
        if cur <= N, cur != rotate { count += 1 }
        
        for pair in list {
            backtrack(cur*10 + pair.0, pair.1*digit + rotate, digit*10)   
        }
    }
}
