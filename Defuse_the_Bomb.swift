/*
You have a bomb to defuse, and your time is running out! Your informer will provide you with a circular array code of length of n and a key k.

To decrypt the code, you must replace every number. All the numbers are replaced simultaneously.

If k > 0, replace the ith number with the sum of the next k numbers.
If k < 0, replace the ith number with the sum of the previous k numbers.
If k == 0, replace the ith number with 0.
As code is circular, the next element of code[n-1] is code[0], and the previous element of code[0] is code[n-1].

Given the circular array code and an integer key k, return the decrypted code to defuse the bomb!



Example 1:

Input: code = [5,7,1,4], k = 3
Output: [12,10,16,13]
Explanation: Each number is replaced by the sum of the next 3 numbers. The decrypted code is [7+1+4, 1+4+5, 4+5+7, 5+7+1]. Notice that the numbers wrap around.
Example 2:

Input: code = [1,2,3,4], k = 0
Output: [0,0,0,0]
Explanation: When k is zero, the numbers are replaced by 0.
Example 3:

Input: code = [2,4,9,3], k = -2
Output: [12,5,6,13]
Explanation: The decrypted code is [3+9, 2+3, 4+2, 9+4]. Notice that the numbers wrap around again. If k is negative, the sum is of the previous numbers.


Constraints:

n == code.length
1 <= n <= 100
1 <= code[i] <= 100
-(n - 1) <= k <= n - 1
*/

/*
Solution 1:
Record sum for each subarray, then update ith number accordingly

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func decrypt(_ code: [Int], _ k: Int) -> [Int] {
        let n = code.count
        if n == 0 { return [] }
        if k == 0 { return Array(repeating: 0, count: n) }

        // sum[i] is sum for code[0..<i]
        var sum = Array(repeating: 0, count: n+1)
        sum[0] = 0
        for i in 0..<n {
            sum[i+1] = sum[i] + code[i]
        }
        // print(sum)

        var updated = code
        for i in 0..<n {
            let index = i+k
            if k > 0 {
                // update ith number with sum of next k numbers
                // i+1 ... i+k
                if index < n {
                    updated[i] = sum[index+1] - sum[i+1]
                } else {
                    updated[i] = sum[n] - sum[i+1] + sum[index - n + 1]
                }
            } else {
                // update ith number with sum of previous k numbers
                if index >= 0 {
                    updated[i] = sum[i] - sum[index]
                } else {
                    updated[i] = sum[i] + (sum[n] - sum[n + index])
                }
            }
        }
        return updated
    }
}
