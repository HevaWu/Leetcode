/*
Given an array of integers arr, find the sum of min(b), where b ranges over every (contiguous) subarray of arr. Since the answer may be large, return the answer modulo 109 + 7.



Example 1:

Input: arr = [3,1,2,4]
Output: 17
Explanation:
Subarrays are [3], [1], [2], [4], [3,1], [1,2], [2,4], [3,1,2], [1,2,4], [3,1,2,4].
Minimums are 3, 1, 2, 4, 1, 1, 2, 1, 1, 1.
Sum is 17.
Example 2:

Input: arr = [11,81,94,43,3]
Output: 444


Constraints:

1 <= arr.length <= 3 * 104
1 <= arr[i] <= 3 * 104

*/

/*
Solution 2:
PLE: distance to previous less element
NLE: distance to next less element

How much the element 3 contributes to the final answer?
It is 3*(4*3).
What is the final answer?
Denote by left[i] the distance between element A[i] and its PLE.
Denote by right[i] the distance between element A[i] and its NLE.

The final answer is,
sum(A[i]*left[i]*right[i] )

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func sumSubarrayMins(_ arr: [Int]) -> Int {
        let n = arr.count
        if n == 1 { return arr[0] }

        let mod = Int(1e9 + 7)

        // ple[i] means index of previous less than arr[i] element
        //nple[i] means index of next less than arr[i] element
        var ple = Array(repeating: 0, count: n)
        var nle = Array(repeating: n, count: n)

        var stack_p = [Int]()
        var stack_n = [Int]()
        for i in 0..<n {
            while !stack_p.isEmpty, arr[stack_p.last!] > arr[i] {
                stack_p.removeLast()
            }
            ple[i] = stack_p.isEmpty ? -1 : stack_p.last!
            stack_p.append(i)

            while !stack_n.isEmpty,  arr[stack_n.last!] > arr[i] {
                let index = stack_n.removeLast()
                nle[index] = i
            }
            stack_n.append(i)
        }

        // print(ple, nle)
        var sum = 0
        for i in 0..<n {
            sum = (sum + arr[i] * (i - ple[i]) * (nle[i] - i)) % mod
        }
        return sum
    }
}

/*
Solution 1:
TLE
brute force

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func sumSubarrayMins(_ arr: [Int]) -> Int {
        let n = arr.count
        let mod = Int(1e9 + 7)

        var sum = 0
        for i in 0..<n {
            var minVal = arr[i]
            for j in i..<n {
                minVal = min(minVal, arr[j])
                sum = (sum + minVal) % mod
            }
        }
        return sum
    }
}