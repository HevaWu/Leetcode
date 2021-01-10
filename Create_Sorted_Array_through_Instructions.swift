/*
Given an integer array instructions, you are asked to create a sorted array from the elements in instructions. You start with an empty container nums. For each element from left to right in instructions, insert it into nums. The cost of each insertion is the minimum of the following:

The number of elements currently in nums that are strictly less than instructions[i].
The number of elements currently in nums that are strictly greater than instructions[i].
For example, if inserting element 3 into nums = [1,2,3,5], the cost of insertion is min(2, 1) (elements 1 and 2 are less than 3, element 5 is greater than 3) and nums will become [1,2,3,3,5].

Return the total cost to insert all elements from instructions into nums. Since the answer may be large, return it modulo 109 + 7

 

Example 1:

Input: instructions = [1,5,6,2]
Output: 1
Explanation: Begin with nums = [].
Insert 1 with cost min(0, 0) = 0, now nums = [1].
Insert 5 with cost min(1, 0) = 0, now nums = [1,5].
Insert 6 with cost min(2, 0) = 0, now nums = [1,5,6].
Insert 2 with cost min(1, 2) = 1, now nums = [1,2,5,6].
The total cost is 0 + 0 + 0 + 1 = 1.
Example 2:

Input: instructions = [1,2,3,6,5,4]
Output: 3
Explanation: Begin with nums = [].
Insert 1 with cost min(0, 0) = 0, now nums = [1].
Insert 2 with cost min(1, 0) = 0, now nums = [1,2].
Insert 3 with cost min(2, 0) = 0, now nums = [1,2,3].
Insert 6 with cost min(3, 0) = 0, now nums = [1,2,3,6].
Insert 5 with cost min(3, 1) = 1, now nums = [1,2,3,5,6].
Insert 4 with cost min(3, 2) = 2, now nums = [1,2,3,4,5,6].
The total cost is 0 + 0 + 0 + 0 + 1 + 2 = 3.
Example 3:

Input: instructions = [1,3,3,3,2,4,2,1,2]
Output: 4
Explanation: Begin with nums = [].
Insert 1 with cost min(0, 0) = 0, now nums = [1].
Insert 3 with cost min(1, 0) = 0, now nums = [1,3].
Insert 3 with cost min(1, 0) = 0, now nums = [1,3,3].
Insert 3 with cost min(1, 0) = 0, now nums = [1,3,3,3].
Insert 2 with cost min(1, 3) = 1, now nums = [1,2,3,3,3].
Insert 4 with cost min(5, 0) = 0, now nums = [1,2,3,3,3,4].
​​​​​​​Insert 2 with cost min(1, 4) = 1, now nums = [1,2,2,3,3,3,4].
​​​​​​​Insert 1 with cost min(0, 6) = 0, now nums = [1,1,2,2,3,3,3,4].
​​​​​​​Insert 2 with cost min(2, 4) = 2, now nums = [1,1,2,2,2,3,3,3,4].
The total cost is 0 + 0 + 0 + 0 + 1 + 0 + 1 + 0 + 2 = 4.
 

Constraints:

1 <= instructions.length <= 105
1 <= instructions[i] <= 105

Hint 1:
This problem is closely related to finding the number of inversions in an array

Hint 2: 
if i know the position in which i will insert the i-th element in I can find the minimum cost to insert it
*/

/*
Solution 2:
Binary indexed tree

Time Complexity: O(n logM)
- n is length
- m is range of instructions[i]
*/
class Solution {
    var cache = Array(repeating: 0, count: 100001)
    func createSortedArray(_ instructions: [Int]) -> Int {
        let mod = Int(1e9 + 7)
        var cost = 0
        for (i, v) in instructions.enumerated() {
            cost += min(get(v-1), i - get(v))
            update(instructions[i])
        }
        return cost % mod
    }
    
    func update(_ x: Int) {
        var x = x
        while x < 100001 {
            cache[x] += 1
            x += (x & -x)
        }
    }
    
    func get(_ x: Int) -> Int {
        var x = x 
        var res = 0
        while x > 0 {
            res += cache[x]
            x -= (x & -x)
        }
        return res
    }
}

/*
Solution 1:
Time Limit exceed

each time insert num into nums, then calculate cost, add it to the result and % mod

Time Complexity: O(n*nlogn)
*/
class Solution {
    func createSortedArray(_ instructions: [Int]) -> Int {
        var nums = [Int]()
        var cost = 0
        var count = 0
        let mod = Int(1e9 + 7)
        
        // key is number
        // value is how many items it appears
        var map = [Int: Int]()
        
        var added = 0
        for i in instructions {
            let pos = insert(i, in: nums, 0, count-1)
            nums.insert(i, at: pos)
            
            added = min(pos, count-pos-map[i, default: 0]) % mod
            cost = (cost + added) % mod
            
            map[i, default: 0] += 1
            count += 1
        }
        return cost
    }
    
    // return pos where insert num in nums
    func insert(_ num: Int, in nums: [Int], _ start: Int, _ end: Int) -> Int {
        guard !nums.isEmpty else { return start }
        if num <= nums[start] { return start }
        if num > nums[end] { return end+1 }
        
        let mid = (start+end)/2
        if num <= nums[mid] {
            return insert(num, in: nums, start, mid)
        } else {
            return insert(num, in: nums, mid+1, end)
        }        
    }
}
