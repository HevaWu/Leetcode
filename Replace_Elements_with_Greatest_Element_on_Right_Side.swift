/*
Given an array arr, replace every element in that array with the greatest element among the elements to its right, and replace the last element with -1.

After doing so, return the array.

 

Example 1:

Input: arr = [17,18,5,4,6,1]
Output: [18,6,6,6,1,-1]
Explanation: 
- index 0 --> the greatest element to the right of index 0 is index 1 (18).
- index 1 --> the greatest element to the right of index 1 is index 4 (6).
- index 2 --> the greatest element to the right of index 2 is index 4 (6).
- index 3 --> the greatest element to the right of index 3 is index 4 (6).
- index 4 --> the greatest element to the right of index 4 is index 5 (1).
- index 5 --> there are no elements to the right of index 5, so we put -1.
Example 2:

Input: arr = [400]
Output: [-1]
Explanation: There are no elements to the right of index 0.
 

Constraints:

1 <= arr.length <= 104
1 <= arr[i] <= 105

Hint 1:
Loop through the array starting from the end.

Hint 2:
Keep the maximum value seen so far.
*/

/*
Solution 1:
iterate array from end

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func replaceElements(_ arr: [Int]) -> [Int] {
        if arr.count == 1 { return [-1] }
        
        var maxEle = -1
        var res = arr
        for j in stride(from: arr.count-1, through: 0, by: -1) {
            res[j] = maxEle
            maxEle = max(maxEle, arr[j])
        }
        return res
    }
}