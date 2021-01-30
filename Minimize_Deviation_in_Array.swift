/*
You are given an array nums of n positive integers.

You can perform two types of operations on any element of the array any number of times:

If the element is even, divide it by 2.
For example, if the array is [1,2,3,4], then you can do this operation on the last element, and the array will be [1,2,3,2].
If the element is odd, multiply it by 2.
For example, if the array is [1,2,3,4], then you can do this operation on the first element, and the array will be [2,2,3,4].
The deviation of the array is the maximum difference between any two elements in the array.

Return the minimum deviation the array can have after performing some number of operations.

 

Example 1:

Input: nums = [1,2,3,4]
Output: 1
Explanation: You can transform the array to [1,2,3,2], then to [2,2,3,2], then the deviation will be 3 - 2 = 1.
Example 2:

Input: nums = [4,1,5,20,3]
Output: 3
Explanation: You can transform the array after two operations to [4,2,5,5,3], then the deviation will be 5 - 2 = 3.
Example 3:

Input: nums = [2,10,8]
Output: 3
 

Constraints:

n == nums.length
2 <= n <= 105
1 <= nums[i] <= 109

Hint 1:
Assume you start with the minimum possible value for each number so you can only multiply a number by 2 till it reaches its maximum possible value.

Hint 2:
If there is a better solution than the current one, then it must have either its maximum value less than the current maximum value, or the minimum value larger than the current minimum value.

Hint 3:
Since that we only increase numbers (multiply them by 2), we cannot decrease the current maximum value, so we must multiply the current minimum number by 2.
*/

/*
Solution 3
mathmatical 
Suppose the largest odd factor of all numbers in nums is c. Then for any num in nums with factor c, the transformed list with minimal deviation would transform num into c.
Proof. Suppose after transformation, the list contains three kinds of elements:

Small = {elements smaller than c};
Equal = {c};
Large = {elements larger than c}.
We then know all elements in Large are even numbers. (Otherwise c is not the largest odd factor!) Then we divide into two cases:

If Small is not empty: in this case c is not the smallest element. Then lifting c will not improve the deviation;
If Small is empty: in this case c is the smallest element, so lifting c to 2*c might improve the deviation; however, after lifting c to 2*c, all the elements in the list would be even numbers, so we can improve the deviation by dividing each element by 2. Then 2*c falls to c again.
Thus we finish the proof. With this intuition, we can transform the problem into a much easier one.

For each element num in nums and its candidate tranformations, we pick the transformations that are closest to c from upside and downside, and write as (x, y). When both directions are possible, x and y are both positive integers; otherwise one of them is set as infty. Then the problem becomes the following:

New problem: Suppose we have a list of positive integer pairs(including infty) [(x1, y1), ..., (xn, yn)]. We can pick either xi or yi from each pair, and the goal is to minimize max(picked xi's) + max(picked yi's).
This new problem is much easier: we can sort the list by values of xi, and maintain a running maximal value of yi's we have seen. See the codes for details.

Complexity: 
Computing the [(x1, y1), ..., (xn, yn)] list requires O(N log(M)) where M=max(nums); sorting requires O(N log(N)). So the overall complexity is O(N log(MN)), which is an improvement over the algorithms provided in the official solution.
*/
class Solution {
    func minimumDeviation(_ nums: [Int]) -> Int {
        var maxOdd = 0
        for i in nums {
            var j = i
            while j % 2 == 0 {
                j = Int(floor(Double(j / 2)))
            }
            maxOdd = max(maxOdd, j)
        }
        var dev: [(Int, Int)] = []
        for i in nums {
            if i % 2 == 1 {
                if 2 * i > maxOdd {
                    dev.append((2*i-maxOdd, maxOdd-i))
                } else {
                    dev.append((Int.max, maxOdd - 2 * i))
                }
            } else {
                if i < maxOdd {
                    dev.append((Int.max, maxOdd - i))
                } else {
                    var j = i

                    while j % 2 == 0 && j > maxOdd {
                        j = j / 2
                    }
                    if j < maxOdd {
                        dev.append((2 * j - maxOdd, maxOdd - j))
                    }
                }
            }
        }
        dev.sort{$0>$1}
        if dev.count == 0 {return 0}
        var maxDown: [Int] = Array(repeating: 0, count: dev.count)
        var cur = 0
        for i in 0..<maxDown.count {
            cur = max(cur, dev[i].1)
            maxDown[i] = cur
        }
        var mn = (min(maxDown.last!, dev[0].0))
        for i in 0..<maxDown.count - 1 {
            if dev[i + 1].0 != Int.max {
                mn = min(mn, (maxDown[i] + dev[i + 1].0))
            }
        }
        return Int(mn)
    }
}

/*
Solution 2:
optimize solution 1 by using binray search 
find proper way to insert element

odd value can only multiply 2 once,
first, multiply all odd elements

then for max even val, 
check if divide it can update res

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func minimumDeviation(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        
        var arr = [Int]()
        
        for n in nums {
            insert(&arr, n % 2 == 0 ? n : n*2)
        }
        // print(arr)
        
        var res = arr.last! - arr.first!
        while arr.last! % 2 == 0 {
            insert(&arr, arr.last!/2)
            arr.removeLast()
            res = min(res, arr.last! - arr.first!)
        }
        return res
    }
    
    // binary search insert
    func insert(_ nums: inout [Int], _ target: Int) {
        if nums.isEmpty {
            nums.append(target)
            return
        }
        
        var left = 0
        var right = nums.count-1
        while left < right {
            let mid = left+(right-left)/2
            
            if nums[mid] < target {
                left = mid + 1
            } else {
                right = mid
            }
        }
        
		// this is for avoid insert duplicate element
        if nums[left] == target {
            return
        } else if nums[left] < target {
            nums.insert(target, at: left+1)
        } else {
            nums.insert(target, at: left)
        }
    }
}

/*
Solution 1:
set
Time limit exceed

odd value can only multiply 2 once,
first, multiply all odd elements

then for max even val, 
check if divide it can update res

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func minimumDeviation(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        
        var set = Set<Int>()
        
        for n in nums {
            set.insert(n % 2 == 0 ? n : n*2)
        }
        
        var res = set.max()!-set.min()!
        while set.max()! % 2 == 0 {
            let maxVal = set.max()!
            set.insert(maxVal/2)
            set.remove(maxVal)
            res = min(res, set.max()! - set.min()!)
        }
        return res
    }
}