/*
Given a linked list, swap every two adjacent nodes and return its head.

You may not modify the values in the list's nodes. Only nodes itself may be changed.



Example 1:


Input: head = [1,2,3,4]
Output: [2,1,4,3]
Example 2:

Input: head = []
Output: []
Example 3:

Input: head = [1]
Output: [1]


Constraints:

The number of nodes in the list is in the range [0, 100].
0 <= Node.val <= 100
*/

/*
Solution 2:
loop over node
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
    func swapPairs(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }

        var dummy = ListNode(0)
        dummy.next = head
        var cur: ListNode? = dummy
        while cur != nil, cur?.next != nil, cur?.next?.next != nil {
            let next = cur?.next?.next
            cur?.next?.next = next?.next
            next?.next = cur?.next
            cur?.next = next
            cur = cur?.next?.next
        }
        return dummy.next
    }
}

/*
Solution 1:
recursively

swap first 2 nodes, then append swapPairs(head.next.next) to it
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
    func swapPairs(_ head: ListNode?) -> ListNode? {
        guard let _head = head,
        let headNext = _head.next else {
            return head
        }

        // later recursive node
        let temp = headNext.next
        headNext.next = _head
        _head.next = swapPairs(temp)
        return headNext
    }
}