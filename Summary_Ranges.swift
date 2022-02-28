/*
You are given a sorted unique integer array nums.

Return the smallest sorted list of ranges that cover all the numbers in the array exactly. That is, each element of nums is covered by exactly one of the ranges, and there is no integer x such that x is in one of the ranges but not in nums.

Each range [a,b] in the list should be output as:

"a->b" if a != b
"a" if a == b


Example 1:

Input: nums = [0,1,2,4,5,7]
Output: ["0->2","4->5","7"]
Explanation: The ranges are:
[0,2] --> "0->2"
[4,5] --> "4->5"
[7,7] --> "7"
Example 2:

Input: nums = [0,2,3,4,6,8,9]
Output: ["0","2->4","6","8->9"]
Explanation: The ranges are:
[0,0] --> "0"
[2,4] --> "2->4"
[6,6] --> "6"
[8,9] --> "8->9"


Constraints:

0 <= nums.length <= 20
-231 <= nums[i] <= 231 - 1
All the values of nums are unique.
nums is sorted in ascending order.
*/

/*
Solution 1:
merge ranges into [Int] array first
then convert it to String
*/
class Solution {
    func summaryRanges(_ nums: [Int]) -> [String] {
        if nums.isEmpty {
            return []
        }

        var ranges = [[Int]]()
        for num in nums {
            // sorted num, check if it can be merged to previous range,
            // or itself will be new ranges
            if ranges.isEmpty {
                ranges.append([num])
            } else {
                // compare num with last ranges
                var lastRange = ranges.removeLast()
                if num > lastRange.last! + 1 {
                    // num > lastRange.last + 1
                    // treat it as new range
                    // append last again, because we remove it first
                    ranges.append(lastRange)
                    ranges.append([num])
                } else {
                    // num is unique
                    // num == lastRnage.last + 1
                    // merge it with lastRange
                    if lastRange.count == 1 {
                        // current num is new closed element
                        lastRange.append(num)
                    } else {
                        // change lastRange closed num to num
                        lastRange[1] = num
                    }

                    // append to ranges
                    ranges.append(lastRange)
                }
            }
        }

        // convert ranges to string format
        var rangesStr = [String]()
        for r in ranges {
            rangesStr.append(convert(r))
        }

        return rangesStr
    }

    func convert(_ range: [Int]) -> String {
        if range.count == 1 {
            // only one element in the range
            return String(range[0])
        } else {
            // it is a close range
            return "\(range[0])->\(range[1])"
        }
    }
}