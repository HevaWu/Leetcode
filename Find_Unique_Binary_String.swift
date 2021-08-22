/*
Given an array of strings nums containing n unique binary strings each of length n, return a binary string of length n that does not appear in nums. If there are multiple answers, you may return any of them.



Example 1:

Input: nums = ["01","10"]
Output: "11"
Explanation: "11" does not appear in nums. "00" would also be correct.
Example 2:

Input: nums = ["00","01"]
Output: "11"
Explanation: "11" does not appear in nums. "10" would also be correct.
Example 3:

Input: nums = ["111","011","001"]
Output: "101"
Explanation: "101" does not appear in nums. "000", "010", "100", and "110" would also be correct.


Constraints:

n == nums.length
1 <= n <= 16
nums[i].length == n
nums[i] is either '0' or '1'.
*/

class Solution {
    func findDifferentBinaryString(_ nums: [String]) -> String {
        let n = nums.count

        var nums = nums.sorted()
        if Int(nums[0], radix: 2) != 0 {
            return String(repeating: "0", count: n)
        }

        var pre = 0
        for i in 1..<n {
            let cur = Int(nums[i], radix: 2)!
            if cur - pre > 1 {
                // at least pre+1 is missing
                var str = String(pre+1, radix: 2)
                if str.count < n {
                    str.insert(contentsOf: Array(repeating: "0" , count: n-str.count), at: str.startIndex)
                }
                return str
            }
            pre = cur
        }

        // until n elements, all previous is added by 1,
        // output next +1 element would be fine
        var str = String(pre+1, radix: 2)
        if str.count < n {
            str.insert(contentsOf: Array(repeating: "0" , count: n-str.count), at: str.startIndex)
        }
        return str
    }
}