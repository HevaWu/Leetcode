/*
Remove all elements from a linked list of integers that have value val.

Example:

Input:  1->2->6->3->4->5->6, val = 6
Output: 1->2->3->4->5
*/

/*
Solution 2:
without dummy

iterate list once
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
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        guard let head = head else { return nil }
        
        var cur: ListNode? = head
        while cur?.val == val {
            cur = cur?.next
        }
        
        let _head = cur
        while cur != nil {
            if cur!.next?.val == val {
                cur!.next = cur!.next?.next
            } else {
                cur = cur!.next
            }
        }
        
        return _head
    }
}

/*
Solution 1:
use dummy head

Time Complexity: O(n)
Space Complexity: O(n)
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
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        var node: ListNode? = head
        
        var dummy = ListNode(0)
        var cur: ListNode? = dummy
        
        while node != nil {
            if node!.val != val {
                cur?.next = ListNode(node!.val)
                cur = cur?.next
            }
            node = node!.next
        }
        return dummy.next
    }
}