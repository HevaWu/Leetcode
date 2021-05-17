/*
Given a string s represents the serialization of a nested list, implement a parser to deserialize it and return the deserialized NestedInteger.

Each element is either an integer or a list whose elements may also be integers or other lists.



Example 1:

Input: s = "324"
Output: 324
Explanation: You should return a NestedInteger object which contains a single integer 324.
Example 2:

Input: s = "[123,[456,[789]]]"
Output: [123,[456,[789]]]
Explanation: Return a NestedInteger object containing a nested list with 2 elements:
1. An integer containing value 123.
2. A nested list containing two elements:
    i.  An integer containing value 456.
    ii. A nested list with one element:
         a. An integer containing value 789


Constraints:

1 <= s.length <= 5 * 104
s consists of digits, square brackets "[]", negative sign '-', and commas ','.
s is the serialization of valid NestedInteger.

*/

/*
Solution 1:
iterate string

prepare stack for storing founded NestedInteger object

Time Complexity: O(n)
Space Complexity: O()
*/
/**
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * class NestedInteger {
 *     // Return true if this NestedInteger holds a single integer, rather than a nested list.
 *     public func isInteger() -> Bool
 *
 *     // Return the single integer that this NestedInteger holds, if it holds a single integer
 *     // The result is undefined if this NestedInteger holds a nested list
 *     public func getInteger() -> Int
 *
 *     // Set this NestedInteger to hold a single integer.
 *     public func setInteger(value: Int)
 *
 *     // Set this NestedInteger to hold a nested list and adds a nested integer to it.
 *     public func add(elem: NestedInteger)
 *
 *     // Return the nested list that this NestedInteger holds, if it holds a nested list
 *     // The result is undefined if this NestedInteger holds a single integer
 *     public func getList() -> [NestedInteger]
 * }
 */
class Solution {
    func deserialize(_ s: String) -> NestedInteger {
        let n = s.count
        if s.first != "[" { return NestedInteger(Int(s)!) }

        var cur: NestedInteger? = nil
        var stack = [NestedInteger]()

        var s = Array(s)

        var l = 0
        var r = 0
        while r < n {
            if s[r] == "[" {
                if cur != nil {
                    stack.append(cur!)
                }
                cur = NestedInteger()
                l = r+1
            } else if s[r] == "]" {
                if let num = Int(String(s[l..<r])) {
                    cur?.add(NestedInteger(num))
                }
                if !stack.isEmpty {
                    var val = stack.removeLast()
                    val.add(cur!)
                    cur = val
                }
                l = r+1
            } else if s[r] == "," {
                if s[r-1] != "]" {
                    if let num = Int(String(s[l..<r])) {
                        cur?.add(NestedInteger(num))
                    }
                }
                l = r+1
            }

            r += 1
        }

        return cur!
    }
}