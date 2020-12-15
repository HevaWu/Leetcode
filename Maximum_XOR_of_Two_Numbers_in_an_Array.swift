/*
Given an integer array nums, return the maximum result of nums[i] XOR nums[j], where 0 ≤ i ≤ j < n.

Follow up: Could you do this in O(n) runtime?

 

Example 1:

Input: nums = [3,10,5,25,2,8]
Output: 28
Explanation: The maximum result is 5 XOR 25 = 28.
Example 2:

Input: nums = [0]
Output: 0
Example 3:

Input: nums = [2,4]
Output: 6
Example 4:

Input: nums = [8,10,2]
Output: 10
Example 5:

Input: nums = [14,70,53,83,49,91,36,80,92,51,66,70]
Output: 127
 

Constraints:

1 <= nums.length <= 2 * 104
0 <= nums[i] <= 231 - 1
*/


/*
Solution 1:
Trie
bitmap 

insert: check num's curBit from 31 to 0, and put them into Trie
searchMaximumXOR: check num's curBit XOR exist or not, it exist, add it into temp sum, and compare the result with res later
*/
class Solution {
    func findMaximumXOR(_ nums: [Int]) -> Int {
        let t = Trie(nums)
        
        var res = Int.min
        nums.forEach { num in
            res = max(res, t.searchMaximumXOR(num))
        }
        return res
    }
}

class Trie {
    class TrieNode {
        var child: [TrieNode?] = [nil, nil]
    }
    
    var root: TrieNode
    init(_ nums: [Int]) {
        root = TrieNode()
        nums.forEach { insert($0) }
    }
    
    func insert(_ num: Int) {
        var cur = root
        for i in stride(from: 31, through: 0, by: -1) {
            let curBit = (num >> i) & 1
            if cur.child[curBit] == nil {
                cur.child[curBit] = TrieNode()
            }
            cur = cur.child[curBit]!
        }
    }
    
    func searchMaximumXOR(_ num: Int) -> Int {
        var cur = root
        var res = 0
        for i in stride(from: 31, through: 0, by: -1) {
            let curBit = (num >> i) & 1
            if cur.child[curBit ^ 1] != nil {
                res += (1 << i)
                cur = cur.child[curBit ^ 1]!
            } else {
                cur = cur.child[curBit]!
            }
        }
        return res
    }
}

/*
Solution 2:
bit mask

create mask for it:
stride from 31 to 0, if i = 28, mask will be 1111000....0

stride from 31 make sure we find largest value first
then get nums first i bit, and store them into Set

get the ideal num, if it exist, update res to ideal

Time Complexity: O(n)
*/
class Solution {
    func findMaximumXOR(_ nums: [Int]) -> Int {
        var res = 0
        
        var mask = 0
        for i in stride(from: 31, through: 0, by: -1) {
            mask |= 1 << i
            
            // prefix set for top num's i bits in nums
            var prefix = Set<Int>()
            nums.forEach { prefix.insert($0 & mask) }
            
            let ideal = res | 1 << i
            for p in prefix {
                if prefix.contains(ideal ^ p) {
                    res = ideal
                    break
                }
            }
        }
        
        return res
    }
}