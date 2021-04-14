/*
Given the head of a linked list and a value x, partition it such that all nodes less than x come before nodes greater than or equal to x.

You should preserve the original relative order of the nodes in each of the two partitions.



Example 1:


Input: head = [1,4,3,2,5,2], x = 3
Output: [1,2,2,4,3,5]
Example 2:

Input: head = [2,1], x = 2
Output: [1,2]


Constraints:

The number of nodes in the list is in the range [0, 200].
-100 <= Node.val <= 100
-200 <= x <= 200
*/

/*
Solution 2:
use 2 dummyHead

beforeH, before: for node < x
afterH, after: for node >= x
then set
- after.next = nil
- before.next = afterH
- return beforeH.next

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
class Solution2 {
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        if head == nil { return nil }

        var beforeH = ListNode(0)
        var afterH = ListNode(0)
        var before = beforeH
        var after = afterH

        var node = head
        while node != nil {
            if node!.val >= x {
                after.next = node
                after = after.next!
            } else {
                before.next = node
                before = before.next!
            }
            node = node!.next
        }
        // make sure after.next not append other listNode
        after.next = nil
        before.next = afterH.next
        return beforeH.next
    }
}

/*
Solution 1:
find first >= x node,
for later node, remove&insert if they are < x

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
class Solution1 {
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        guard let head = head else { return nil }

        var pre: ListNode? = nil
        var node: ListNode? = head

        while node != nil {
            if node!.val >= x {
                break
            }
            pre = node!
            node = node!.next
        }

        // current list node all < x, OR all >= x
        if node == nil { return head }

        var dummy = ListNode(0)
        dummy.next = head

        var pre1: ListNode? = pre == nil ? dummy : pre
        pre = node
        node = node!.next
        while node != nil {
            if node!.val < x {
                // remove from last half
                pre!.next = node!.next

                // insert to first half
                node!.next = pre1!.next
                pre1!.next = node
                pre1 = pre1!.next!

                node = pre!.next
                // print(node!.val, pre!.val, pre1!.val)
            } else {
                pre = node!
                node = node!.next
            }
        }
        return dummy.next
    }
}