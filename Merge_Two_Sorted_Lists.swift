// Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.

// Example:

// Input: 1->2->4, 1->3->4
// Output: 1->1->2->3->4->4

// Solution 1: iterate
// Time complexity : O(n + m)O(n+m)
// Because exactly one of l1 and l2 is incremented on each loop iteration, the while loop runs for a number of iterations equal to the sum of the lengths of the two lists. All other work is constant, so the overall complexity is linear.
// Space complexity : O(1)O(1)
// The iterative approach only allocates a few pointers, so it has a constant overall memory footprint.
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var head = ListNode(0)
        
        var node = head
        var l1 = l1
        var l2 = l2
        while l1 != nil, l2 != nil {
            if l1!.val > l2!.val {
                node.next = l2
                l2 = l2!.next
            } else {
                node.next = l1
                l1 = l1!.next
            }
            node = node.next!
        }
        
        if l1 == nil {
            node.next = l2
        }
        
        if l2 == nil {
            node.next = l1
        }
        
        return head.next
    }
}

// Solution 2: Recursive
// recursive merge 2 lists
// 
// Time Complexity: O(m+n)
// Space Complexity: O(m+n)
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil { return l2 }
        if l2 == nil { return l1 }
        if l1!.val < l2!.val {
            l1!.next = mergeTwoLists(l1!.next, l2)
            return l1
        }
        l2!.next = mergeTwoLists(l1, l2!.next)
        return l2
    }
}
