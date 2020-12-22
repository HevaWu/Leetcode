/*
Given a positive integer n, find the least number of perfect square numbers (for example, 1, 4, 9, 16, ...) which sum to n.

Example 1:

Input: n = 12
Output: 3 
Explanation: 12 = 4 + 4 + 4.
Example 2:

Input: n = 13
Output: 2
Explanation: 13 = 4 + 9.
*/

/*
Solution 3:
lagrange's four square theorem

there are only 4 possible results: 1 2 3 4
return 1 when n isSquare
return 4: n is 4^k*(8*m+7)
    1. check n % 4 == 0
    2. check n % 8 == 7   return 4
return 2: n = i*i + j*j
    isSquare(n-i*i)  --- return true, is 2
    for reduce checking, keep n-i*i >0 
    for(int i = 0; i <= (int)(sqrt(n)); ++i)
    eg: 50, did not need to check until 50, only need to check until 7( sqrt(50) )
else return 3
*/
class Solution {
    func numSquares(_ n: Int) -> Int {
        if n <= 0 { return 0 }
        var n = n
        
        // check if num is square nnum
        let isSquare: (Int) -> Bool = { num in
            let sqrtRoot = Int(Double(num).squareRoot())
            return sqrtRoot*sqrtRoot == num
        }
        
        if isSquare(n) { return 1 }
        
        while n % 4 == 0 {
            n >>= 2
        }
        
        if n % 8 == 7 {
            return 4
        }
        
        let sqrtRoot = Int(Double(n).squareRoot())
        for i in 1...sqrtRoot {
            if isSquare(n-i*i) {
                return 2
            }
        }
        
        return 3
    }
}

/*
Solution 2: 
DP

for j in 1...sqrtRoot_i
dp[i] = min(num, dp[i-j*j]+1)
*/
class Solution {
    func numSquares(_ n: Int) -> Int {
        if n <= 0 { return 0 }
        var dp = Array(repeating: 0, count: n+1)
        dp[0] = 0
        for i in 1...n {
            var num = Int.max
            var sqrtRoot = Int(Double(i).squareRoot())
            for j in 1...sqrtRoot {
                num = min(num, dp[i-j*j]+1)
            }
            dp[i] = num
        }
        return dp[n]
    }
}

/*
Solution 1:
BFS
*/
class Solution {
    func numSquares(_ n: Int) -> Int {
        if n <= 0 { return 0 }
        
        var squareNum = [Int]()
        
        // store square count
        // square[i-1] = 1 when i is visited
        var square = Array(repeating: 0, count: n)
        
        let root = Int(Double(n).squareRoot())
        for i in 1...root {
            squareNum.append(i*i)
            square[i*i-1] = 1
        }
        
        if squareNum.last == n {
            return 1
        }
        
        var queue = squareNum
        var num = 1
        while !queue.isEmpty {
            num += 1
            
            var size = queue.count
            for i in 0..<size {
                let temp = queue.removeFirst()
                for j in squareNum {
                    if temp + j == n { return num }
                    if temp + j < n, square[temp+j-1]==0 {
                        // if square[temp+j-1]>0, this means this is not the first time we visit the code, skip the node(temp+j)
                        square[temp+j-1] = num
                        queue.append(temp+j)
                    } else if temp + j > n {
                        // skip node greater than n
                        break
                    }
                }
            }
        }
        return 0
    }
}