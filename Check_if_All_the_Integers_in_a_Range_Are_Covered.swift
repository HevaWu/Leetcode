/*
You are given a 2D integer array ranges and two integers left and right. Each ranges[i] = [starti, endi] represents an inclusive interval between starti and endi.

Return true if each integer in the inclusive range [left, right] is covered by at least one interval in ranges. Return false otherwise.

An integer x is covered by an interval ranges[i] = [starti, endi] if starti <= x <= endi
*/

/*
Solution 1:
merge ranges first,
then binary search to find if there is a range can cover [left, right]

Time Complexity: O(nlogn + n^2 + logk)
k is final merged ranges length
Space Complexity: O(k)
*/
class Solution {
    func isCovered(_ ranges: [[Int]], _ left: Int, _ right: Int) -> Bool {
        let n = ranges.count
        var ranges = ranges.sorted(by: { first, second -> Bool in
            return first[0] == second[0] ? first[1] < second[1] : first[0] < second[0]
        })

        var arr = [(start: Int, end: Int)]()
        for r in ranges {
            if arr.isEmpty {
                arr.append((r[0], r[1]))
            } else {
                var temp_s = r[0]
                var temp_e = r[1]
                while !arr.isEmpty, arr.last!.end+1 >= temp_s {
                    let (cur_s, cur_e) = arr.removeLast()
                    temp_s = min(temp_s, cur_s)
                    temp_e = max(temp_e, cur_e)
                }
                arr.append((temp_s, temp_e))
            }
        }

        var l = 0
        var r = arr.count-1
        while l < r {
            let mid = l + (r - l)/2
            if arr[mid].start < left {
                l = mid+1
            } else {
                r = mid
            }
        }

        // print(arr, l)
        if arr[l].start <= left {
            if arr[l].end < left {
                return l+1 < arr.count && arr[l+1].start <= left && arr[l+1].end >= right
            } else {
                return arr[l].end >= right
            }
        } else {
            if l == 0 { return false }
            return arr[l-1].start <= left && arr[l-1].end >= right
        }
    }
}