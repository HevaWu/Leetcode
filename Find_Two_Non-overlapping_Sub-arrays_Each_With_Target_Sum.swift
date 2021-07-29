/*
Given an array of integers arr and an integer target.

You have to find two non-overlapping sub-arrays of arr each with a sum equal target. There can be multiple answers so you have to find an answer where the sum of the lengths of the two sub-arrays is minimum.

Return the minimum sum of the lengths of the two required sub-arrays, or return -1 if you cannot find such two sub-arrays.



Example 1:

Input: arr = [3,2,2,4,3], target = 3
Output: 2
Explanation: Only two sub-arrays have sum = 3 ([3] and [3]). The sum of their lengths is 2.
Example 2:

Input: arr = [7,3,4,7], target = 7
Output: 2
Explanation: Although we have three non-overlapping sub-arrays of sum = 7 ([7], [3,4] and [7]), but we will choose the first and third sub-arrays as the sum of their lengths is 2.
Example 3:

Input: arr = [4,3,2,6,2,3,4], target = 6
Output: -1
Explanation: We have only one sub-array of sum = 6.
Example 4:

Input: arr = [5,5,4,4,5], target = 3
Output: -1
Explanation: We cannot find a sub-array of sum = 3.
Example 5:

Input: arr = [3,1,1,1,5,1,2,1], target = 3
Output: 3
Explanation: Note that sub-arrays [1,2] and [2,1] cannot be an answer because they overlap.


Constraints:

1 <= arr.length <= 105
1 <= arr[i] <= 1000
1 <= target <= 108
*/

/*
Solution 3:
optimize Solution 2

make the findedArr first
findedArr[i], min length of sub start from i
-> use 2 pointer to solve, time will be O(n)

go through to make prefix and suffix array
prefix[i], min length subarray end before i
suffix[i], min length subarray start at or after i

minSum = min(minSum, prefix[i] + suffix[i])

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func minSumOfLengths(_ arr: [Int], _ target: Int) -> Int {
        let n = arr.count

        // findedArr[i], min length of sub start from i
        var findedArr = Array(repeating: n, count: n)

        var left = 0
        var right = 0
        var cur = 0
        while right < n {
            cur += arr[right]
            while left < right, cur > target {
                cur -= arr[left]
                left += 1
            }
            if cur == target {
                findedArr[left] = right-left+1
            }
            right += 1
            // print(cur, left, right)
        }
        // print(findedArr)

        // prefix[i], min length subarray end before i
        var prefix = Array(repeating: n, count: n)

        // suffix[i], min length subarray start at or after i
        var suffix = Array(repeating: n, count: n)

        for i in stride(from: n-1, through: 0, by: -1) {
            suffix[i] = min(i < n-1 ? suffix[i+1] : n, findedArr[i])

            // note: start from end, try to update ended part
            let index = i + findedArr[i]
            if index < n {
                prefix[index] = min(prefix[index], findedArr[i])
            }
        }

        // print(prefix, suffix)

        var minSum = 2*n
        for i in 0..<n {
            minSum = min(minSum, prefix[i] + suffix[i])
        }

        // 2 subarray inside array, length will not larger than n
        return minSum >  n ? -1 : minSum
    }
}

/*
Solution 2:
TLE
*/
class Solution {
    func minSumOfLengths(_ arr: [Int], _ target: Int) -> Int {
        let n = arr.count

        // findedArr[i], min length of sub start from i
        var findedArr = Array(repeating: n, count: n)

        // prefix[i], min length subarray end before i
        var prefix = Array(repeating: n, count: n)

        // suffix[i], min length subarray start at or after i
        var suffix = Array(repeating: n, count: n)
        for i in 0..<n {
            var cur = 0
            for j in i..<n {
                cur += arr[j]
                if cur == target {
                    findedArr[i] = (j-i+1)

                    break
                } else if cur > target {
                    break
                }
            }
        }

        // print(findedArr)

        for i in stride(from: n-1, through: 0, by: -1) {
            suffix[i] = min(i < n-1 ? suffix[i+1] : n, findedArr[i])

            // note: start from end, try to update ended part
            let index = i + findedArr[i]
            if index < n {
                prefix[index] = min(prefix[index], findedArr[i])
            }
        }

        // print(prefix, suffix)

        var minSum = 2*n
        for i in 0..<n {
            minSum = min(minSum, prefix[i] + suffix[i])
        }

        // 2 subarray inside array, length will not larger than n
        return minSum >  n ? -1 : minSum
    }
}

/*
TLE
*/
class Solution {
    func minSumOfLengths(_ arr: [Int], _ target: Int) -> Int {
        let n = arr.count

        // prefix[i], min length subarray end before i
        var prefix = Array(repeating: n, count: n)

        // suffix[i], min length subarray start at or after i
        var suffix = Array(repeating: n, count: n)
        for i in 0..<n {
            var cur = 0
            for j in i..<n {
                cur += arr[j]
                if cur == target {
                    let len = j-i+1

                    // update prefix, suffix array
                    // print(len, prefix, i)

                    for k in j..<n {
                        prefix[k] = min(prefix[k], len)
                    }

                    for k in 0..<i {
                        suffix[k] = min(suffix[k], len)
                    }

                    // print(prefix, suffix, i, j)

                    break
                } else if cur > target {
                    break
                }
            }
        }

        // print(prefix, suffix)

        var minSum = 2*n
        for i in 0..<n {
            minSum = min(minSum, prefix[i] + suffix[i])
        }

        // 2 subarray inside array, length will not larger than n
        return minSum >  n ? -1 : minSum
    }
}