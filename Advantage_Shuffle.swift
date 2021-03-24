/*
Given two arrays A and B of equal size, the advantage of A with respect to B is the number of indices i for which A[i] > B[i].

Return any permutation of A that maximizes its advantage with respect to B.

 

Example 1:

Input: A = [2,7,11,15], B = [1,10,4,11]
Output: [2,11,7,15]
Example 2:

Input: A = [12,24,8,32], B = [13,25,32,11]
Output: [24,32,8,12]
 

Note:

1 <= A.length = B.length <= 10000
0 <= A[i] <= 10^9
0 <= B[i] <= 10^9
*/

/*
Solution 1:
sort and reorder array

Idea: 
- sort A
- for each i in 0..<n, find if smallest element between A[i..<n], that A[index] > B[i], 
	- change A to A[index, i, ..., index-1, index+1, ..., n-1]
	- binary search find proper position

Time Compexitly: O(nlogn)
Space Compexitly: O(1)
*/
class Solution {
    func advantageCount(_ A: [Int], _ B: [Int]) -> [Int] {
        var A = A.sorted()
        let n = A.count
        
        for i in 0..<n {
            let index = insert(B[i], A, i, n-1)
            if index == -1 { continue }
            let val = A.remove(at: index)
            A.insert(val, at: i)
        }
        return A
    }
    
    // return proper index that A[index] > num
    // return -1 when it can only add at end of array(means there is no larger A[i])
    func insert(_ num: Int, _ arr: [Int], 
                _ left: Int, _ right: Int) -> Int {
        if num >= arr[right] { return -1 }
        var left = left
        var right = right
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] <= num {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return arr[left] > num ? left : left + 1
    }
}

/*
Solution 2:
greedy

use map to help memo already found larger value for b element

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func advantageCount(_ A: [Int], _ B: [Int]) -> [Int] {
        var A = A.sorted()
        var map = [Int: [Int]]()
        for b in B.sorted(by: >) {
            if b < A.last! {
                map[b, default: [Int]()].append(A.removeLast())
            }
        }
        
        var res = [Int]()
        for b in B {
            if var list = map[b] {
                res.append(list.removeLast())
                map[b] = list.isEmpty ? nil : list
            } else {
                res.append(A.removeLast())
            }
        }
        return res
    }
    
}