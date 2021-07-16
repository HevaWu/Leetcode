/*
Given an integer array nums, return the number of triplets chosen from the array that can make triangles if we take them as side lengths of a triangle.



Example 1:

Input: nums = [2,2,3,4]
Output: 3
Explanation: Valid combinations are:
2,3,4 (using the first 2)
2,3,4 (using the second 2)
2,2,3
Example 2:

Input: nums = [4,2,3,4]
Output: 4


Constraints:

1 <= nums.length <= 1000
0 <= nums[i] <= 1000
*/

/*
Solution 2:
linear scan

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func triangleNumber(_ nums: [Int]) -> Int {

        let n = nums.count
        guard n >= 3 else { return 0}

        var count = 0
        var nums = nums.sorted()

        for i in 0..<(n-2) {
            var k = i+2
            for j in (i+1)..<(n-1) where nums[i] != 0 {
                while k < n, nums[i] + nums[j] > nums[k] {
                    k += 1
                }
                count += (k-j-1)
            }
        }

        return count
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func triangleNumber(_ nums: [Int]) -> Int {
        var numMap = [Int: Int]()
        for num in nums {
            numMap[num, default: 0] += 1
        }

        var keys = numMap.keys.sorted()
        let n = keys.count

        var count = 0
        for i in 0..<n {
            for j in i..<n {
                if i == j, numMap[keys[i]]! < 2 { continue }
                for k in j..<n {
                    if i == k, numMap[keys[i]]! < 3 { continue }
                    if j == k, numMap[keys[j]]! < 2 { continue }

                    // print(keys[i], keys[j], keys[k])
                    if keys[i] + keys[j] > keys[k] {
                        // find i,j,k pair
                        if i == k, let val = numMap[keys[i]] {
                            // C_val^3
                            count += ((val * (val-1) * (val-2)) / 6)
                        } else if j == k, let val_i = numMap[keys[i]], let val_j = numMap[keys[j]] {
                            count += (val_i * ((val_j * (val_j-1)/2)))
                        } else if i == j, let val_i = numMap[keys[i]], let val_k = numMap[keys[k]] {
                            count += (val_k * ((val_i * (val_i-1)/2)))
                        } else if let val_i = numMap[keys[i]],
                        let val_j = numMap[keys[j]],
                        let val_k = numMap[keys[k]] {
                            count += (val_i * val_j * val_k)
                        }
                    } else {
                        // later k will aslo not match requirement
                        continue
                    }
                }
            }
        }

        return count
    }
}