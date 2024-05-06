/*
You are given the head of a linked list.

Remove every node which has a node with a greater value anywhere to the right side of it.

Return the head of the modified linked list.



Example 1:


Input: head = [5,2,13,3,8]
Output: [13,8]
Explanation: The nodes that should be removed are 5, 2 and 3.
- Node 13 is to the right of node 5.
- Node 13 is to the right of node 2.
- Node 8 is to the right of node 3.
Example 2:

Input: head = [1,1,1,1]
Output: [1,1,1,1]
Explanation: Every node has value 1, so no nodes are removed.


Constraints:

The number of the nodes in the given list is in the range [1, 105].
1 <= Node.val <= 105
*/

/*
Solution 1:
Reverse list
Order list by increasing order (remove node.val < cur one)
Reverse list again

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
    func removeNodes(_ head: ListNode?) -> ListNode? {
        var prev: ListNode? = nil
        var cur = head
        // Reverse list
        while cur != nil {
            let next = cur?.next
            cur?.next = prev
            prev = cur
            cur = next
        }

        // traverse the reversed list, keep nodes >= prev
        var dummy = ListNode(0)
        var tmpPrev: ListNode? = dummy
        cur = prev
        while cur != nil {
            if cur!.val >= tmpPrev!.val {
                tmpPrev!.next = cur
                tmpPrev = cur
                cur = cur?.next
            } else {
                cur = cur?.next
            }
        }
        tmpPrev?.next = nil

        // reverse list
        var newPrev: ListNode? = nil
        cur = dummy.next
        while cur != nil {
            let next = cur?.next
            cur?.next = newPrev
            newPrev = cur
            cur = next
        }
        return newPrev
    }
}
