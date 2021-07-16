/*
Given an array nums of n integers, return an array of all the unique quadruplets [nums[a], nums[b], nums[c], nums[d]] such that:

0 <= a, b, c, d < n
a, b, c, and d are distinct.
nums[a] + nums[b] + nums[c] + nums[d] == target
You may return the answer in any order.



Example 1:

Input: nums = [1,0,-1,0,-2,2], target = 0
Output: [[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
Example 2:

Input: nums = [2,2,2,2,2], target = 8
Output: [[2,2,2,2]]


Constraints:

1 <= nums.length <= 200
-109 <= nums[i] <= 109
-109 <= target <= 109
*/

/*
Solution 3:
two pointer 2sum + kSum

Time Complexity: O(n^3)
Space Complexity: O(n)
*/
class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var nums = nums.sorted()
        return kSum(nums, target, 0, 4)
    }

    func kSum(_ nums: [Int], _ target: Int, _ start: Int, _ k: Int) -> [[Int]] {
        var res = [[Int]]()
        let n = nums.count

        if start == n
        || nums[start] * k > target
        || target > nums[n-1] * k {
            return res
        }

        if k == 2 {
            return twoSum(nums, target, start)
        }

        for i in start..<n {
            if i == start || nums[i-1] != nums[i] {
                for v in kSum(nums, target - nums[i], i+1, k-1) {
                    res.append([nums[i]] + v)
                }
            }
        }

        return res
    }

    func twoSum(_ nums: [Int], _ target: Int, _ start: Int) -> [[Int]] {
        var res = [[Int]]()

        let n = nums.count
        // print(nums, target, start)
        var left = start
        var right = n-1

        while left < right {
            let temp =  nums[left] + nums[right]

            if temp < target || (left > start && nums[left] == nums[left-1]) {
                left += 1
            } else if temp > target || (right < n-1 && nums[right] == nums[right+1]) {
                right -= 1
            } else {
                // later do it to avoid duplicate test
                // ex: [7,-8,-7,2,-7,-7,10,-6,10,-9,2,-7,-4,-7] -22
                res.append([nums[left], nums[right]])
                left += 1
                right -= 1
            }
        }

        return res
    }
}

/*
Solution 2:
set + kSum

Time Complexity: O(n^3)
Space Complexity: O(n)
*/
class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var nums = nums.sorted()
        return kSum(nums, target, 0, 4)
    }

    func kSum(_ nums: [Int], _ target: Int, _ start: Int, _ k: Int) -> [[Int]] {
        var res = [[Int]]()
        let n = nums.count

        if start == n
        || nums[start] * k > target
        || target > nums[n-1] * k {
            return res
        }

        if k == 2 {
            return twoSum(nums, target, start)
        }

        for i in start..<n {
            if i == start || nums[i-1] != nums[i] {
                for v in kSum(nums, target - nums[i], i+1, k-1) {
                    res.append([nums[i]] + v)
                }
            }
        }

        return res
    }

    func twoSum(_ nums: [Int], _ target: Int, _ start: Int) -> [[Int]] {
        var res = [[Int]]()
        var numSet = Set<Int>()
        for i in start..<nums.count {
            // use "res.isEmpty || res.last![1] != nums[i]"
            // not use "i == start || nums[i-1] != nums[i]"
            if (res.isEmpty || res.last![1] != nums[i]),
            numSet.contains(target - nums[i]) {
                res.append([target - nums[i], nums[i]])
            }
            numSet.insert(nums[i])
        }
        return res
    }
}

/*
Solution 1:
Map + 2sum

Time Complexity: O(n^3)
Space Complexity: O(n)
*/
class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {

        var numMap = [Int: Int]()
        for num in nums {
            numMap[num, default: 0] += 1
        }

        var key = Array(numMap.keys)
        let n = key.count

        var res = Set<[Int]>()
        for i in 0..<n {
            if let val = numMap[key[i]] {
                numMap[key[i]] = val > 1 ? val - 1 : nil
            }

            // print(numMap)
            for j in i..<n {
                if let val = numMap[key[j]] {
                    numMap[key[j]] = val > 1 ? val - 1 : nil
                } else {
                    continue
                }

                // print(key[i], key[j], numMap)
                let remain = target - (key[i] + key[j])
                let val = twoSum(numMap, remain)
                if !val.isEmpty {
                    let cur = [key[i], key[j]]
                    for v in val {
                        // sort to make sure we not insert duplicated array
                        res.insert((cur + v).sorted())
                    }
                }

                numMap[key[j], default: 0] += 1
            }
            numMap[key[i], default: 0] += 1
        }
        return Array(res)
    }

    func twoSum(_ numMap: [Int: Int], _ target: Int) -> [[Int]] {
        var res = [[Int]]()
        for k in numMap.keys {
            let another = target - k
            if (k == another && numMap[k, default: 0] >= 2)
            || (k != another && numMap[another] != nil) {
                res.append([k, another])
            }
        }
        return res
    }
}