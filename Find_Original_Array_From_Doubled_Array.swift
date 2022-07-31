/*
An integer array original is transformed into a doubled array changed by appending twice the value of every element in original, and then randomly shuffling the resulting array.

Given an array changed, return original if changed is a doubled array. If changed is not a doubled array, return an empty array. The elements in original may be returned in any order.



Example 1:

Input: changed = [1,3,4,2,6,8]
Output: [1,3,4]
Explanation: One possible original array could be [1,3,4]:
- Twice the value of 1 is 1 * 2 = 2.
- Twice the value of 3 is 3 * 2 = 6.
- Twice the value of 4 is 4 * 2 = 8.
Other original arrays could be [4,3,1] or [3,1,4].
Example 2:

Input: changed = [6,3,0,1]
Output: []
Explanation: changed is not a doubled array.
Example 3:

Input: changed = [1]
Output: []
Explanation: changed is not a doubled array.


Constraints:

1 <= changed.length <= 105
0 <= changed[i] <= 105
*/

/*
Solution 3:
use array to indicate freq

- find maxNum in changed
- freq = Array(repeating: 0, count: maxNum+1)
- update freq by go through changed
similar to Solution 1,2
use freq to check and store the original
- for num in 0...maxNum
  - check if freq[num] exist
    - update freq[num]
    - check if freq[twice] exist
      - update freq[twice]
      - store original
      - num -= 1, to re-check same num again
    - if not exist, return []

Time Complexity: O(X)
- X is largest number in changed
Space Complexity: O(X)
*/
class Solution {
    func findOriginalArray(_ changed: [Int]) -> [Int] {
        let n = changed.count
        if n % 2 != 0 { return [] }

        var maxNum = changed[0]
        for num in changed {
            maxNum = max(maxNum, num)
        }

        // use array to check the frequency in changed
        var freq = Array(repeating: 0, count: maxNum+1)
        for num in changed {
            freq[num] += 1
        }
        // print(freq)

        var original = [Int]()
        var num = 0
        while num <= maxNum {
            if freq[num] > 0 {
                freq[num] -= 1
                let twice = num * 2
                if twice <= maxNum, freq[twice] > 0 {
                    freq[twice] -= 1
                    original.append(num)
                    // need to re-check num again in next
                } else {
                    return []
                }
            } else {
                num += 1
            }
        }

        return original
    }
}

/*
Solution 2:
optimize Solution 1

update element one by one use freq

- sort changed
- for each element in changed
  - check its freq exist
    - update freq[num]
    - check if its twice value exist
      - update freq[twice]
      - add value to original
    - not exist, return []

Time Complexity: O(nlogn)
- n is changed.count
Space Complexity: O(n)
*/
class Solution {
    func findOriginalArray(_ changed: [Int]) -> [Int] {
        let n = changed.count
        if n % 2 != 0 { return [] }

        // record each number frequency
        // avoid redundant calculate same element
        var freq = [Int: Int]()
        for num in changed {
            freq[num, default: 0] += 1
        }

        // sort changed array
        var changed = changed.sorted(by: <)
        var original = [Int]()
        for num in changed {
            if let freqNum = freq[num] {
                freq[num] = freqNum == 1 ? nil : freqNum-1
                let twice = num * 2
                if let freqTwice = freq[twice] {
                    freq[twice] = freqTwice == 1 ? nil : freqTwice-1
                    original.append(num)
                } else {
                    return []
                }
            }
        }

        return original
    }
}

/*
Solution 1:
sorted + freq map + binary search to remove

- use freq map to help record each number's appearance times, to avoid redundant checking
- sort freq.keys, always pick the smallest value and check its value*2 element for make sure there is a {val, val*2} pair
- in each check
  - if val == 0, special case, val*2 == val, check and update freq
  - check if val*2 exist in sortedKey,
    - exist
    - freq_double >= freq_val
      - append repeated val to original array
      - update freq map
      - binary search and remove double element in sortedKey

Time Complexity: O(nlogn)
- n is unique numbers in changed
Space Complexity: O(n)
*/
class Solution {
    func findOriginalArray(_ changed: [Int]) -> [Int] {
        let n = changed.count
        if n % 2 != 0 { return [] }

        // record each number frequency
        // avoid redundant calculate same element
        var freq = [Int: Int]()
        for num in changed {
            freq[num, default: 0] += 1
        }

        // sort changed array
        var changed = freq.keys.sorted(by: <)
        var original = [Int]()
        while !changed.isEmpty {
            let val = changed.removeFirst()
            let double = val * 2

            if val == double {
                // check if element is 0
                guard let freq_val = freq[val],
                freq_val % 2 == 0 else { return [] }

                original.append(
                    contentsOf: Array(
                        repeating: val,
                        count: freq_val / 2
                    )
                )
                // update freq map
                freq[val] = nil

                // continue check next number
                continue
            }

            if let index = findIndex(double, changed) {
                guard let freq_val = freq[val],
                let freq_double = freq[double],
                freq_double >= freq_val else {
                    return []
                }

                // update freq
                freq[val] = nil
                freq[double] = (
                    freq_double == freq_val
                    ? nil
                    : freq_double - freq_val
                )

                if freq_double == freq_val {
                    changed.remove(at: index)
                }

                original.append(
                    contentsOf: Array(
                        repeating: val,
                        count: freq_val
                    )
                )

            } else {
                // print(val, double, changed)
                return []
            }
        }
        return original
    }

    // if can find target in arr, return index,
    // else return nil
    func findIndex(_ target: Int, _ arr: [Int]) -> Int? {
        if arr.isEmpty { return nil }
        var l = 0
        var r = arr.count-1
        while l <= r {
            let mid = l + (r-l)/2
            if arr[mid] == target { return mid }
            if arr[mid] < target {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        return nil
    }
}