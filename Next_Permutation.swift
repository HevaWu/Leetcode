// Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers.
// If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order).
// The replacement must be in-place and use only constant extra memory.
// Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in the right-hand column.
// 1,2,3 → 1,3,2
// 3,2,1 → 1,2,3
// 1,1,5 → 1,5,1

// 看是否有下一个排列组合的数字 比当前数字稍微大一些
// 如果没有，直接逆转排序

// Solution1: Brute Force
// Just find all of the possiblity of permutation and find out the permutation which is just larger than the given one. But this one will be a very naive approach, since it requires us to find out every possible permutation which will take really long time and the implementation is complex. Thus, this approach is not acceptable at all. 
//
// Time complexity : O(n!). Total possible permutations is n!.
// Space complexity : O(n). Since an array will be used to store the permutations.

// Solution 2: 
// 1. find first a[first] which is in the ascending order, if cannot find, just reverse this array would be the answer. Note: after finding this element, assign it to a variable for checking, otherwise it is hard to clarify the descending & target index at 0
// 2. betwen firstIndex+1 to n-1, find the element just larger than a[firstIndex], and swap them
// 3. now, a[firstIndex] is the fixed one, for firstIndex+1 to n-1, just reverse them would be the correct answer
//
// Time complexity : O(n). In worst case, only two scans of the whole array are needed.
// Space complexity : O(1). No extra space is used. In place replacements are done.
class Solution {
    func nextPermutation(_ nums: inout [Int]) {        
        // check the first ascending element a[first]
        var i = nums.count - 2
        var first: Int?
        while i >= 0 {
           if nums[i] < nums[i+1] {
               	first = i
            	break
           }
            i -= 1
        }
        
        // check if this element exist, if not, reverse the array should be okay
        guard let firstIndex = first else {
            nums.reverse() 
            return 
        }
        
        // find next element a[second] close larger than a[first], swap a[first] & a[second]
        var secondIndex = firstIndex + 1
        for j in firstIndex+1..<nums.count {
            if nums[j] > nums[i], j > secondIndex {
                secondIndex = j
            }
        }
        nums.swapAt(firstIndex, secondIndex)
        
        // reverse array from i+1 to the end
        nums[(firstIndex+1)...].reverse()
    }
}

