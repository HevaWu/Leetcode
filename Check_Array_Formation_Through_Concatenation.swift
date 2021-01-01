/*
You are given an array of distinct integers arr and an array of integer arrays pieces, where the integers in pieces are distinct. Your goal is to form arr by concatenating the arrays in pieces in any order. However, you are not allowed to reorder the integers in each array pieces[i].

Return true if it is possible to form the array arr from pieces. Otherwise, return false.

 

Example 1:

Input: arr = [85], pieces = [[85]]
Output: true
Example 2:

Input: arr = [15,88], pieces = [[88],[15]]
Output: true
Explanation: Concatenate [15] then [88]
Example 3:

Input: arr = [49,18,16], pieces = [[16,18,49]]
Output: false
Explanation: Even though the numbers match, we cannot reorder pieces[0].
Example 4:

Input: arr = [91,4,64,78], pieces = [[78],[4,64],[91]]
Output: true
Explanation: Concatenate [91] then [4,64] then [78]
Example 5:

Input: arr = [1,3,5,7], pieces = [[2,4,6,8]]
Output: false
 

Constraints:

1 <= pieces.length <= arr.length <= 100
sum(pieces[i].length) == arr.length
1 <= pieces[i].length <= arr.length
1 <= arr[i], pieces[i][j] <= 100
The integers in arr are distinct.
The integers in pieces are distinct (i.e., If we flatten pieces in a 1D array, all the integers in this array are distinct).

Hint1: Note that the distinct part means that every position in the array belongs to only one piece
Hint2: Note that you can get the piece every position belongs to naively
*/

/*
Solution 1:
build map to help quick find current pieces element

1. map -> key is pieces[i][0], value is pieces[i]. This can help quick find current pieces, because all of element is distinct, which means one number will only appear once
2. search arr, once we find arr[i] is a key of map, which means pieces contains an element array start from arr[i], compare element from arr[i] with map[arr[i]].
- if there is no map[arr[i]], return false
- if there is any difference between arr[i], map[arr[i]], return false

Time Complexity:
O(2n), n is the total count of number
*/
class Solution {
    func canFormArray(_ arr: [Int], _ pieces: [[Int]]) -> Bool {
        // key is pieces[i][0], value is pieces[i]
        var map: [Int: [Int]] = [:]
        
        for p in pieces {
            map[p[0]] = p
        }
        
        let n = arr.count
        var i = 0
        while i < n {
            if let cur = map[arr[i]] {
                for j in cur {
                    if arr[i] != j {
                        return false
                    }
                    i += 1
                }
            } else {
                return false
            }
        }
        return true
    }
}