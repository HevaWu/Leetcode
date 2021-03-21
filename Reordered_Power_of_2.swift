/*
Starting with a positive integer N, we reorder the digits in any order (including the original order) such that the leading digit is not zero.

Return true if and only if we can do this in a way such that the resulting number is a power of 2.

 

Example 1:

Input: 1
Output: true
Example 2:

Input: 10
Output: false
Example 3:

Input: 16
Output: true
Example 4:

Input: 24
Output: false
Example 5:

Input: 46
Output: true
 

Note:

1 <= N <= 10^9
*/

/*
Solution 2:
check digit count

Since NN could only be a power of 2 with 9 digits or less (namely, 2^0, 2^1, ..., 2^29), we can just check whether N has the same digits as any of these possibilities.

Time Complexity: O(logN * logN)
- logN different candidate of Power of 2, and each comparison has O(logN) time complexity
Space Complexity: O(logN)
*/
class Solution {
    func reorderedPowerOf2(_ N: Int) -> Bool {
        var arr = checkDigitsOf(N)
        for i in 0..<31 {
            if arr == checkDigitsOf(1 << i) {
                return true
            }
        }
        return false
    }
    
    // return counts of digits of N
    // 11222334, return [0, 2,3,2,1,0,0,0,0,0]
    func checkDigitsOf(_ N: Int) -> [Int] {
        var arr = Array(repeating: 0, count: 10)
        var N = N
        while N > 0 {
            arr[N%10] += 1
            N /= 10
        }
        return arr
    }
}

/*
Solution 1:
permutation

generate arr permutation, and check if there is one permutation is power of 2

Time Complexity: O(logN! * logN)
- logN is number of digits in the binary representation of N 
- logN! is number of permutaions of digits of N

Space Complexity: O(logN)
*/
class Solution {
    func reorderedPowerOf2(_ N: Int) -> Bool {
        var N = N
        var arr = [Int]()
        while N != 0 {
            arr.insert(N%10, at: 0)
            N /= 10
        }
        return permutation(&arr, arr.count, 0)
    }
    
    func permutation(_ arr: inout [Int], _ n: Int, _ start: Int) -> Bool {
        if start == n { 
            return isPowerOfTwo(arr) 
        }
        for i in start..<n {
            arr.swapAt(start, i)
            if permutation(&arr, n, start+1) {
                return true
            }
            arr.swapAt(start, i)
        }
        return false
    }
    
    func isPowerOfTwo(_ arr: [Int]) -> Bool {
        if arr[0] == 0 { return false }
        var N = 0
        for x in arr {
            N = 10*N + x
        }
        
        while N > 0, N & 1 == 0 {
            N >>= 1
        }
        
        return N == 1
    }
}