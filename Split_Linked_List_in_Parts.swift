/*
Given a (singly) linked list with head node root, write a function to split the linked list into k consecutive linked list "parts".

The length of each part should be as equal as possible: no two parts should have a size differing by more than 1. This may lead to some parts being null.

The parts should be in order of occurrence in the input list, and parts occurring earlier should always have a size greater than or equal parts occurring later.

Return a List of ListNode's representing the linked list parts that are formed.

Examples 1->2->3->4, k = 5 // 5 equal parts [ [1], [2], [3], [4], null ]
Example 1:
Input:
root = [1, 2, 3], k = 5
Output: [[1],[2],[3],[],[]]
Explanation:
The input and each element of the output are ListNodes, not arrays.
For example, the input root has root.val = 1, root.next.val = 2, \root.next.next.val = 3, and root.next.next.next = null.
The first element output[0] has output[0].val = 1, output[0].next = null.
The last element output[4] is null, but it's string representation as a ListNode is [].
Example 2:
Input:
root = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], k = 3
Output: [[1, 2, 3, 4], [5, 6, 7], [8, 9, 10]]
Explanation:
The input has been split into consecutive parts with size difference at most 1, and earlier parts are a larger size than the later parts.
Note:

The length of root will be in the range [0, 1000].
Each value of a node in the input will be an integer in the range [0, 999].
k will be an integer in the range [1, 50].
*/

/*
Solution 2:
optimize solution 1 by using for loop

Time Complexity: O(n)
Space Complexity: O(1)
*/
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    func splitListToParts(_ root: ListNode?, _ k: Int) -> [ListNode?] {
        var n = 0
        var node = root
        while node != nil {
            node = node!.next
            n += 1
        }

        var remain = n % k
        var limit = n / k
        var res: [ListNode?] = Array(repeating: nil, count: k)

        node = root

        for i in 0..<k {
            var cur = node
            let temp = limit + (i < remain ? 1 : 0) - 1
            if temp > 0 {
                for j in 0..<temp {
                    if node != nil { node = node?.next }
                }
            }

            if node != nil {
                let pre = node
                node = node?.next
                pre?.next = nil
            }
            res[i] = cur
        }

        return res
    }
}

/*
Solution 1:
- calculate n
- iterate to put element into corresponding linkedlist

Time Complexity: O(n)
Space Complexity: O(1)
*/
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    func splitListToParts(_ root: ListNode?, _ k: Int) -> [ListNode?] {
        var n = 0
        var node = root
        while node != nil {
            node = node!.next
            n += 1
        }

        var remain = n % k
        var limit = n / k
        var res: [ListNode?] = Array(repeating: nil, count: k)

        node = root

        var index = 0

        var cur = node
        var size = 1
        while node != nil {
            if remain > 0 {
                if size < limit + 1 {
                    node = node?.next
                    size += 1
                } else {
                    let next = node?.next
                    node?.next = nil

                    res[index] = cur
                    index += 1
                    node = next
                    cur = node
                    remain -= 1
                    size = 1
                }
            } else {
                if size < limit {
                    node = node?.next
                    size += 1
                } else {
                    let next = node?.next
                    node?.next = nil

                    res[index] = cur
                    index += 1
                    node = next
                    cur = node
                    size = 1
                }
            }
        }
        return res
    }
}