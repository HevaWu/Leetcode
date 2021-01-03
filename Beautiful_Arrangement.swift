/*
Suppose you have n integers from 1 to n. We define a beautiful arrangement as an array that is constructed by these n numbers successfully if one of the following is true for the ith position (1 <= i <= n) in this array:

The number at the ith position is divisible by i.
i is divisible by the number at the ith position.
Given an integer n, return the number of the beautiful arrangements that you can construct.

 

Example 1:

Input: n = 2
Output: 2
Explanation: 
The first beautiful arrangement is [1, 2]:
Number at the 1st position (i=1) is 1, and 1 is divisible by i (i=1).
Number at the 2nd position (i=2) is 2, and 2 is divisible by i (i=2).
The second beautiful arrangement is [2, 1]:
Number at the 1st position (i=1) is 2, and 2 is divisible by i (i=1).
Number at the 2nd position (i=2) is 1, and i (i=2) is divisible by 1.
Example 2:

Input: n = 1
Output: 1
 

Constraints:

1 <= n <= 15
*/

/*
Solution 2:
improve Solution 1 by using
downwards
n -> 1

this will save lots of time when search from 1->n
this can cut a lot 
position i = 1 can hold any number, so I don't even have to check whether the last remaining number fits there. Also, position i = 2 happily holds every second number and i = 3 happily holds every third number, so filling the lowest positions last has a relatively high chance of success. 
*/
class Solution {
    func countArrangement(_ n: Int) -> Int {
        var count = 0
        var nums = Array(1...n)
        
        func find(_ index: Int) {
            if index == 1 {
                count += 1
                return 
            }
            for i in 0..<nums.count {
                if nums[i] % index == 0 || index % nums[i] == 0 {
                    let t = nums.remove(at: i)
                    find(index-1)
                    nums.insert(t, at: i)
                }
            }
        }
        
        find(n)
        return count
    }
}

/*
Solution 1:
backtrack -> upwards
1->n

Time Complexity: O(n!)
*/
class Solution {
    func countArrangement(_ n: Int) -> Int {
        var count = 0
        var nums = Array(1...n)
        
        func find(_ index: Int) {
            if index > n {
                count += 1
                return
            }
            for i in 0..<nums.count {
                if nums[i] % index == 0 || index % nums[i] == 0 {
                    let t = nums.remove(at: i)
                    find(index+1)
                    nums.insert(t, at: i)
                }
            }
        }
        
        find(1)
        return count
    }
}