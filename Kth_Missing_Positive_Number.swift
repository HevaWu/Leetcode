/*
Given an array arr of positive integers sorted in a strictly increasing order, and an integer k.

Find the kth positive integer that is missing from this array.

 

Example 1:

Input: arr = [2,3,4,7,11], k = 5
Output: 9
Explanation: The missing positive integers are [1,5,6,8,9,10,12,13,...]. The 5th missing positive integer is 9.
Example 2:

Input: arr = [1,2,3,4], k = 2
Output: 6
Explanation: The missing positive integers are [5,6,7,...]. The 2nd missing positive integer is 6.
 

Constraints:

1 <= arr.length <= 1000
1 <= arr[i] <= 1000
1 <= k <= 1000
arr[i] < arr[j] for 1 <= i < j <= arr.length

Hint 1: Keep track of how many positive numbers are missing as you scan the array.
*/


/*
Solution 1: 
orderly update k to check if there is still missing number there

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func findKthPositive(_ arr: [Int], _ k: Int) -> Int {
        guard !arr.isEmpty, k >= arr[0] else { return k }
		// + 1, because number is start from 1,2,3
        var k = k - arr[0] + 1
        let n = arr.count
        for i in 1..<n {
            if arr[i] - arr[i-1] > k {
                return arr[i-1]+k
            } else {
				// - 1 here, ex: 2,3 no missing number, need to -1 distance
                k -= arr[i]-arr[i-1]-1
            }
        }
        return arr[n-1] + k
    }
}